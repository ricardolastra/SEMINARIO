
# coding: utf-8

# In[2]:

# imports
import requests
import urllib.request
import re
import collections
import numpy
import string
import pandas as pd
from string import punctuation
from collections import Counter

# funcs
# divide el texto en parrafos
def divide_parrafos(texto):
    strs = texto
    strs_total = re.split(r"\r\n\r\n",strs)
    return strs_total


# longitud del parrafo (num palabras)
def lon_parrafo(parrafo):
    strs_total = pd.DataFrame(parrafo,columns=['versiculo'])
    strs_total_parrafo = strs_total["versiculo"].str.split().str.len()
    return strs_total_parrafo


# longitud promedio de palabras
def lon_palabra(parrafo):
    palabras = Counter(map(len, parrafo))
    cuenta_keys = list(palabras.keys())
    promedio_palabras = numpy.mean(cuenta_keys)
    return promedio_palabras


# num palabras promedio por oracion
def lon_prom_oracion(parrafo):
    strs_total_prom = numpy.mean(parrafo)
    return strs_total_prom


# num de signos de puntuacion
def total_punt(parrafo):
    counts = Counter(parrafo)
    punctuation_counts = {k:v for k, v in counts.items() if k in punctuation}
    return punctuation_counts


# regresa un dataframe con las variables anteriores
def estructura_texto(var1,var2,var3,var4):
    df = pd.DataFrame({'Longitud del parrafo': var1,
                   'Longitud prom_palabras': var2,
                   'Num palabras_prom ora': var3,
                   'Num signos punt': var4
                  })
    return df


# In[ ]:



