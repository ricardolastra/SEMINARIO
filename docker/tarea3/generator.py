import os
import json
import click
import pika
import time
import numpy as np


# Parámetros para nuestra mezcla de gaussianas
A_PARAMS = (150, 20)
B_PARAMS = (270, 20)
X_PARAMS = (200, 20)
BIAS_PARAMS = (300, 20)


def get_connection_params():
    user = os.environ["RABBIT_USER"]
    password = os.environ["RABBIT_PASSWORD"]
    credentials = pika.credentials.PlainCredentials(user, password)

    host = os.environ.get("RABBIT_HOST", "localhost")
    port = os.environ.get("RABBIT_PORT", 5672)
    
    return pika.ConnectionParameters(host=host, port=port, credentials=credentials)


def sim_next(beta_c, beta_x):
    if np.random.randint(2):
        c_params = A_PARAMS
        label = "A"
    else:
        c_params = B_PARAMS
        label = "B"

    category = np.random.normal(*c_params)
    x = np.random.normal(*X_PARAMS)
    bias = np.random.normal(*BIAS_PARAMS)

    y = bias + beta_c*category + beta_x*x
    
    datum = {"c": label, "x": x, "y": y}
    return datum


@click.command()
@click.option('--seed', type=int)
def main(seed):
    # Espera un minuto para que este listo el host de rabbit (Hay mejores maneras de hacer esto!)
    time.sleep(60)    

    # Genera coeficientes dependiendo de la semilla
    np.random.seed(seed)
    beta_c, beta_x = 3*np.random.normal(0, 20, size=2)
    print("beta_c: {}, beta_x: {}".format(beta_c, beta_x))

    # Resetea la semilla
    np.random.seed()
    connection_params = get_connection_params()
    connection = pika.BlockingConnection(connection_params)
    channel = connection.channel()
    channel.queue_declare('data_stream')
    while True:
        wait = np.random.exponential(3)
        print("Waiting for {:2f} seconds".format(wait))
        time.sleep(wait)
        next_datum = sim_next(beta_c, beta_x)
        print("x: {x:.2f}, category: {c}, y: {y}".format(**next_datum))
        channel.basic_publish(exchange='', routing_key='data_stream', body=json.dumps(next_datum))


if __name__ == "__main__":
    main()
 
