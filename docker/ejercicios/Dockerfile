# Ubuntu con Python 3.5.1
#Ejercicio Dockerfile DIY
#Crea una imagen de ubuntu con python 3.5 de dos maneras distintas
#pull imagen base
FROM ubuntu
#traemos el archivo de python
COPY holamundo.py /
#Instalar python dentro de la imagen
RUN apt-get update 
RUN apt-get install -y build-essential python3=3.5.1*
CMD ["python", "-u", "holamundo.py" ]
ENTRYPOINT ["/bin/bash"]