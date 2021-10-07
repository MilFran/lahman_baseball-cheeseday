--QUESTION 1.
-- SELECT MAX(year), MIN(year)
-- FROM homegames



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
-- GROUP BY full_name, team







