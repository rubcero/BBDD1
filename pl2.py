import psycopg2
from psycopg2 import sql
import getpass

def conectar(usuario, password):
    conn = psycopg2.connect(
        dbname="postgres",
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
    print("-" * 50)
    for f in filas:
        print(" | ".join(str(x) for x in f))

    cur.close()

def insertar_gran_premio(conn, nombre, id_circuito, id_temporada, fecha):
    cur = conn.cursor()
    cur.execute(
        """
        INSERT INTO GranPremio (nombre, id_circuito, id_temporada, fecha)
        VALUES (%s, %s, %s, %s)
        RETURNING id_gp;
        """,
        (nombre, id_circuito, id_temporada, fecha)
    )
    id_gp = cur.fetchone()[0]
    conn.commit()
    cur.close()
    print(f"Gran Premio insertado con id_gp = {id_gp}")
    return id_gp

def insertar_resultado(conn, id_gp, id_piloto, posicion, puntos):
    cur = conn.cursor()
    cur.execute(
        """
        INSERT INTO Corre (id_gp, id_piloto, posicion, puntos)
        VALUES (%s, %s, %s, %s);
        """,
        (id_gp, id_piloto, posicion, puntos)
    )
    conn.commit()
    cur.close()
    print("Resultado insertado correctamente")

def menu():
    print("\n=== MENÚ FÓRMULA 1 ===")
    print("1. Mostrar nº de grandes premios por circuito")
    print("2. Insertar nuevo Gran Premio")
    print("3. Insertar resultado de un Gran Premio")
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
                SELECT  c.nombre AS circuito,
                        COUNT(g.id_gp) AS num_grandes_premios
                FROM    Circuito c
                LEFT JOIN GranPremio g
                       ON g.id_circuito = c.id_circuito
                GROUP BY c.id_circuito, c.nombre
                ORDER BY num_grandes_premios DESC;
            """
            try:
                ejecutar_consulta(conn, consulta)
            except Exception as e:
                print("Error ejecutando la consulta:", e)

        elif opcion == "2":
            nombre = input("Nombre del GP: ")
            id_circuito = int(input("id_circuito: "))
            id_temporada = int(input("id_temporada: "))
            fecha = input("Fecha (YYYY-MM-DD): ")

            try:
                insertar_gran_premio(conn, nombre, id_circuito, id_temporada, fecha)
            except Exception as e:
                print("Error al insertar el GP:", e)

        elif opcion == "3":
            id_gp = int(input("id_gp del GP: "))
            id_piloto = int(input("id_piloto: "))
            posicion = int(input("Posición: "))
            puntos = int(input("Puntos: "))

            try:
                insertar_resultado(conn, id_gp, id_piloto, posicion, puntos)
            except Exception as e:
                print("Error al insertar el resultado:", e)

        elif opcion == "0":
            break
        else:
            print("Opción no válida")

    conn.close()

