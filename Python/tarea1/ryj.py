
# coding: utf-8

# In[1]:

#Librerias
import urllib.request
import re
import collections
import numpy
from string import punctuation
from collections import Counter


# In[3]:

#Descargamos el libro en .txt y lo guardamos en libro
with urllib.request.urlopen("http://www.gutenberg.org/cache/epub/1112/pg1112.txt") as url:
    libro = url.read()
libro = libro.decode("utf-8-sig")


# In[4]:

#Quitamos el inicio y fin de los comentarios del proyecto "Project Gutenberg EBook"
libro = libro[1798:-19133]


# In[5]:

#Quitamos los r\n's
libro = libro.replace("\r\n", " ")


# In[13]:

#1) ¿Cuántas palabras tiene Romeo y Julieta?
strs = libro
strs_total = re.split(r'[^A-Za-z]+',strs)
x1 = len(strs_total)
x1


# In[14]:

#2) ¿Cuántas de ellas son únicas?
#Cuenta total por palabra
cuenta = collections.Counter(strs_total)
#Pasamos a lista los totales
cuenta_lista = list(cuenta.values())
#Contamos las palabras que aparecen 1 vez o que son únicas
x2 = cuenta_lista.count(1)
x2


# In[15]:

#3) ¿Cuál es el número de caracteres promedio por oración (entre punto y punto) ?
strs = libro
strs_total = re.split(r'(?<=[^A-Z].[.?]) +(?=[A-Z])',strs)
palabras = Counter(map(len, strs_total))
cuenta_keys = list(palabras.keys())
x3 = numpy.mean(cuenta_keys)
x3


# In[16]:

#4) ¿Cuál es el promedio de letras por palabra?
strs = libro
strs_total = re.split(r'[^A-Za-z]+',strs)
letras = Counter(map(len, strs_total))
cuenta_keys = list(letras.keys())
x4 = numpy.mean(cuenta_keys)
x4


# In[38]:

#Respuestas a archivo TXT
archivo = open('respuestas.txt', 'w')


# In[39]:

archivo.write("num_pal, " + str(x1) + " unique_pal, " + str(x2) + " mean_char_sen, " + str(x3) + " mean_char_word, " + str(x4))


# In[40]:

archivo.close()


# In[45]:

#Req a archivo TXT
archivo = open('requirements.txt', 'w')


# In[46]:

archivo.write("import urllib.request " 
              " import re " 
              " import collections " 
              " import numpy " 
              " from string import punctuation "  
              " from collections import Counter ")


# In[47]:

archivo.close()


# In[48]:

#Referencias:
#https://stackoverflow.com/questions/17507876/trying-to-count-words-in-a-string
#https://regex101.com/r/nG1gU7/27
#https://docs.python.org/3/tutorial/inputoutput.html

