CREATE DATABASE ipl_analytics;
USE ipl_analytics;

CREATE TABLE matches (
	id INT PRIMARY KEY,
    season VARCHAR(10),
    city VARCHAR(100),
    date DATE,
    match_type VARCHAR(50),
    player_of_match VARCHAR(100),
    venue VARCHAR(255),
    team1 VARCHAR(100),
    team2 VARCHAR(100),
    toss_winner VARCHAR(100),
    toss_decision VARCHAR(50),
    winner VARCHAR(100),
    result VARCHAR(50),
    result_margin FLOAT,
    target_runs FLOAT,
    target_overs FLOAT,
    super_over VARCHAR(10),
    method VARCHAR(50),
    umpire1 VARCHAR(100),
    umpire2 VARCHAR(100)
);

CREATE TABLE deliveries (
    match_id INT,
    inning INT,
    batting_team VARCHAR(100),
    bowling_team VARCHAR(100),
    `over` INT,
    ball INT,
    batter VARCHAR(100),
    bowler VARCHAR(100),
    non_striker VARCHAR(100),
    batsman_runs INT,
    extra_runs INT,
    total_runs INT,
    is_wicket INT,
    dismissal_kind VARCHAR(100),
    player_dismissed VARCHAR(100),
    fielder VARCHAR(100),
    extras_type VARCHAR(100),
    FOREIGN KEY (match_id) REFERENCES matches(id)
);

-- Top 10 Run-Scorers in IPL History
SELECT 
    batter, 
    SUM(batsman_runs) AS total_runs,
    COUNT(DISTINCT match_id) AS matches_played
FROM deliveries
GROUP BY batter
ORDER BY total_runs DESC
LIMIT 10;

-- Match Win Percentage After Winning Toss
SELECT 
    toss_decision,
    COUNT(*) AS total_matches,
    SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) AS toss_and_win_count,
    ROUND((SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS win_percentage
FROM matches
WHERE winner != 'No Result'
GROUP BY toss_decision;

-- Top Wicket Takers
SELECT 
    bowler,
    COUNT(*) AS total_wickets
FROM deliveries
WHERE is_wicket = 1 
  AND dismissal_kind NOT IN ('run out', 'retired hurt', 'obstructing the field')
GROUP BY bowler
ORDER BY total_wickets DESC
LIMIT 10;

