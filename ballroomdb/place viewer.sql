CREATE VIEW fifth_place AS
SELECT 
Scores.score AS Score,
People.name AS Dancers,
Judges.name AS Judge,
Style.name AS Style,
Comp.name AS Competition
FROM Scores
JOIN People ON Scores.people_id = People.id
JOIN Judges ON Scores.judge_id = Judges.id
JOIN Style ON Scores.style_id = Style.id
JOIN Comp ON Scores.comp_id = Comp.id
WHERE Scores.score = 5;

