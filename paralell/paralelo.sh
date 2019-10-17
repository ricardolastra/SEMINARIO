#!/bin/sh
echo "Descarga en paralelo....no se va a tardar....espera...."
#Descargamos como en clase de reposición del sabado.
curl "http://data.gdeltproject.org/events/index.html" | grep -E -o '20170[1-6][0-9][0-9].export.CSV.zip' | sort | uniq | parallel -j+0 wget '"http://data.gdeltproject.org/events/'{}'"'
echo "Se descargaron los primeros 6 meses del ano 2017 tal como se solicito"
#Se crea el archivo TSV con el comando md5sum, revise la siguiente bibliografia:https://www.tutorialspoint.com/unix_commands/md5sum.htm
md5sum *.zip > analitica.tsv
echo "Se ha descargado con md5sum la analitica de los archivos"
#Descargar archivo y calcular columnas
echo "Descargamos el archivo lookups..."
curl "https://www.gdeltproject.org/data/lookups/CSV.header.dailyupdates.txt" > CSV.header.dailyupdates.txt
echo "Calculamos las columnas..."
NUMCOLS=$(head -1 CSV.header.dailyupdates.txt | wc -w)
echo "El archivo debe tener: $NUMCOLS"