import psycopg2
from psycopg2 import sql
import getpass

def conectar(usuario, password):
    conn = psycopg2.connect(
        dbname="pl1",
        user=usuario,
        password=password,
        host="localhost",
        port=2222
    )
    return conn

def ejecutar_consulta(conn, consulta, params=None):
    cur = conn.cursor()
    cur.execute(consulta, params or ())
    filas = cur.fetchall()
    colnames = [desc[0] for desc in cur.description]

    print(" | ".join(colnames))
    print("-" * 80)
    for f in filas:
        print(" | ".join(str(x) for x in f))

    cur.close()

def insertar_gran_premio(conn, IdGranPremio, Nombre, Ronda, FechaHora, Url, CircuitoRef):
    cur = conn.cursor()
    cur.execute(
        """
        INSERT INTO GranPremio ( IdGranPremio, Nombre, Ronda, FechaHora, Url, CircuitoRef)
        VALUES (%s, %s, %s, %s, %s, %s)
        RETURNING IdGranPremio;
        """,
        ( IdGranPremio, Nombre, Ronda, FechaHora, Url, CircuitoRef)
    )
    id_gp = cur.fetchone()[0]
    conn.commit()
    cur.close()
    print(f"Gran Premio insertado con id_gp = {IdGranPremio}")
    return IdGranPremio

def menu():
    print("\n=== MENÚ FÓRMULA 1 ===")
    print("1. Nº de Grandes Premios por circuito")
    print("2. Insertar nuevo Gran Premio")
    print("3. Insertar resultado de un Gran Premio")
    print("4. Consulta personalizada")
    print("5. Listado de todos los circuitos y nº de GP")
    print("6. Grandes Premios corridos y puntos de Ayrton Senna")
    print("7. Pilotos nacidos después de 1999 y nº de carreras")
    print("8. Escuderías españolas/italianas y nº de GP")
    print("9. Ver vista Pilotos por temporada")
    print("10. Ganadores por temporada 2010–2015")
    print("11. Pilotos que han ganado al menos un GP")
    print("12. Nº de GP por país")
    print("13. Piloto con la vuelta más rápida de la historia")
    print("0. Salir")
    return input("Opción: ")

