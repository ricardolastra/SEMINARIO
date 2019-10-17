#!/bin/sh
###------postgres_itam/home-------###
#Elimino la tabla municipios que hemos generado en todas las pruebas
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "DROP TABLE IF EXISTS municipios;";
#Importamos los archivos shp a sql para lectura jajajaja esta madre no funciona!! da error en la relacion schema/tabla
shp2pgsql  -c -W LATIN1 -s 4326 ./CONTINUO_NACIONAL/MUNICIPIOS.shp municipios > municipios.sql
#Generamos el archivo base de SQL
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -f municipios.sql
#Creamos indices segun mega documentacion https://www.postgresql.org/docs/10/static/indexes-multicolumn.html
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "CREATE INDEX test1 ON municipios USING GIST (geom);";
#Limpiamos la basura de los Json's de tweeter
sed "s/'/''/g" stream.jsonl > algo.jsonl
sed -i -e "s/\\\\\"/ /g" algo.jsonl
#Elimino la tabla tweets que hemos generado en todas las pruebas
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "DROP TABLE IF EXISTS tweet;";
#Generamos tabla de tweet's
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "CREATE TABLE tweet(tweet JSONB);";
#Subir los tweets a PostgreSQL: cada línea es un JSON
cat algo.jsonl | while read line
do
   # subir a postgres esa línea
   PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "Insert into tweet values ('$line')";
done
#....se tarda un poco....
#Creamos otros indices para tweet's
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "create index tweet_gin on tweet using gin(tweet);";
#Creamos una columna para pegarle a la tabla tweet las cordenadas del municipios 
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "ALTER TABLE tweet ADD COLUMN coordenadas geometry NULL DEFAULT NULL;";
#Convertir coordenadas en objetos POINT. a la columna ya generada
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "update tweet set coordenadas = ST_SetSRID(ST_MakePoint((tweet->'coordinates'->'coordinates'->>0)::float,(tweet->'coordinates'->'coordinates'->>1)::float),4326);";
#Finalmente genero indice de las coordenadas
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "CREATE INDEX indice_coordenada ON tweet USING GIST (coordenadas);";

