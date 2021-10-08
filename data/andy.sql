--Q1 - Find MIN and MAX years for range in dataset
--SELECT MAX(year)
--FROM homegames
--2016

--SELECT MIN(year)
--FROM homegames
--1871

--Q2
/*SELECT DISTINCT(P.NAMEFIRST),
	P.NAMELAST,
	S.SCHOOLNAME,
	SUM(M.SALARY) OVER(PARTITION BY p.namefirst)
FROM PEOPLE AS P
INNER JOIN COLLEGEPLAYING AS CP ON P.PLAYERID = CP.PLAYERID
INNER JOIN SCHOOLS AS S ON CP.SCHOOLID = S.SCHOOLID
INNER JOIN SALARIES AS M ON P.PLAYERID = M.PLAYERID
WHERE S.SCHOOLNAME = 'Vanderbilt University'
GROUP BY P.NAMEFIRST,
	P.NAMELAST,
	S.SCHOOLNAME,
	M.SALARY
ORDER BY sum DESC*/

--Q3


--Q4 Group positions and avg po of each group
--SELECT pos, SUM(po) AS sum_po,
	--CASE WHEN pos ='OF' THEN 'Outfield'
	--WHEN pos = 'C' OR pos = 'P' THEN 'Battery'
	--ELSE 'Infield' END AS avg_positions
--FROM fielding
--WHERE yearid = 2016
--GROUP BY pos

--Q5
/*SELECT CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920s'
	   		WHEN yearid BETWEEN 1930 AND 1939 THEN '1930s'
			WHEN yearid BETWEEN 1940 AND 1949 THEN '1940s'
			WHEN yearid BETWEEN 1950 AND 1959 THEN '1950s'
			WHEN yearid BETWEEN 1960 AND 1969 THEN '1960s'
			WHEN yearid BETWEEN 1970 AND 1979 THEN '1970s'
			WHEN yearid BETWEEN 1980 AND 1989 THEN '1980s'
			WHEN yearid BETWEEN 1990 AND 1999 THEN '1990s'
			WHEN yearid BETWEEN 2000 AND 2010 THEN '2000s'
			WHEN yearid BETWEEN 2010 AND 2019 THEN '2010s'
			ELSE '1919 & Before' END AS decade,
			round(SUM(hr::numeric)/SUM(ghome::numeric),2) AS avg_homers_per_game,
	    	round(SUM(so::numeric)/SUM(ghome::numeric),2) AS avg_strikeouts_per_game
FROM teams
WHERE ghome IS NOT NULL
GROUP BY decade
ORDER BY decade;*/

--Q6
/*WITH sb_successes AS (	SELECT	playerid,
								sb,
					  			cs,
					  			yearid,
					  			SUM((sb) + (cs)) AS sb_attempt
						FROM batting
						GROUP BY playerid, yearid, sb, cs)
						
SELECT 	p.namefirst,
		p.namelast,
		ROUND((sba.sb::numeric / sba.sb_attempt::numeric) * 100, 2) AS sb_percent
FROM people AS p
LEFT JOIN sb_successes AS sba
ON sba.playerid = p.playerid
WHERE sba.sb_attempt >= 20
AND sba.yearid = 2016
GROUP BY p.namefirst, p.namelast, sb_percent
ORDER BY sb_percent DESC;*/


--Q7 -Largest # of wins not winning world series / smallest # of wins winning world series /
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
/*WITH max_winner AS (SELECT yearid, MAX(w) AS max_wins_in_season
					FROM teams FULL JOIN (SELECT yearid, wswin, w AS win_total
				 	  					  FROM teams
				      					  WHERE yearid BETWEEN 1970 AND 2016
				 	  					  AND wswin = 'Y'
				 	  				      GROUP BY yearid, wswin, w) AS winners USING (yearid)
					WHERE yearid BETWEEN 1970 AND 2016
					GROUP BY yearid, win_total
					HAVING MAX(w) = win_total
					ORDER BY yearid)
					
					
SELECT ROUND(((COUNT(mw.*)::decimal / COUNT(wsw.*)::decimal) * 100), 2) AS percentage_max_winners
FROM max_winner AS mw FULL JOIN (SELECT yearid, wswin
				   				 FROM teams
				   				 WHERE yearid BETWEEN 1970 AND 2016
				   				 AND wswin = 'Y'
				   				 GROUP BY yearid, wswin) AS wsw USING (yearid)*/
								 
--Q8


--Q9
/*WITH TSA_MANAGER_WINNERS AS
	(SELECT PLAYERID
		FROM AWARDSMANAGERS
		WHERE AWARDID = 'TSN Manager of the Year'
			AND LGID = 'NL' INTERSECT
			SELECT PLAYERID
			FROM AWARDSMANAGERS WHERE AWARDID = 'TSN Manager of the Year'
			AND LGID = 'AL')
SELECT DISTINCT(CONCAT(P.NAMEFIRST,' ',P.NAMELAST)) AS NAME,
	AW.YEARID,
	M.TEAMID,
	T.NAME
FROM TSA_MANAGER_WINNERS AS AM
INNER JOIN PEOPLE AS P ON AM.PLAYERID = P.PLAYERID
INNER JOIN AWARDSMANAGERS AW ON AM.PLAYERID = AW.PLAYERID
INNER JOIN MANAGERS AS M ON AM.PLAYERID = M.PLAYERID
AND AW.YEARID = M.YEARID
AND AW.LGID = M.LGID
INNER JOIN TEAMS AS T ON M.TEAMID = T.TEAMID
AND M.YEARID = T.YEARID
AND M.LGID = T.LGID*/

--Q10
/*SELECT playerid, namefirst, namelast, MAX(sum_hr) AS career_high_hr
FROM batting AS b INNER JOIN (SELECT playerid, yearid, SUM(hr) AS sum_hr
						 	  FROM batting
						 	  GROUP BY playerid, yearid
						 	  ORDER BY sum_hr DESC) AS total_hr USING (playerid)
INNER JOIN people AS p USING (playerid)
WHERE b.yearid = 2016
AND EXTRACT(year FROM p.debut::date) <= 2006
GROUP BY playerid, namefirst, namelast, hr
HAVING SUM(hr) > 0
AND MAX(sum_hr) = hr
ORDER BY career_high_hr DESC*/

--Bonus 1


--Bonus 2


--Bonus 3