if __name__ == "__main__":
    user = input("Usuario BD: ")
    password = getpass.getpass("Contraseña: ")

    conn = conectar(user, password)

    while True:
        opcion = menu()

        if opcion == "1":
            consulta = """
                SELECT  c.Nombre AS circuito,
                        COUNT(g.IdGranPremio) AS num_grandes_premios
                FROM    Circuito c
                LEFT JOIN GranPremio g
                       ON g.CircuitoRef = c.CircuitoRef
                GROUP BY c.CircuitoRef, c.Nombre
                ORDER BY num_grandes_premios DESC;
            """
            ejecutar_consulta(conn, consulta)

        elif opcion == "2" or opcion == "3":
            Nombre = input("Nombre del GP: ")
            CircuitoRef = int(input("id_circuito: "))
            IdGranPremio = int(input("id_gran_premio: "))
            Ronda = int(input("Ronda: "))
            FechaHora = input("Fecha y hora (YYYY-MM-DD): ")
            Url= input("URL: ")

            insertar_gran_premio(conn, IdGranPremio, Nombre, Ronda, FechaHora, Url, CircuitoRef)

        elif opcion == "4":
            consulta = input("Escribe tu consulta SQL personalizada: ")
            try:
                ejecutar_consulta(conn, consulta)
            except Exception as e:
                print("Error:", e)

        # ---------- OPCIONES NUEVAS ----------

        elif opcion == "5":
            consulta = """
                SELECT 
                    c.Nombre AS Circuito,
                    COUNT(gp.IdGranPremio) AS Num_GrandesPremios
                FROM Circuito c
                LEFT JOIN GranPremio gp ON gp.CircuitoRef = c.CircuitoRef
                GROUP BY c.Nombre
                ORDER BY Num_GrandesPremios DESC;
            """
            ejecutar_consulta(conn, consulta)

        elif opcion == "6":
            consulta = """
                SELECT 
                    p.Nombre || ' ' || p.Apellido AS Piloto,
                    COUNT(DISTINCT c.IdGranPremio) AS GrandesPremios_Corridos,
                    SUM(CAST(c.Puntos AS NUMERIC)) AS Total_Puntos
                FROM Corre c
                JOIN Piloto p ON c.PilotoRef = p.PilotoRef
                WHERE p.Nombre ILIKE 'Ayrton' AND p.Apellido ILIKE 'Senna'
                GROUP BY p.Nombre, p.Apellido;
            """
            ejecutar_consulta(conn, consulta)

        elif opcion == "7":
            consulta = """
                SELECT 
                    p.Nombre,
                    p.Apellido,
                    COUNT(DISTINCT c.IdGranPremio) AS Num_Carreras
                FROM Piloto p
                LEFT JOIN Corre c ON p.PilotoRef = c.PilotoRef
                WHERE p.F_nac > '1999-12-31'
                GROUP BY p.Nombre, p.Apellido
                ORDER BY Num_Carreras DESC;
            """
            ejecutar_consulta(conn, consulta)

        elif opcion == "8":
            consulta = """
                SELECT 
                    e.Nombre AS Escuderia,
                    e.Nacionalidad,
                    COUNT(DISTINCT c.IdGranPremio) AS Num_GrandesPremios
                FROM Escuderia e
                JOIN Corre c ON e.Id_escuderia = c.EscuderiaId
                WHERE e.Nacionalidad ILIKE 'Spanish' 
                   OR e.Nacionalidad ILIKE 'Italian'
                GROUP BY e.Nombre, e.Nacionalidad
                ORDER BY Num_GrandesPremios DESC;
            """
            ejecutar_consulta(conn, consulta)

        elif opcion == "15":
            cursor = conn.cursor()
            cursor.execute("""
                CREATE OR REPLACE VIEW Vista_Pilotos_Temporada AS
SELECT 
    t.a¤o,
    p.PilotoRef,
    p.Nombre || ' ' || p.Apellido AS Piloto,
    SUM(CAST(c.Puntos AS NUMERIC)) AS Total_Puntos
FROM Corre c
JOIN Piloto p ON c.PilotoRef = p.PilotoRef
JOIN GranPremio gp ON c.IdGranPremio = gp.IdGranPremio
JOIN Temporada t ON gp.a¤o = t.a¤o
GROUP BY t.a¤o, p.PilotoRef, p.Nombre, p.Apellido
ORDER BY t.a¤o, Total_Puntos DESC;

SELECT * FROM Vista_Pilotos_Temporada;

            """)
            conn.commit()
            print("Vista creada correctamente.")

        elif opcion == "9":
            ejecutar_consulta(conn, "SELECT * FROM Vista_Pilotos_Temporada;")

        elif opcion == "10":
            consulta = """
                SELECT vp.a¤o, vp.Piloto, vp.Total_Puntos
FROM Vista_Pilotos_Temporada vp
WHERE vp.a¤o BETWEEN 2010 AND 2015
  AND vp.Total_Puntos = (
        SELECT MAX(vp2.Total_Puntos)
        FROM Vista_Pilotos_Temporada vp2
        WHERE vp2.a¤o = vp.a¤o
    )
ORDER BY vp.a¤o;
            """
            ejecutar_consulta(conn, consulta)

        elif opcion == "11":
            consulta = """
                SELECT DISTINCT p.Nombre || ' ' || p.Apellido AS Piloto
                FROM Corre c
                JOIN Piloto p ON p.PilotoRef = c.PilotoRef
                WHERE c.Posicion = 1;
            """
            ejecutar_consulta(conn, consulta)

        elif opcion == "12":
            consulta = """
                SELECT 
                    c.Pais,
                    COUNT(gp.IdGranPremio) AS Num_GrandesPremios
                FROM GranPremio gp
                JOIN Circuito c ON c.CircuitoRef = gp.CircuitoRef
                GROUP BY c.Pais
                ORDER BY Num_GrandesPremios DESC;
            """
            ejecutar_consulta(conn, consulta)

        elif opcion == "13":
            consulta = """
                SELECT  p.Nombre,
                        p.Apellido,
                        v.Tiempo
                FROM Piloto p
                JOIN HaceVueltas hv
                  ON hv.PilotoRef = p.PilotoRef
                JOIN Vuelta v
                  ON v.IdVuelta = hv.IdVuelta
                WHERE v.Tiempo = (
                        SELECT MIN(v2.Tiempo)
                        FROM Vuelta v2
                      );
            """
            ejecutar_consulta(conn, consulta)

        elif opcion == "0":
            break

        else:
            print("Opción no válida")

    conn.close()
