----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--QUESTION 1.
-- SELECT MAX(year), MIN(year)
-- FROM homegames


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--QUESTION 2.
--name and height of shortest player, how many games did he play, and for what team

-- SELECT p.namegiven, 
-- 	MIN(p.height / 12) AS player_height, 
-- 	t.name AS team_name,
-- 	a.g_all AS total_games
-- FROM people AS p
-- JOIN appearances AS a
-- 	ON p.playerid = a.playerid
-- JOIN teams AS t
-- 	ON a.teamid = t.teamid
-- GROUP BY  namegiven, team_name, total_games
-- ORDER BY player_height
-- LIMIT 1


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--QUESTION 3 - Find the first and last names of Vanderbilt University players. 
-- 			 List, in descending order, their total MLB salary earnings.
-- 			 State who earned the most money.


-- WITH vanderbilt_players AS (SELECT DISTINCT(playerid), namefirst, namelast, schoolid
-- 						   FROM schools INNER JOIN collegeplaying USING (schoolid)
-- 						   INNER JOIN people USING (playerid)
-- 						   WHERE schoolname = 'Vanderbilt University')


-- SELECT namefirst, namelast, SUM(salary::numeric::money) AS total_salary
-- FROM salaries INNER JOIN vanderbilt_players USING (playerid)
-- GROUP BY namefirst, namelast
-- ORDER BY total_salary DESC;

-- David Price earned $81,851,296.



----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--QUESTION 4 Group positions and avg po of each group

--SELECT pos, ROUND(AVG(po)) AS avg_po,
	--CASE WHEN pos ='OF' THEN 'Outfield'
	--WHEN pos = 'C' OR pos = 'P' THEN 'Battery'
	--ELSE 'Infield' END AS avg_positions
--FROM fielding
--WHERE yearid = 2016
--GROUP BY avg_positions, pos
--ORDER BY avg_po DESC


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--QUESTION 5. OLARICHE
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



----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--QUESTION 6. OLARICHE
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




----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--QUESTION 7 -Largest # of wins not winning world series / smallest # of wins winning world series /
--teams winning world series with most wins regular season in % without "problem year"
--7a
/*SELECT yearid, teamid, w, wswin
FROM teams
WHERE w IN (SELECT MAX(w) 
			FROM teams)
AND yearid BETWEEN 1970 AND 2016
AND wswin = 'N'
UNION
SELECT yearid, teamid, w, wswin
FROM teams
WHERE w IN (SELECT MIN(w) 
			FROM teams
			WHERE wswin = 'Y')
AND yearid BETWEEN 1970 AND 2016
AND wswin = 'Y'*/

--7b
/*SELECT yearid, teamid, w, wswin
FROM teams
WHERE w IN (SELECT MAX(w) 
			FROM teams
		    WHERE wswin = 'Y')
AND yearid BETWEEN 1970 AND 2016 AND NOT yearid = 1981
AND wswin = 'Y'*/

--7c
-- WITH max_winner AS (SELECT yearid, MAX(w) AS max_wins_in_season
-- 					FROM teams FULL JOIN (SELECT yearid, wswin, w AS win_total
-- 				 	  					  FROM teams
-- 				      					  WHERE yearid BETWEEN 1970 AND 2016
-- 				 	  					  AND wswin = 'Y'
-- 				 	  				      GROUP BY yearid, wswin, w) AS winners USING (yearid)
-- 					WHERE yearid BETWEEN 1970 AND 2016
-- 					GROUP BY yearid, win_total
-- 					HAVING MAX(w) = win_total
-- 					ORDER BY yearid)
					
					
-- SELECT ROUND(((COUNT(mw.*)::decimal / COUNT(wsw.*)::decimal) * 100), 2) AS percentage_max_winners
-- FROM max_winner AS mw FULL JOIN (SELECT yearid, wswin
-- 				   				 FROM teams
-- 				   				 WHERE yearid BETWEEN 1970 AND 2016
-- 				   				 AND wswin = 'Y'
-- 				   				 GROUP BY yearid, wswin) AS wsw USING (yearid)


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--QUESTION  8 - Find the teams and parks that had the highest average attendance per game in 2016.
-- 			 The park must have at least 10 games played. Give the team name, park name, and avg attendance.
-- 			 Find the top 5 and bottom 5 average attendance.

