SELECT 
    m.id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    JSON_OBJECT('id', f.id, 'file_name', f.file_name, 'mime_type', f.mime_type, 'url', f.url) AS poster,
    JSON_OBJECT('id', d.id, 'first_name', d.first_name, 'last_name', d.last_name) AS director
FROM 
    movies m
    LEFT JOIN files f ON m.poster_file_id = f.id
    LEFT JOIN people d ON m.director_id = d.id
WHERE 
    m.country_id = 1
    AND m.release_date >= '2022-01-01'
    AND m.duration > '02:15:00'
    AND (EXISTS (SELECT 1 FROM movie_genres mg JOIN genres g ON mg.genre_id = g.id WHERE mg.movie_id = m.id AND g.name IN ('Action', 'Drama')));