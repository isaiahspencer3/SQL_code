-- 1st table
SELECT *
FROM credits

-- 2nd table
SELECT *
FROM titles

-- Joined table
SELECT * 
FROM credits JOIN titles ON credits.id = titles.id

---------VISUALIZATION TABLES----------------------------------

-- Tableau Table 1: Movies with the highest imdb score (minimum 1000 votes)
SELECT title, imdb_score
FROM titles
WHERE imdb_votes >= 1000 AND type = 'MOVIE'
ORDER BY imdb_score DESC

-- Tableau Table 2: TV shows with the highest imdb score (minimum 1000 votes)
SELECT title, imdb_score
FROM titles
WHERE imdb_votes >= 1000 AND type = 'SHOW'
ORDER BY imdb_score DESC

-- Tableau Table 3: imdb scores of Star Wars movies
SELECT title, imdb_score
FROM titles
WHERE title LIKE '%Star Wars%' AND type='MOVIE' OR title IN ('The Empire Strikes Back','Return of the Jedi')
ORDER BY imdb_score DESC

-- Tableau Table 4: imdb scores of Star Wars shows
SELECT title, imdb_score
FROM titles
WHERE title LIKE '%Star Wars%' AND type='SHOW' OR title= 'The Mandalorian'
ORDER BY imdb_score DESC

-- Tableau Table 5: tmdb scores of Star Wars movies
SELECT title, tmdb_score
FROM titles
WHERE title LIKE '%Star Wars%' AND type='MOVIE' OR title IN ('The Empire Strikes Back','Return of the Jedi')
ORDER BY tmdb_score DESC

------------------------------------------------

-- Other interesting information

-- Movies with the highest tmdb score (minimum 50 popularity)
SELECT title, tmdb_score
FROM titles
WHERE tmdb_popularity >= 50 AND type = 'MOVIE'
ORDER BY tmdb_score DESC

-- Movie/Show with the most actors
SELECT titles.title, COUNT(credits.role) as num_actors 
FROM credits JOIN titles ON credits.id = titles.id
WHERE credits.role = 'ACTOR'
GROUP BY titles.title
ORDER BY num_actors DESC

-- Actor with the highest average imdb score (minium 5 roles) 
SELECT credits.name, ROUND(AVG(imdb_score),2) as avg_film_score 
FROM credits JOIN titles ON credits.id = titles.id
WHERE credits.role = 'ACTOR'
GROUP BY credits.name
HAVING COUNT(imdb_score) >= 5
ORDER BY avg_film_score DESC

-- How many movies per age_certification
SELECT age_certification, COUNT(*) as num_movies
FROM titles
GROUP BY age_certification
ORDER BY num_movies DESC

-- Average imdb score by age certification
SELECT age_certification, ROUND(AVG(imdb_score),2) as avg_score
FROM titles
GROUP BY age_certification
ORDER BY avg_score DESC

-- Movies with the longest runtime
SELECT title, runtime
FROM titles
WHERE type = 'MOVIE'
ORDER BY runtime DESC

-- Highest scored movie on imdb from the 90's
SELECT title, release_year, imdb_score
FROM titles
WHERE (release_year BETWEEN 1990 AND 1999) AND type = 'MOVIE'
ORDER BY imdb_score DESC


