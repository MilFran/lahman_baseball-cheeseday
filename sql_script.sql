--1. AS A GROUP 
--What range of years for baseball games played does the provided database cover?
-- Find MAX and MIN of baseball games played.

/*SELECT MIN(yearid), MAX(yearid)
FROM teams;*/
--OUTPUT:  MIN: 1871 & MAX 2016


--5. OLARICHE
--Find the average number of strikeouts per game by decade since 1920. 
--Round the numbers you report to 2 decimal places.
--Do the same for home runs per game. Do you see any trends?


-- WITH decade AS (SELECT SUM(yearid CASE WHEN yearid < 1920 THEN 
-- 							WHEN yearid BETWEEN 1920 AND 1929 THEN '1920s'
-- 							WHEN yearid BETWEEN 1930 AND 1939 THEN '1930S'
-- 							WHEN yearid BETWEEN 1940 AND 1949 THEN '1940s'
-- 							WHEN yearid BETWEEN 1950 AND 1959 THEN '1950s'
-- 							WHEN yearid BETWEEN 1960 AND 1969 THEN '1960s'
-- 							WHEN yearid BETWEEN 1970 AND 1979 THEN '1970s'
-- 							WHEN yearid BETWEEN 1980 AND 1989 THEN '1980s'
-- 							WHEN yearid BETWEEN 1990 AND 1999 THEN '1990s'
-- 							WHEN yearid BETWEEN 2000 AND 2010 THEN '2000s'
-- 			   				ELSE '2010s' AS decades )
-- SELECT yearid
-- FROM pitching LEFT JOIN decade
-- ON pitching.yearid = decade.yearid
-- WHERE yearid >= 1920


--6. OLARICHE
-- Find the player who had the most success stealing bases in 2016,
-- where __success__ is measured as the percentage of stolen base attempts which are successful.
-- (A stolen base attempt results either in a stolen base or being caught stealing.) 
-- Consider only players who attempted _at least_ 20 stolen bases.

SELECT








--10.
-- Find all players who hit their career highest number of home runs in 2016.
--Consider only players who have played in the league for at least 10 years, and who hit at least one home run in 2016.
--Report the players' first and last names and the number of home runs they hit in 2016.
