
# coding: utf-8

# # Request (tipo curl)
# 
# * Request es la biblioteca en python para hacer peticiones HTTP.
# * Puedo hacer programáticamente una petición con:
#     * Headers.
#     
#     * Body.
#     
#     * Tipo de petición.
#     
#     * Manejo de sesión (cookies).
#     
# * Al crear una petición, se genera un objeto con los siguientes atributos:
# 
#     * status code
#         Código de respuesta de la petición. Existe un universo finito de códigos que pueden revisar en wikipedia (https://es.wikipedia.org/wiki/Anexo:C%C3%B3digos_de_estado_HTTP).
#         
#     * encoding
#         Codificación original de la página web. 
#         ISO-8859-1 es el famosísimo Windows.
#         UTF-8 existe en linux.
#         
#     * headers
#         Encabezados de la petición web. Así como nosotros agregamos encabezados al realizar peticiones, el servidor hace lo mismo.
#         
#     * text
#         El HTML/JSON/lo que se regresa en el body del paquete.

# In[ ]:

import requests
r  = requests.get("http://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do?sector=18&accion=consultarCuadro&idCuadro=CF300&locale=es")


# In[ ]:

r.status_code


# In[ ]:

r.encoding


# ### ¿Que información nos regresa los headers del servidor?

# In[ ]:

r.headers


# In[ ]:

r.text


# # BeautifulSoup (BS4)
# 
# * Parser mágico en Python.
# 
# * Transforma una cadena de texto con HTML a un objeto en el cual podemos buscar, iterar, modificar.
# 
# * Pueden revisar la documentación en https://www.crummy.com/software/BeautifulSoup/bs4/doc/.
# 
# * Requests + BS4 son parte del navaja suiza. 
# 

# In[ ]:

from bs4 import BeautifulSoup


r  = requests.get("http://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do?sector=18&accion=consultarCuadro&idCuadro=CF300&locale=es")

data = r.text

soup = BeautifulSoup(data)

for link in soup.find_all('a'):
    print(link.get('href'))


# In[ ]:

r  = requests.get("http://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do?sector=18&accion=consultarCuadro&idCuadro=CF300&locale=es")

data = r.text

soup = BeautifulSoup(data,"lxml")

for link in soup.find_all('a'):
    print(link.get('href'))


# In[ ]:

soup.find_all('input')


# In[ ]:

for html_input in soup.find_all('input'):
    if html_input['type']=='checkbox':
        print(html_input)


# In[ ]:

for html_input in soup.find_all('input'):
    if html_input['type']=='checkbox':
        try:
            if html_input['value'][:2]=='SF':
                print(html_input['value'])
        except:
            print(html_input.attrs)


# In[ ]:

for html_input in soup.find_all('input',{'value':True}):
    if html_input['type']=='checkbox' and html_input['value'][:2]=='SF':
        print(html_input['value'])


# In[ ]:

checkboxes = []
for html_input in soup.find_all('input',{'value':True}):
    if html_input['type']=='checkbox' and html_input['value'][:2]=='SF':
        checkboxes.append(html_input['value'])
print(checkboxes)
#data.extend(checkboxes)


# In[ ]:

[ html_input['value']  for html_input in soup.find_all('input',{'value':True}) if html_input['type']=='checkbox' and html_input['value'][:2]=='SF']


# # Ejercicio
# 
# 1. Completa el ejercicio en Python de la siguiente manera.
#     1. Descarga un archivo CSV con todas las Series que existen en la página web para los años 2015-2017.
#         2. Ejemplo de archivo esperado. 
#         ```
#         "Fecha","SF45422","SF45438","SF45439","SF45470","SF45423"....
#         16/05/2015,27.000000,9.956650,9.956650,5.805165,90.000000
#         19/05/2015,24.000000,9.961733,9.961733,5.762100,87.000000
#         20/05/2015,23.000000,9.965181,9.965181,5.468973,86.000000
#         21/05/2015,22.000000,9.968039,9.968039,5.246751,85.000000
#         22/05/2015,28.000000,9.960956,9.960956,5.039620,91.000000
#         23/05/2015,27.000000,9.962875,9.962875,4.968445,90.000000
#         ```
#     La salida esperada es un archivo .py.
#     
# 2. Repite el ejercicio 1.1 anterior desde shell. 
#     1. Busca los valores del checkbox.
#     2. Formatea el url para pedir los archivos csv
#     3. Haz la petición con curl y genera el archivo CSV de salida.
#     4. Modifica la codifiación del archivo CSV a utf-8.
#     
#     La salida esperada es un archivo Bash.

# In[ ]:

class n_auction(object):
    def __init__(self):
        self.search_request = {'idCuadro':'CF300',
             'sector':'18',
             'version':'3',
             'locale':'es',
             'anoInicial':'2015',
             'anoFinal':'2017',
             'tipoInformacion': '',
             'formatoCSV.x':'41',
             'formatoCSV.y':'20',
             'formatoHorizontal':'false',
             'metadatosWeb':'true'
                              }

        self.headers = {'Host':'www.banxico.org.mx',
                        'Accept':'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
                        'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:57.0) Gecko/20100101 Firefox/57.0',
                        'Referer':'http://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do sector=18&accion=consultarCuadro&idCuadro=CF300&locale=es',
                        'Content-Type':'application/x-www-form-urlencoded',
                        'Cookie':'JSESSIONID=2a3c0c3548c3355760e517e07b16; TS01b274c3=0189f484afd3ff77421e673fa6176d68eb4e0141c552bebd21371f8296fbb353a9e01a326fc9bcb372a1ea407e1ea405ee46908da154fb691a4bca27d26185e0fee4641752; test1=642664106.36895.0000; TS014a759c=0189f484afdfa6718b0e6f8d0e1f10a034ccb3aa2752bebd21371f8296fbb353a9e01a326fb730d18d4d6d1f597f6d1cb5d618b911e67630d7cbb907b332fffd745351ced0; ORF_wwwBanx=2505459370.20480.0000',
                        'Connection':'keep-alive',
                        'Upgrade-Insecure-Requests':'1'
                       }
       

    def scrape(self, max_pages):
 
        #page_nu = 0
        #self.search_request['start'] = page_nu
        #while page_nu < max_pages:
            #payload = json.dumps(self.search_request)
        r2 = requests.get('http://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do?accion=consultarSeries', headers=self.headers,data=self.search_request) # headers=self.headers, params=params 
        print(r2)


        #s = BeautifulSoup(r2.text, 'html.parser')
        #print(s)

if __name__ == '__main__':
    scraper = n_auction()
    scraper.scrape(1)


# In[ ]:

r2 = r2.text.encode('utf-8')
r2 = r2.text.split("\r\n")
r2 = r2[17:len(r2)]

#...continuo con liempieza y generacion de .csv pero no se por que obtengo Status 400
#...modifique varias veces el User-Agent para parecer algo normal ante el servidor, pero no funciono

