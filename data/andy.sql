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
SELECT yearid, teamid, MAX(w), wswin
FROM teams
WHERE CAST(MAX(w) /
	  MAX(w),
FROM teams
WHERE wswin = 'Y')
AND yearid BETWEEN 1970 AND 2016 AND NOT yearid = 1981
AND wswin = 'Y'