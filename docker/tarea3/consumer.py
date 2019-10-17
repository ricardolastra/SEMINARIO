import os
import time
import click
import json
import pika
import psycopg2


# Parametros para nuestra mezcla de gaussianas
A_PARAMS = (150, 60)
B_PARAMS = (270, 50)
X_PARAMS = (200, 40)
BIAS_PARAMS = (300, 30)


def get_connection_params():
    user = os.environ["RABBIT_USER"]
    password = os.environ["RABBIT_PASSWORD"]
    credentials = pika.credentials.PlainCredentials(user, password)

    host = os.environ.get("RABBIT_HOST", "localhost")
    port = os.environ.get("RABBIT_PORT", 5672)
    
    return pika.ConnectionParameters(host=host, port=port, credentials=credentials)


@click.command()
@click.option('--pg_user')
@click.option('--pg_password')
@click.option('--pg_host')
@click.option('--pg_database')
@click.option('--pg_port')
def consume(pg_user, pg_password, pg_host, pg_database, pg_port):
    # Espera un minuto a que esté listo rabbit y postgres (Hay mejores maneras de hacer esto!)
    time.sleep(60)

    # Conectandonos a postgres
    pg_conn = psycopg2.connect(user=pg_user, password=pg_password, host=pg_host, database=pg_database, port=pg_port)
    cursor = pg_conn.cursor()

    # Creando tabla si no existe ya 
    cursor.execute('CREATE TABLE IF NOT EXISTS data(x numeric, c varchar(1), y numeric)')
    pg_conn.commit()
    def callback(ch, method, properties, body):
        # Este es el callback para el consumidor de rabbit, inserta nuestro dato en postgres
        datum = json.loads(body)
        print("Encontrado mensaje! Insertando... ({x}, {c}, {y})".format(**datum))
        query = "INSERT INTO data(x, c, y) VALUES ({x}, '{c}', {y})".format(**datum)
        cursor = pg_conn.cursor()
        cursor.execute(query)
        pg_conn.commit()

    # Conexion a rabbit
    connection_params = get_connection_params()
    pika_conn = pika.BlockingConnection(connection_params)
    channel = pika_conn.channel()

    # Inicializa consumidor
    channel.queue_declare('data_stream')
    channel.basic_consume(callback, queue='data_stream')
    channel.start_consuming()


if __name__ == "__main__":
    consume()
