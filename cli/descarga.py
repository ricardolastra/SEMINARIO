
# coding: utf-8

# In[8]:

#BY RICARDO LASTRA
#IMPORTAMOS LIBRERIAS (SE INTENTARON OTRAS FORMAS DE DESCARGA Y NO FUNCIONO)

#import httplib2
#import pprint
#import apiclient.http


# In[24]:

#FUNCIONES
#Existe un parametro extra en la URL llamado "confirm", el cual su valor, debe ser el de una cookie especifica aqui esta la magia.
import requests #lIBRERIA MUY BUENAZAAAA!!!

def download_file_from_google_drive(id, destination):
    def get_confirm_token(response):
        for key, value in response.cookies.items():
            if key.startswith('download_warning'):
                return value

        return None

    def save_response_content(response, destination):
        CHUNK_SIZE = 32768

        with open(destination, "wb") as f:
            for chunk in response.iter_content(CHUNK_SIZE):
                if chunk: # filtra todos los chunks
                    f.write(chunk)

    URL = "https://docs.google.com/uc?export=download"

    session = requests.Session()

    response = session.get(URL, params = { 'id' : id }, stream = True)
    token = get_confirm_token(response)

    if token:
        params = { 'id' : id, 'confirm' : token }
        response = session.get(URL, params = params, stream = True)

    save_response_content(response, destination)    


if __name__ == "__main__":
    import sys
    if len(sys.argv) is not 3:
        print("Usage: python google_drive.py drive_file_id destination_file_path")
    else:
        # TOMAMOS EL ID DE LA INSPECCION EN LA PARTE DE "DOC">HEADERS>QUERY STRING PARAMETERS>id:
        file_id = '0B-4W2dww7ELNazFfOFVhNG5vckE'
        # ARCHIVO DESTINO EN SSD
        destination = 'profeco.zip'
        download_file_from_google_drive(file_id, destination)

