
# coding: utf-8

# In[ ]:

#Libreria carga de datos
import csv
with open('profeco/all_data.csv','r') as fileinput:
    with open('all_data.psv','w') as fileoutput: 
        csv_reader = csv.DictReader(fileinput)
        csv_salida = csv.DictWriter(fileoutput,csv_reader.fieldnames, delimiter='|')
        csv_salida.writeheader()
        csv_salida.writerows(csv_reader)

