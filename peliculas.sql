--1. Crear base de datos llamada películas
--2. Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes,
determinando la relación entre ambas tablas.
CREATE DATABASE peliculas


CREATE TABLE peliculas(id SERIAL PRIMARY KEY, pelicula VARCHAR(100), año_estreno INT, director VARCHAR(50));

CREATE TABLE reparto(id_peliculas INT, nombre VARCHAR(100),FOREIGN KEY(id_peliculas) REFERENCES peliculas(id));

--3. CARGAR ambos archivos a su tabla correspondiente. *desde donde voy a copiar y from desde  donde voy a sacar los datos.

\COPY peliculas FROM '/home/iperez/Escritorio/BASE DE DATOS/Apoyo Desafío - Top 100(1)/Apoyo Desafío 2 -  Top 100/peliculas.csv' csv header;

\COPY reparto FROM '/home/iperez/Escritorio/BASE DE DATOS/Apoyo Desafío - Top 100(1)/Apoyo Desafío 2 -  Top 100/reparto.csv' csv;

--4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película,año de estreno, director y todo el reparto.

SELECT peliculas.pelicula,año_estreno,director,reparto.nombre FROM peliculas INNER JOIN reparto ON id_peliculas=peliculas.id WHERE pelicula= 'Titanic'; 

--5. Listar los titulos de las películas donde actúe Harrison Ford.(0.5 puntos)

SELECT peliculas.pelicula FROM peliculas INNER JOIN reparto ON reparto.id_peliculas=peliculas.id WHERE nombre= 'Harrison Ford';

-- 6 Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el top 100.

SELECT peliculas.director, count(director) AS numero_peliculas_que_aparecen_en_el_top_100 FROM peliculas GROUP BY(director) ORDER BY(count(director)) DESC LIMIT(10);

--SELECT count(director), peliculas.director FROM peliculas GROUP BY(director) ORDER BY(count(director)) DESC LIMIT(10);

-- para contar cuantos actores existen
SELECT count(actores) FROM (SELECT nombre FROM reparto GROUP BY(nombre)) AS actores; 

--7  Indicar cuantos actores distintos 
SELECT nombre FROM reparto GROUP BY nombre HAVING COUNT(*)>1; 

--8 Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por título de manera ascendente.(1 punto)

SELECT pelicula FROM peliculas WHERE año_estreno >=1990 AND año_estreno <=1999 ORDER BY(pelicula) ASC;

--9 Listar el reparto de las películas lanzadas el año 2001

SELECT pelicula FROM peliculas WHERE año_estreno = 2001;

-- 10 Listar los actores de la película más nueva

SELECT nombre FROM reparto INNER JOIN peliculas ON peliculas.id=id_peliculas WHERE año_estreno = (SELECT MAX(año_estreno)FROM peliculas);


