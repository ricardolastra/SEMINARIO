#!/bin/sh
echo "Vamos a construir la imagen..."
#Construimos la imagen con docker build a partir de Dockerfile
docker build -t python3:tarea2 .
#Corremos una version interactiva para ejecutar el script.py y nos devuelve el plot en la carpeta seleccionada
docker run --name contenedor1 -v $(pwd)/output:/output/ python3:tarea2 python script.py  --input_file=data/some_points.csv --seed=160167 --output_file=output/plot.png


