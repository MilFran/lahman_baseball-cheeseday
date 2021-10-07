--Q1 - Find MIN and MAX years for range in dataset
--SELECT MAX(year)
--FROM homegames
--2016

--SELECT MIN(year)
--FROM homegames
--1871

--Q4 Group positions and avg po of each group
--SELECT pos, ROUND(AVG(po)) AS avg_po,
	--CASE WHEN pos ='OF' THEN 'Outfield'
	--WHEN pos = 'C' OR pos = 'P' THEN 'Battery'
	--ELSE 'Infield' END AS avg_positions
--FROM fielding
--WHERE yearid = 2016
--GROUP BY avg_positions, pos
--ORDER BY avg_po DESC

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
WITH max_winner AS (SELECT yearid, MAX(w) AS max_wins_in_season
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
				   				 GROUP BY yearid, wswin) AS wsw USING (yearid)