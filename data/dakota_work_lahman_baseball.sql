-- Question 1 - Find MIN and MAX of the data range

-- SELECT MIN(yearid), MAX(yearid)
-- FROM teams;


-- Question 3 - Find the first and last names of Vanderbilt University players. 
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


-- Question 8 - Find the teams and parks that had the highest average attendance per game in 2016.
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




-- Question 4 - Group players into 3 groups based on position, then determine the number of putouts made
-- 			    in 2016.

-- SELECT CASE WHEN pos IN ('OF') THEN 'Outfield'
-- 	 		WHEN pos IN ('SS', '1B', '2B', '3B') THEN 'Infield'
-- 	 		ELSE 'Battery' END AS pos_groups,
-- 	   SUM(po)
-- FROM fielding
-- WHERE yearid = 2016
-- GROUP BY pos_groups



-- Question 5 - Rounding to 2 decimal places, find the average number of strikeouts per game 
--              by decade since 1920. Do the same for home runs. Find any trends.
			 
			 
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

			 






-- Question 10 - Find players who have played at least 10 years who hit their career high of home runs in 2016.
-- 			  Only consider players who hit at least 1 home run.



						
-- WITH career_high_hr AS (SELECT playerid, yearid, 
-- 						SUM(hr) OVER(PARTITION BY playerid, yearid
-- 									 ORDER BY yearid
-- 									 LIMIT 1) AS sum_hr
-- 				       FROM batting
-- 				       GROUP BY playerid, yearid
-- 					   ORDER BY sum_hr DESC)
					   
-- SELECT playerid, yearid, MAX(sum_hr) AS career_high
-- FROM career_high_hr
-- GROUP BY playerid, yearid
-- ORDER BY career_high DESC


-- SELECT playerid, namefirst, namelast, yearid, total_hr AS career_high_hr
-- FROM batting INNER JOIN people USING (playerid)
-- INNER JOIN career_high_hr USING (playerid)
-- WHERE EXTRACT(year FROM debut::date) <= 2006
-- AND batting.yearid = 2016
-- AND hr > 0
 
 --QUESTION 10 NOT COMPLETED!