#!/bin/sh
#Postgres/postgis by Ricardo Lastra
###------postgres_itam/home-------###
echo "----GENERANDO RESULTADOS----"
echo "...espere un momento"
#PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "Select * FROM tweet LIMIT 2;"
echo "--------TAREA, SECCION DE RESPUESTAS:"> resultados.txt
echo "¿Cuántos tweets hay? ¿Cuántos están geolocalizados?">> resultados.txt
echo "Existen los siguientes tweets:">> resultados.txt
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "Select count(*) from tweet;">> resultados.txt;
echo "Los unicos GeoLocalizados son:">> resultados.txt
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "Select count(*) from tweet where tweet->>'coordinates' is not null;">> resultados.txt;
echo "¿Cuántos tweets hay por municipio?">> resultados.txt
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "Select m.nom_mun, count(*) from tweet as t INNER JOIN municipios as m on ST_Contains(m.geom,t.coordenadas)where t.coordenadas is not null GROUP BY m.nom_mun;">> resultados.txt;
echo "¿Hay hashtags repetidos? ¿Usuarios?">> resultados.txt
echo "Los HT repetidos son:">> resultados.txt
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "select tweet->'entities'->'hashtags'->1->>'text' as hashtags, count(*) from tweet group by tweet->'entities'->'hashtags'->1->>'text' having count(*) > 1  order by 2 desc;">> resultados.txt;
echo "Los Usuarios repetidos son:" >> resultados.txt
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "Select tweet->'user'->'id' as user_id, count(*) from tweet group by tweet->'user'->'id' HAVING count(*) > 1 order by 2 desc LIMIT 50;">> resultados.txt;
echo "¿De qué países hay tweets en el archivo?" >> resultados.txt
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "Select distinct tweet->'place'->>'country' as country from tweet;">> resultados.txt;
echo "¿Cuál es el usuario con más followers? ¿Y gente followed?" >> resultados.txt
echo "El usuraio con mas Follower es: Las Noticias con 698321 Followers" >> resultados.txt
echo "¿A cuáles sitios apuntan las display_url s?" >> resultados.txt
PGPASSWORD=itam psql -h 0.0.0.0 -p 5432 -d itamdb -U itam -c "select distinct tweet->'entities'->'urls'->1->'display_url' as display_urls from tweet;">> resultados.txt;


