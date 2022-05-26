--1st Table
SELECT *
FROM gameDescription

--2nd Table
SELECT *
FROM gameMoves

--Joining the tables together
SELECT *
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id

--Highest rated player that used white
SELECT DISTINCT white_id, MAX(white_rating) OVER (PARTITION BY white_id) as playerRating 
FROM gameMoves
GROUP BY white_id, white_rating
ORDER BY playerRating desc

--Highest rated player that used black
SELECT DISTINCT black_id, MAX(black_rating) OVER (PARTITION BY black_id) as playerRating
FROM gameMoves
GROUP BY black_id, black_rating
ORDER BY playerRating desc

--TABLEAU TABLE 5 Highest Win Rate Openings for White with at least 100 times used
WITH CTE_AllOpenings
AS (
SELECT mov.opening_name, COUNT(*) as AllTimesUsed
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id
GROUP BY mov.opening_name
),
CTE_EffWhiteOpening
AS (
SELECT mov.opening_name, COUNT(*) as TimesUsed
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id
	WHERE des.winner = 'white'
GROUP BY mov.opening_name
)
SELECT eff.opening_name, cast(eff.TimesUsed as float) * 100 / ope.AllTimesUsed as WinPercentage
FROM CTE_EffWhiteOpening eff
JOIN CTE_AllOpenings ope 
ON eff.opening_name = ope.opening_name
WHERE ope.AllTimesUsed >= 100
GROUP BY eff.opening_name, eff.TimesUsed, ope.AllTimesUsed
ORDER BY WinPercentage DESC

--TABLEAU TABLE 6 Highest Win Rate Openings for Black with at least 100 times used
WITH CTE_AllOpenings
AS (
SELECT mov.opening_name, COUNT(*) as AllTimesUsed
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id
GROUP BY mov.opening_name
),
CTE_EffBlackOpening
AS (
SELECT mov.opening_name, COUNT(*) as TimesUsed
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id
	WHERE des.winner = 'black'
GROUP BY mov.opening_name
)
SELECT eff.opening_name, cast(eff.TimesUsed as float) * 100 / ope.AllTimesUsed as WinPercentage
FROM CTE_EffBlackOpening eff
JOIN CTE_AllOpenings ope 
ON eff.opening_name = ope.opening_name
WHERE ope.AllTimesUsed >= 100
GROUP BY eff.opening_name, eff.TimesUsed, ope.AllTimesUsed
ORDER BY WinPercentage DESC

--Player with the most games played as black
SELECT black_id, COUNT(black_id) as TimesPlayed
FROM gameMoves
GROUP BY black_id
ORDER BY TimesPlayed DESC

--How many rated games ended in a draw
SELECT rated, victory_status, COUNT(victory_status) as DrawCount
FROM gameDescription
WHERE victory_status = 'draw' AND rated = '1'
GROUP BY rated, victory_status

--Percentage of games ended
SELECT victory_status, COUNT(*) as TotalGames, CAST(COUNT(*) as float) * 100 / SUM(COUNT(*)) OVER () as PercentEnded
FROM gameDescription
GROUP BY victory_status

--TABLEAU TABLE 1 Most used opening
SELECT mov.opening_name, COUNT(*) as TimesUsed, CAST(COUNT(*) as float) * 100/ SUM(COUNT(*)) OVER () as PercentUsed
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id
GROUP BY mov.opening_name
ORDER BY timesUsed DESC

--TABLEAU TABLE 2 Most used opening where white is the winner 
SELECT mov.opening_name, COUNT(*) as TimesUsed,
CAST(COUNT(*) as float) * 100/ SUM(COUNT(*)) OVER () as PercentUsed
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id
WHERE winner = 'white'
GROUP BY mov.opening_name
ORDER BY timesUsed DESC

--Most used opening where the winner is white and their most used move pattern
SELECT mov.opening_name, mov.moves, COUNT(mov.opening_name) as timesUsed
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id
WHERE winner = 'white'
GROUP BY mov.opening_name, mov.moves
ORDER BY timesUsed DESC

--TABLEAU TABLE 3 Most used opening where black is the winner
SELECT mov.opening_name, COUNT(mov.opening_name) as TimesUsed,
CAST(COUNT(*) as float) * 100/ SUM(COUNT(*)) OVER () as PercentUsed
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id
WHERE winner = 'black'
GROUP BY mov.opening_name
ORDER BY timesUsed DESC

--Most used opening where the winner is black and the most used move pattern amongst those winners
SELECT mov.opening_name, mov.moves, COUNT(mov.opening_name) as TimesUsed
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id
WHERE winner = 'black'
GROUP BY mov.opening_name, mov.moves
ORDER BY timesUsed DESC

--Average rating of the players using white vs players using black
SELECT AVG(mov.white_rating) as AvgWhiteRating, AVG(mov.black_rating) as AvgBlackRating
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id

--Which openings are the most used among using white in 10 minute chess with no increments
SELECT mov.opening_name, COUNT(*) as TimesUsed,
CAST(COUNT(*) as float) * 100 / SUM(COUNT(*)) OVER () as PercentUsed
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id
WHERE des.increment_code = '10+0'
GROUP BY mov.opening_name
ORDER BY TimesUsed DESC

--Which openings are the best among players using white in 10 minute chess with no increments
SELECT mov.opening_name, COUNT(*) as TimesUsed,
CAST(COUNT(*) as float) * 100 / SUM(COUNT(*)) OVER () as PercentUsed
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id
WHERE des.increment_code = '10+0' AND des.winner = 'white'
GROUP BY mov.opening_name
ORDER BY TimesUsed DESC

--How many times did the lower rated player win the game as white and the most used opening among them
SELECT des.winner, mov.opening_name, COUNT(*) as TimesWon, 
CAST(COUNT(*) as float) * 100 / SUM(COUNT(*)) OVER () as PercentUsed
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id
WHERE (mov.white_rating < mov.black_rating AND des.winner = 'white')
GROUP BY des.winner, mov.opening_name
ORDER BY TimesWon DESC


--Percentage time where the lower rated player won the game
SELECT COUNT(*) as TimesWon, CAST(COUNT(*) as float) * 100 / (SELECT COUNT(*) FROM gameDescription) as PercentWon
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id
WHERE (mov.white_rating < mov.black_rating AND des.winner = 'white')
OR (mov.white_rating > mov.black_rating AND des.winner = 'black')
ORDER BY TimesWon DESC

--TABLEAU TABLE 4 Percentage of the most used opening among lower rated winners
SELECT mov.opening_name, COUNT(*) as TimesWon, CAST(COUNT(*) as float) * 100 / (SELECT COUNT(*) FROM gameDescription) as PercentWon
FROM gameDescription des
JOIN gameMoves mov
	ON des.id = mov.id
WHERE (mov.white_rating < mov.black_rating AND des.winner = 'white')
OR (mov.white_rating > mov.black_rating AND des.winner = 'black')
GROUP BY mov.opening_name
ORDER BY TimesWon DESC




