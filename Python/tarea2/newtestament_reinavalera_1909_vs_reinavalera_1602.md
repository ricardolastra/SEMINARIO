
# Estilometria para Bilia Reina Valera version 1602 y 1909


```python
#Librerias para estilometria
import requests
import urllib.request
import re
import collections
import numpy
import string
import pandas as pd
from string import punctuation
from collections import Counter
import estilo as es #IMPORTAMOS LIBRERIA DE FUNCIONES DE ESTILOMETRIA .PY
```

### El objetivo es hacer una comparacion de texto que sea interesante entre 2 libros. Por este motivo se seleccionaron 2 versiones de la Biblia version reina valera, la cual es la mas exacta de los libros sagrados. 

### Irving, se que el comparativo era de 2 autores, pero me parecio relevante hacerlo entre 2 versiones de libros, y que mejor entre libros tan importantes como la Biblia!

## Primer libro


```python
#Descargamos primer libro en .txt y lo guardamos en libro
#En este caso sera: Reina Valera New Testament of the Bible 1909
with urllib.request.urlopen("http://www.gutenberg.org/cache/epub/5881/pg5881.txt") as url:
    libro = url.read()
libro = libro.decode("utf-8-sig")
```


```python
#Quitamos el inicio y fin de los comentarios del proyecto "Reina Valera New Testament of the Bible 1909"
libro = libro[3900:-20824]#Quitamos los r\n's
#libro = libro.replace("\r\n", " ")
```

## Segundo libro


```python
#Descargamos segundo libro en .txt y lo guardamos en libro
#En este caso sera: Reina Valera New Testament of the Bible 1602
with urllib.request.urlopen("https://www.gutenberg.org/files/5877/5877-0.txt") as url1:
    libro1 = url1.read()
libro1 = libro1.decode("utf-8-sig")
```


```python
#Quitamos el inicio y fin de los comentarios del proyecto "Reina Valera New Testament of the Bible 1602"
libro1 = libro1[4760:-19150]#Quitamos los r\n's
#libro1 = libro1.replace("\r\n", " ")
```

### Aplicamos las funciones al primer libro


