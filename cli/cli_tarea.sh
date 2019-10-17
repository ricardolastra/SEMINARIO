#!/bin/bash 

echo "Inicio..."

#Descargamos el archivo de profeco con Python
python descarga.py

#Descomprimimos el archivo y pasamos a CSV
unzip profeco.zip -d profeco

#Leemos para seleccionar columnas
python open_csv2.py

echo "Bash..."

#Creamos archivo delimitado por pipes con columnas seleccionadas
awk 'BEGIN {FS="|"}{print $1, $4, $6, $7, $8, $14, $15}' all_data.psv > sub_set.psv

#Creamos documento con primeros 1000 renglones
head -n1000 sub_set.psv > head.psv

#echo "Validamos..."

#validamos que sean los renglones y columnas seleccionadas
#head -n1000 sub_set.psv |awk 'BEGIN{FS="|"}{print NF}' | sort -n | uniq -c

#Creamos documento con los ultimos 1000 renglones
tail -n1001 sub_set.psv > tail.psv

#Creamos documento con ambas salidas del head y tail
cat head.psv tail.psv > final.psv

echo "...Fin"

#Ref:
#https://docs.python.org/3/library/csv.html
#https://developers.google.com/drive/v3/web/manage-downloads