SELECT 
    u.id AS ID,
    u.username AS Username,
    CASE 
        WHEN GROUP_CONCAT(f.movie_id) IS NOT NULL 
        THEN CONCAT('[', GROUP_CONCAT(DISTINCT f.movie_id ORDER BY f.movie_id), ']')
        ELSE '[]'
    END AS FavoriteMovieIDs
FROM 
    users u
    LEFT JOIN favorites f ON u.id = f.user_id
GROUP BY 
    u.id, u.username;