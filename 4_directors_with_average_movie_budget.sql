SELECT 
    p.id AS DirectorID,
    CONCAT(p.first_name, ' ', p.last_name) AS DirectorName,
    ROUND(COALESCE(AVG(m.budget), 0), 2) AS AverageBudget
FROM 
    people p
    LEFT JOIN movies m ON p.id = m.director_id
GROUP BY 
    p.id, p.first_name, p.last_name
HAVING 
    COUNT(m.id) > 0
ORDER BY 
    AverageBudget DESC;