#!/bin/sh
echo $1
echo "_________Documentacion de comandos________"
echo $1
echo "-----Procesando en serie:"
echo $1
echo "El primer for loop unzipea todos los archivos .zip descargados sin las columnas 3,27 y 31. Regresa el numero de caracteres del string S2."
echo "Aun en el lopp con AWK hace substrings de los eventos y las goldstein_scales, finalmente el loop imprime los eventos y sus respectivas goldstein_scale."
echo "Finalmente con awk vuelve a imprimir los substrings pero los ordena de forma de lista por las llaves k1 y k2."
echo $1
echo "-----Procesando en Paralelo:"
echo $1
echo "Con el comando 'find' busca todos los archivos .zip, el -j100% indica que se usan todos los recursos (cores)  y el -0 es todos, posteriormente los unzipea, los descarga sin las columnas 3,27 y 31 y hace el substring por el numero de caracteres de S2."
echo "Con awk se realiza un substring de eventos y la goldstain_scale."
echo "Y finalmente con awk vuelve a imprimir los substrings pero los ordena de forma de lista por las llaves k1 y k2."
echo $1
echo "Concluimos que el pensar en paralelo es totalmente diferente que en forma secuencial, se debe tener cuidado con la sintaxis en bash ya que un solo carter en una posicion incorrecta nos puede dar un gran dolor de cabeza."
echo $1
#Referencias de TODA la tarea 2 de CLI: 
#https://www.tutorialspoint.com/unix_commands/md5sum.htm
#https://stackoverflow.com/questions/2920416/configure-bin-shm-bad-interpreter
#https://hub.docker.com/r/frankyan/gatk-tutorial/  "Imagen para poder correr codigo en paralelo en Docker"
#https://stackoverflow.com/questions/7610507/find-and-ls-with-gnu-parallel