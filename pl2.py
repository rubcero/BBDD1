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
    print("-" * 50)
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

def consulta_personalizada(conn):
    cursor = conn.cursor()
    
    print("\n--- CONSULTA SQL PERSONALIZADA ---")
    print("Escribe una sentencia SQL (SELECT, INSERT, UPDATE, DELETE...)")
    print("O escribe 'exit' para volver al menú.\n")

    while True:
        sql = input("SQL> ")

        if sql.lower() == "exit":
            print("Saliendo de la consola SQL...\n")
            break
        
        try:
            cursor.execute(sql)

            # Si es un SELECT, mostrar resultados
            if sql.strip().lower().startswith("select"):
                filas = cursor.fetchall()
                print("\nResultados:")
                for fila in filas:
                    print(fila)
                print()
            else:
                conn.commit()
                print("Consulta ejecutada correctamente.\n")

        except Exception as e:
            print(f"Error al ejecutar la consulta: {e}\n")



def menu():
    print("\n=== MENÚ FÓRMULA 1 ===")
    print("1. Mostrar nº de grandes premios por circuito")
    print("2. Insertar nuevo Gran Premio")
    print("3. Insertar resultado de un Gran Premio")
    print("4. Consulta personalizada")
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
            try:
                ejecutar_consulta(conn, consulta)
            except Exception as e:
                print("Error ejecutando la consulta:", e)

        elif opcion == "2" or opcion == "3":
            Nombre = input("Nombre del GP: ")
            CircuitoRef = int(input("id_circuito: "))
            IdGranPremio = int(input("id_gran_premio: "))
            Ronda = int(input("Ronda: "))
            FechaHora = input("Fecha y hora (YYYY-MM-DD): ")
            Url= input("URL: ")

            try:
                insertar_gran_premio(conn, IdGranPremio, Nombre, Ronda, FechaHora, Url, CircuitoRef)
            except Exception as e:
                print("Error al insertar el GP:", e)

        elif opcion == "4":
            consulta = input("Escribe tu consulta SQL personalizada: ")
            try:
                ejecutar_consulta(conn, consulta)
            except Exception as e:
                print("Error ejecutando la consulta:", e)
        
        elif opcion == "0":
            break
        else:
            print("Opción no válida")

    conn.close()

