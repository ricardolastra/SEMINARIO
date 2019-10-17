#By Ricardo Lastra, Crime in CDMX, Hoyo del Crimen por Diego Valle
#Instalamos paquetes
install.packages(c(
  'leaflet',
  'ggplot2',
  'dplyr',
  'shinythemes',
  'ggthemes',
  'DT'
))

#Descargamos datos directo de la pagina de Diego

tf <- tempfile()
download.file("https://data.diegovalle.net/hoyodecrimen/cuadrantes.csv.zip", tf)
geodata <- read.csv(unz(tf, "clean-data/crime-lat-long.csv"),
                 header = T)
cuadran <- read.csv(unz(tf, "clean-data/cuadrantes-hoyodecrimen.csv"),
                    header = T)
unlink(tf)

#Subsets
library(dplyr)

cuadran2 <- select(cuadran,crime,year,count,municipio)
cuadran2 <- mutate(cuadran2,count = count + 1)

cuadran3 <- select(cuadran,crime,year,municipio,cuadrante,date,count,sector1,sector2,sector,population,cve_mun)


