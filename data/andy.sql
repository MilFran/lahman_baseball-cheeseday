--Q1 - Find MIN and MAX years for range in dataset
--SELECT MAX(year)
--FROM homegames
--2016

--SELECT MIN(year)
--FROM homegames
--1871

--Q4 Group positions and avg po of each group
SELECT pos, ROUND(AVG(po)) AS avg_po,
	CASE WHEN pos = 'OF' THEN 'Outfield'
	WHEN pos = 'C' OR pos = 'P' THEN 'Battery'
	ELSE 'Infield' END AS avg_positions
FROM fielding
WHERE yearid = 2016
GROUP BY pos
ORDER BY avg_po DESC

--Q7 -Largest # of wins not winning world series / smallest # of wins winning world series /
--teams winning world series with most wins regular season in % without "problem year"
--SELECT DISTINCT yearid, teamid, MAX(w) AS max_wins, wswin
--FROM teams
--WHERE wswin = 'N' AND yearid BETWEEN 1970 AND 2016
--GROUP BY yearid, teamid, wswin
--ORDER BY max_wins DESC
--2001 Seattle 116 wins, no world series

--SELECT DISTINCT yearid, teamid, MIN(w) AS min_wins, wswin
--FROM teams
--WHERE wswin = 'Y' AND yearid BETWEEN 1970 AND 2016
--GROUP BY yearid, teamid, wswin
--ORDER BY min_wins
--1981 LA Dodgers 63 wins and world series / players' strike between June 12 and July 31 split the season into two halfs

SELECT DISTINCT MAX(w), yearid, teamid, wswin
FROM teams
WHERE yearid BETWEEN 1970 AND 2016
GROUP BY yearid, teamid, wswin
ORDER BY yearid