-- Top 5 avg_attendance

-- SELECT team, park_name, (attendance/games) AS avg_attendance
-- FROM homegames INNER JOIN parks USING (park)
-- WHERE span_first BETWEEN '2016-01-01' AND '2016-12-31'
-- AND games >= 10
-- ORDER BY avg_attendance DESC
-- LIMIT 5;

-- Bottom 5 avg_attendance

-- SELECT team, park_name, (attendance/games) AS avg_attendance
-- FROM homegames INNER JOIN parks USING (park)
-- WHERE span_first BETWEEN '2016-01-01' AND '2016-12-31'
-- AND games >= 10
-- ORDER BY avg_attendance
-- LIMIT 5;








----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--QUESTION 9. 
--which managers have won TSN MANAGER OF THE YEAR in both NATIONAL LEAGUE (NL) and AMERICAN LEAGUE(AL)
--give full name and teams they were managing when they won

-- SELECT	CONCAT(namefirst, ' ', namelast) AS full_name,
-- 		teams.teamid AS team
-- FROM awardsmanagers AS am 
-- INNER JOIN people 
-- 	ON people.playerid = am.playerid
-- INNER JOIN managershalf 
-- 	ON managershalf.playerid = people.playerid
-- INNER JOIN teams 
-- 	ON teams.teamid = managershalf.teamid
-- WHERE am.lgid IN ('NL', 'AL')
-- AND am.awardid ILIKE 'TSN Manager of the Year'
-- GROUP BY full_name, team;



----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--QUESTION 10 - Find players who have played at least 10 years who hit their career high of home runs in 2016.
-- 			  Only consider players who hit at least 1 home run.


-- SELECT playerid, namefirst, namelast, MAX(sum_hr) AS career_high_hr
-- FROM batting AS b INNER JOIN (SELECT playerid, yearid, SUM(hr) AS sum_hr
-- 						 	  FROM batting
-- 						 	  GROUP BY playerid, yearid
-- 						 	  ORDER BY sum_hr DESC) AS total_hr USING (playerid)
-- INNER JOIN people AS p USING (playerid)
-- WHERE b.yearid = 2016
-- AND EXTRACT(year FROM p.debut::date) <= 2006
-- GROUP BY playerid, namefirst, namelast, hr
-- HAVING SUM(hr) > 0
-- AND MAX(sum_hr) = hr
-- ORDER BY career_high_hr DESC
























--BONUS QUESTION 1.
-- Is there any correlation between number of wins and team salary? 
-- Use data from 2000 and later to answer this question. 
-- As you do this analysis, keep in mind that salaries across the whole league 
-- tend to increase together, so you may want to look on a year-by-year basis.


--BONUS QUESTION 2.
-- In this question, you will explore the connection between number of wins and attendance.

-- A.   Does there appear to be any correlation between attendance at home games 
-- 		and number of wins?
-- B.   Do teams that win the world series see a boost in attendance the following year? 
-- 		What about teams that made the playoffs? Making the playoffs means either 
-- 		being a division winner or a wild card winner.


--BONUS QUESTION 3.
-- It is thought that since left-handed pitchers are more rare, causing batters to face 
-- them less often, that they are more effective. 

-- Investigate this claim and present evidence to either support or dispute this claim. 

-- First, determine just how rare left-handed pitchers are compared with right-handed pitchers. 

-- Are left-handed pitchers more likely to win the Cy Young Award? Are they more likely to make it into the hall of fame?






