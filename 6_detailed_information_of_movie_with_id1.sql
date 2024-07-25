SELECT 
    m.id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    JSON_OBJECT('id', f.id, 'file_name', f.file_name, 'mime_type', f.mime_type, 'url', f.url) AS poster,
    JSON_OBJECT('id', d.id, 'first_name', d.first_name, 'last_name', d.last_name) AS director,
    CONCAT(
        '[', 
        GROUP_CONCAT(
            JSON_OBJECT(
                'id', a.id,
                'first_name', a.first_name,
                'last_name', a.last_name,
                'photo', 
                CONCAT(
                    '{',
                    '"id":', IFNULL(af.id, 'null'), ',',
                    '"file_name":"', IFNULL(af.file_name, ''), '",',
                    '"mime_type":"', IFNULL(af.mime_type, ''), '",',
                    '"url":"', IFNULL(af.url, ''), '"',
                    '}'
                )
            )
            SEPARATOR ','
        ), 
        ']'
    ) AS actors,
    CONCAT(
        '[', 
        GROUP_CONCAT(
            JSON_OBJECT(
                'id', g.id,
                'name', g.name
            )
            SEPARATOR ','
        ), 
        ']'
    ) AS genres
FROM 
    movies m
    LEFT JOIN files f ON m.poster_file_id = f.id
    LEFT JOIN people d ON m.director_id = d.id
    LEFT JOIN characters c ON m.id = c.movie_id
    LEFT JOIN people a ON c.actor_id = a.id
    LEFT JOIN files af ON a.primary_photo_id = af.id
    LEFT JOIN movie_genres mg ON m.id = mg.movie_id
    LEFT JOIN genres g ON mg.genre_id = g.id
WHERE 
    m.id = 1
GROUP BY 
    m.id, f.id, d.id;