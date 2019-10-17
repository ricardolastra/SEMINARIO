#-------------------------
#Tarea2. By Ricardo Lastra
#-------------------------
#Construye un Dockerfile para construir una imagen que sea capaz de correr el script tarea2/script.py
#pull imagen base
FROM python:latest
#Traemos el archivo base
COPY data/some_points.csv /
#traemos el archivo de python
COPY script.py /
COPY requirements.txt /
#Instalar librerias de python dentro de la imagen
RUN pip install --no-cache-dir -r requirements.txt 
COPY . .
RUN mkdir output/
CMD ["python", "-u", "script.py" ] > output/plot.png
#Variable de ambiente para graficas tal como en las discuciones del slack
ENV MPLBACKEND="agg"