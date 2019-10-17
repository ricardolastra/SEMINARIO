#!/bin/bash

#Obtenemos datos como en clase
curl 'http://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do?sector=18&accion=consultarCuadro&idCuadro=CF300&locale=es' | grep -E 'SF[0-9]{5}' -o | sort | uniq >> SFs
#Link con los checks
Link='http://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do?accion=consultarSeries'
datos='idCuadro=CF300&sector=18&version=3&locale=es&formatoCSV.x=41&formatoCSV.y=20&anoInicial=2015&anoFinal=2017&tipoInformacion=&formatoHorizontal=false&metadatosWeb=true'
s=""  
#loop como en clase
for x in `cat SFs`; do
s+="&series="$x
done;
datos+=$s
#quitamos encabezado par que quede como se solicito
curl $Link --data $datos | awk 'NR > 17 { print }' > file.csv
#convertimos encoding, notese que uso windows
iconv -f "windows-1252" -t "UTF-8" file.csv -o new_file.csv
#Gracias