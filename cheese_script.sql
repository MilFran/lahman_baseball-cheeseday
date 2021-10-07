--1. AS A GROUP 
--What range of years for baseball games played does the provided database cover?
-- Find MAX and MIN of baseball games played.

/*SELECT MIN(yearid), MAX(yearid)
FROM teams;*/
--OUTPUT:  MIN: 1871 & MAX 2016

--3. DAKOTA

-- WITH vanderbilt_players AS (SELECT DISTINCT(playerid), namefirst, namelast, schoolid
-- 						   FROM schools INNER JOIN collegeplaying USING (schoolid)
-- 						   INNER JOIN people USING (playerid)
-- 						   WHERE schoolname = 'Vanderbilt University')


-- SELECT namefirst, namelast, SUM(salary::numeric::money) AS total_salary
-- FROM salaries INNER JOIN vanderbilt_players USING (playerid)
-- GROUP BY namefirst, namelast
-- ORDER BY total_salary DESC;

-- David Price earned $81,851,296.

--4. ANDY

--5. OLARICHE
--Find the average number of strikeouts per game by decade since 1920. 
--Round the numbers you report to 2 decimal places.
--Do the same for home runs per game. Do you see any trends?


-- WITH avg_strikeouts_decade AS (SELECT CASE WHEN yearid < 1920 THEN 'Before 1920s'
--             				  		      WHEN yearid BETWEEN 1920 AND 1929 THEN '1920s'
-- 										  WHEN yearid BETWEEN 1930 AND 1939 THEN '1930s'
-- 										  WHEN yearid BETWEEN 1940 AND 1949 THEN '1940s'
-- 										  WHEN yearid BETWEEN 1950 AND 1959 THEN '1950s'
-- 										  WHEN yearid BETWEEN 1960 AND 1969 THEN '1960s'
-- 										  WHEN yearid BETWEEN 1970 AND 1979 THEN '1970s'
-- 										  WHEN yearid BETWEEN 1980 AND 1989 THEN '1980s'
-- 										  WHEN yearid BETWEEN 1990 AND 1999 THEN '1990s'
-- 										  WHEN yearid BETWEEN 2000 AND 2009 THEN '2000s'
-- 										  ELSE '2010s' END AS decades,
-- 									  (SUM(so::decimal)/(SUM(g::decimal)/2)) AS avg_strikeouts_game
-- 							 FROM pitching
-- 							 GROUP BY decades
-- 							 ORDER BY decades DESC)

-- SELECT decades, ROUND(avg_strikeouts_game, 2) AS avg_strikeouts_per_decade
-- FROM avg_strikeouts_decade
-- WHERE decades NOT LIKE 'Before 1920s'
-- ORDER BY decades;

--6. OLARICHE
-- Find the player who had the most success stealing bases in 2016,
-- where __success__ is measured as the percentage of stolen base attempts which are successful.
-- (A stolen base attempt results either in a stolen base or being caught stealing.) 
-- Consider only players who attempted _at least_ 20 stolen bases.

-- SELECT yearid, playerid, sb, cs, ROUND((sb::numeric/(sb::numeric + cs::numeric))*100,2) AS stolen_base_percent
-- FROM batting
-- WHERE sb >= 20 
-- AND cs <> 0
-- AND yearid = 2016
-- ORDER BY stolen_base_percent DESC;




--10.
-- Find all players who hit their career highest number of home runs in 2016.
--Consider only players who have played in the league for at least 10 years, and who hit at least one home run in 2016.
--Report the players' first and last names and the number of home runs they hit in 2016.