```python
# divide el texto en parrafos
strs_total=es.divide_parrafos(libro)
# longitud del parrafo (num palabras)
strs_total_parrafo=es.lon_parrafo(strs_total)
# longitud promedio de palabras
promedio_palabras=es.lon_palabra(strs_total)
# num palabras promedio por oracion
strs_total_prom=es.lon_prom_oracion(strs_total_parrafo)
# num de signos de puntuacion
punctuation_counts=es.total_punt(libro)
# regresa un dataframe con las variables anteriores
es.estructura_texto(strs_total_parrafo,promedio_palabras,strs_total_prom,punctuation_counts)
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Longitud del parrafo</th>
      <th>Longitud prom_palabras</th>
      <th>Num palabras_prom ora</th>
      <th>Num signos punt</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>18.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>8.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>19.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>15.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>14.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>5</th>
      <td>12.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>18.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>7</th>
      <td>14.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>8</th>
      <td>16.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>9</th>
      <td>18.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>10</th>
      <td>11.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>11</th>
      <td>23.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>12</th>
      <td>21.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>13</th>
      <td>27.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>14</th>
      <td>29.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>15</th>
      <td>11.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>16</th>
      <td>18.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>17</th>
      <td>20.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>18</th>
      <td>23.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>19</th>
      <td>13.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>20</th>
      <td>19.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>21</th>
      <td>19.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>22</th>
      <td>21.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>23</th>
      <td>11.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>24</th>
      <td>20.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>25</th>
      <td>22.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>26</th>
      <td>28.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>27</th>
      <td>15.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>28</th>
      <td>26.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>29</th>
      <td>22.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1370</th>
      <td>9.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1371</th>
      <td>14.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1372</th>
      <td>14.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1373</th>
      <td>22.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1374</th>
      <td>25.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1375</th>
      <td>14.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1376</th>
      <td>21.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1377</th>
      <td>25.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1378</th>
      <td>17.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1379</th>
      <td>24.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1380</th>
      <td>26.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1381</th>
      <td>30.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1382</th>
      <td>23.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1383</th>
      <td>14.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1384</th>
      <td>12.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1385</th>
      <td>20.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1386</th>
      <td>12.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1387</th>
      <td>23.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1388</th>
      <td>28.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1389</th>
      <td>12.0</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>!</th>
      <td>NaN</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>9.0</td>
    </tr>
    <tr>
      <th>(</th>
      <td>NaN</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>29.0</td>
    </tr>
    <tr>
      <th>)</th>
      <td>NaN</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>29.0</td>
    </tr>
    <tr>
      <th>,</th>
      <td>NaN</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>2424.0</td>
    </tr>
    <tr>
      <th>.</th>
      <td>NaN</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>1123.0</td>
    </tr>
    <tr>
      <th>:</th>
      <td>NaN</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>770.0</td>
    </tr>
    <tr>
      <th>;</th>
      <td>NaN</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>412.0</td>
    </tr>
    <tr>
      <th>?</th>
      <td>NaN</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>260.0</td>
    </tr>
    <tr>
      <th>[</th>
      <td>NaN</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>149.0</td>
    </tr>
    <tr>
      <th>]</th>
      <td>NaN</td>
      <td>131.177083</td>
      <td>19.738849</td>
      <td>149.0</td>
    </tr>
  </tbody>
</table>
<p>1400 rows × 4 columns</p>
</div>



### Aplicamos las funciones al segundo libro


```python
# divide el texto en parrafos
strs_total=es.divide_parrafos(libro1)
# longitud del parrafo (num palabras)
strs_total_parrafo=es.lon_parrafo(strs_total)
# longitud promedio de palabras
promedio_palabras=es.lon_palabra(strs_total)
# num palabras promedio por oracion
strs_total_prom=es.lon_prom_oracion(strs_total_parrafo)
# num de signos de puntuacion
punctuation_counts=es.total_punt(libro1)
# regresa un dataframe con las variables anteriores
es.estructura_texto(strs_total_parrafo,promedio_palabras,strs_total_prom,punctuation_counts)
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Longitud del parrafo</th>
      <th>Longitud prom_palabras</th>
      <th>Num palabras_prom ora</th>
      <th>Num signos punt</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>13.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>19.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>21.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>16.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>5</th>
      <td>20.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>21.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>7</th>
      <td>16.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>8</th>
      <td>16.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>9</th>
      <td>16.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>10</th>
      <td>16.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>11</th>
      <td>20.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>12</th>
      <td>17.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>13</th>
      <td>16.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>14</th>
      <td>16.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>15</th>
      <td>16.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>16</th>
      <td>20.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>17</th>
      <td>33.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>18</th>
      <td>28.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>19</th>
      <td>16.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>20</th>
      <td>39.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>21</th>
      <td>17.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>22</th>
      <td>19.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>23</th>
      <td>23.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>24</th>
      <td>20.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>25</th>
      <td>17.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>26</th>
      <td>0.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>27</th>
      <td>2.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>28</th>
      <td>0.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>29</th>
      <td>22.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1136</th>
      <td>28.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1137</th>
      <td>29.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1138</th>
      <td>20.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1139</th>
      <td>22.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1140</th>
      <td>29.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1141</th>
      <td>14.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1142</th>
      <td>13.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1143</th>
      <td>15.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1144</th>
      <td>23.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1145</th>
      <td>16.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1146</th>
      <td>9.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1147</th>
      <td>18.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1148</th>
      <td>21.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1149</th>
      <td>23.0</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>#</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>11.0</td>
    </tr>
    <tr>
      <th>,</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>2245.0</td>
    </tr>
    <tr>
      <th>-</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>6.0</td>
    </tr>
    <tr>
      <th>.</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>1034.0</td>
    </tr>
    <tr>
      <th>:</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>539.0</td>
    </tr>
    <tr>
      <th>;</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>34.0</td>
    </tr>
    <tr>
      <th>&lt;</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>1.0</td>
    </tr>
    <tr>
      <th>&gt;</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>1.0</td>
    </tr>
    <tr>
      <th>?</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>166.0</td>
    </tr>
    <tr>
      <th>[</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>243.0</td>
    </tr>
    <tr>
      <th>]</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>241.0</td>
    </tr>
    <tr>
      <th>^</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>79.0</td>
    </tr>
    <tr>
      <th>`</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>2.0</td>
    </tr>
    <tr>
      <th>{</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>1.0</td>
    </tr>
    <tr>
      <th>}</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>3.0</td>
    </tr>
    <tr>
      <th>~</th>
      <td>NaN</td>
      <td>124.702128</td>
      <td>18.923478</td>
      <td>2.0</td>
    </tr>
  </tbody>
</table>
<p>1166 rows × 4 columns</p>
</div>



#### Encuentra si es posible diferenciar entre dos autores distintos usando las variables obtenidas usando el módulo estilo.
#### ¿Qué variables son las más relevantes para los autores que elegiste?

Se observa que el primer libro (version RV1909) contiene mas palabras por parrafo y un mayor numero promedio de palabras. Lo que nos dice que segun la explicacion de  Project Gutenberg para la version de 1602 habia mas faltas de ortografia y las palabras eran de un contexto diferente. Por ello la traduccion que no era tan "exacta" para el año 1602. Desde mi punto de vista el numero de palabras definidas para el año 1602 era un abanico de opciones menor que 300 años despues, lo que nos indica que las traducciones se hacen bajo un contexto contemporaneo en que se realice el trabajo.

Asi mismo pudimos encontrar que habia mas cumulo de signos de puntuacion en la version 1909, sin embargo en la version de 1602 havia mas opciones de simbolos. Esto nos lleva a la conclusion que en la ultima version de la Biblia se optimizaron o codificaron de una forma mas reducida los diferentes tipos de simbolos, agrupando o clusterizando simbolos por similitud, o simplemente descartandolos. Este es un tema interesante ya que en estas traducciones de la Biblia, se observa como en el tiempo se puede ganar o perder informacion!!! Super Interesante!!!!

Elaboro: RICARDO LASTRA 
Fuentes: 

https://stackoverflow.com/questions/29806313/python-access-functions-in-ipython-notebook

https://stackoverflow.com/questions/3895646/number-of-regex-matches

https://stackoverflow.com/questions/1155617/count-occurrence-of-a-character-in-a-string

https://www.gutenberg.org/wiki/Christianity_(Bookshelf)
