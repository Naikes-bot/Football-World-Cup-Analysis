
-- The number of time countries have won the World Cup
Select Winner, COUNT(*) AS times_won
FROM `World Cup`.world_cups
GROUP BY Winner
ORDER BY times_won DESC; 

-- Maximum number of goals across world cups and where was it?
Select host_country, Year, MAX(Goals_Scored)AS maximum_goals
FROM `World Cup`.world_cups
GROUP BY host_country, Year
ORDER BY maximum_goals DESC;

-- What is the average goals scored in world cups? Which are the host countries that are 
-- below and above average goals scored
WITH cte AS (Select Host_country, AVG(Goals_scored) AS avg_goalscored
FROM `World Cup`.world_cups
GROUP BY Host_country
)
Select Host_country, 
   CASE WHEN Host_country > AVG(Goals_scored) THEN 'Above Average goals'
        WHEN Host_country < AVG(Goals_scored) THEN 'Below Average goals'
        ELSE 'normal'
   END AS goal_scored
FROM `World Cup`.world_cups
GROUP BY Host_country; 

-- Which country has finished runners up the most?
Select Runners_up, COUNT(*) AS total
FROM `World Cup`.world_cups
GROUP BY Runners_up
ORDER BY total DESC;

-- Total number of home goals & away goals from 1930 - 2018
Select Year, 
	   SUM(home_goals) AS total_homegoals, 
       SUM(away_goals) AS total_awaygoals
FROM `World Cup`.matches
GROUP BY Year;

-- Which World cup edition did the host country win the Cup?
Select Year, Host_country, Winner
FROM`World Cup`.world_cups
WHERE Host_country = winner; 

-- Provide the total home and away goals per World Cup edition
Select Year, 
       SUM(home_goals) AS total_homegoals, 
	   SUM(away_goals) As total_awaygoals,
       ROW_NUMBER() OVER(PARTITION BY Year Order by Year)
FROM `World Cup`.matches
GROUP BY Year;

-- Which team has the most semifinals appearance from 1930 - 2018 
SELECT home_team, 
       away_team,
	   COUNT(*) AS num_semifinals
FROM `World Cup`.matches
WHERE stage = 'Semi-finals'
GROUP BY home_team, away_team
ORDER BY num_semifinals DESC
LIMIT 1;

-- Extra time per Round 
Select stage, COUNT(*) AS count_of_matches
FROM `World Cup`.matches
WHERE win_conditions = 'Extra time'
GROUP BY stage; 

-- What is the AVG goals per match across all the world Cup editions
SELECT Year, 
       Host_Country,
       Matches_Played,
      AVG(Goals_scored/Matches_played) AS goals_per_match
FROM `World Cup`.world_cups
GROUP BY Year, Matches_Played, Host_Country, (Goals_scored/Matches_played)
ORDER BY goals_per_match DESC;





















