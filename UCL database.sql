--CREATE TABLE FOR PLAYERS

CREATE TABLE Players (
	player_id INT PRIMARY KEY,
	player_name VARCHAR(100),
	team VARCHAR(50),
	player_position VARCHAR(50),
	age INT,
	nationality VARCHAR(50)
);

--INSERT DATA IN PLAYERS TABLE

INSERT INTO Players (player_id, player_name, team, player_position, age, nationality)
VALUES
(1, 'Lionel Messi', 'FCB', 'Forward', 35, 'Argentina'), 
(2, 'Cristiano Ronaldo', 'Man United', 'Forward', 37, 'Portugal'),
(3, 'Kylian Mbappe', 'PSG', 'Forward', 24, 'France'),
(4, 'Erling Haaland', 'Man City', 'Forward', 22, 'Norway'),
(5, 'Kevin De Bruyne', 'Man City', 'Midfielder', 31, 'Belgium');

--CREATE TABLE FOR MATCHES

CREATE TABLE Matches (
match_id INT PRIMARY KEY,
home_team VARCHAR(50),
away_team VARCHAR(50),
home_score INT,
away_score INT,
match_date DATE
);

--INSERT DATA IN MATCHES TABLE

INSERT INTO Matches (match_id, home_team, away_team, home_score, away_score, match_date) 
VALUES
(101, 'PSG', 'Man United', 2, 1, '2023-09-14'),
(102, 'Man City', 'Chelsea', 3, 1, '2023-09-21'),
(103, 'Real Madrid', 'FCB', 1, 2, '2023-10-01'),
(104, 'Man United', 'Juventus', 2, 3, '2023-10-10'),
(105, 'Chelsea', 'Man City', 0, 2, '2023-10-18');

--CREATE TABLE FOR GOALS

CREATE TABLE Goals (
goal_id INT PRIMARY KEY, 
match_id INT, 
player_id INT,
minute_scored INT,
FOREIGN KEY (match_id) REFERENCES Matches(match_id),
FOREIGN KEY (player_id) REFERENCES Players(player_id)
);

--INSERT DATA IN GOALS TABLE

INSERT INTO Goals (goal_id, match_id, player_id, minute_scored) VALUES
(1, 101, 1, 23),
(2, 102, 4, 14),
(3, 102, 5, 75),
(4, 103, 3, 67),
(5, 104, 2, 89),
(6, 105, 4, 45),
(7, 105, 4, 82);


-- 1.List all players in the dataset.

SELECT * FROM Players;


-- 2. Find all players who play for Man City.

SELECT player_name FROM Players
WHERE team = 'Man City';


-- 3. List all matches where PSG was the home team.

SELECT * FROM Matches
WHERE home_team = 'PSG'


-- 4. Get the number of goals scored in each match.

SELECT match_id, COUNT(goal_id) AS total_goals
FROM Goals
GROUP BY match_id;


-- 5. Show player names and their nationalities ordered by age (youngest first).

SELECT player_name, nationality, age
FROM players
ORDER BY age ASC;


-- 6. Find the player who scored the most goals.

SELECT p.player_name, COUNT(g.goal_id) AS total_goals
FROM Players p
JOIN Goals g ON p.player_id = g.player_id
GROUP BY p.player_name
ORDER BY total_goals DESC
LIMIT 1;


-- 7. List all goals scored by PSG players.

SELECT p.player_name, g.minute_scored, m.match_date
FROM Goals g
JOIN Players p ON g.player_id = p.player_id
JOIN Matches m ON g.match_id = m.match_id
WHERE p.team = 'PSG';


-- 8. Find the match with the highest total number of goals.

SELECT match_id, COUNT(goal_id) AS total_goals
FROM Goals
GROUP BY match_id
ORDER BY total_goals DESC
LIMIT 1;


-- 9. Find the player and match with the highest total number of goals.

SELECT p.player_name, g.match_id, COUNT(g.goal_id) AS total_goals
FROM Goals g
JOIN Players p ON g.player_id = p.player_id
GROUP BY p.player_name, g.match_id
ORDER BY total_goals DESC
LIMIT 1;


-- 10. List all midfielders and how many goals each has scored.

SELECT p.player_name, COUNT(g.goal_id) AS goals_scored
FROM Players p
JOIN Goals g  ON p.player_id = g.player_id
WHERE p.player_position = 'Midfielder'
GROUP BY p.player_name;


-- 11. Get the number of goals scored by each team.

SELECT p.team, COUNT(g.goal_id) AS goals_scored
FROM Players p
JOIN Goals g ON p.player_id = g.player_id
GROUP BY p.team;


-- 12. Which players have scored in more than one match, and how many different matches did they score in?

SELECT p.player_name, COUNT(DISTINCT g.match_id) AS matches_scored_in
FROM Goals g
JOIN Players p ON g.player_id = p.player_id
GROUP BY p.player_name
HAVING COUNT(DISTINCT g.match_id) > 1
ORDER BY matches_scored_in DESC;

