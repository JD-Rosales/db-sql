erDiagram
USERS {
INT id PK "AUTO_INCREMENT"
VARCHAR(50) username "UNIQUE NOT NULL"
VARCHAR(50) first_name "NOT NULL"
VARCHAR(50) last_name "NOT NULL"
VARCHAR(100) email "UNIQUE NOT NULL"
VARCHAR(255) password "NOT NULL"
INT avatar_file_id FK "FILES(id)"
TIMESTAMP created_at
TIMESTAMP updated_at
}

    FILES {
        INT id PK "AUTO_INCREMENT"
        VARCHAR(255) file_name "NOT NULL"
        VARCHAR(100) mime_type "NOT NULL"
        VARCHAR(255) file_key "NOT NULL"
        VARCHAR(255) url "NOT NULL"
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    COUNTRIES {
        INT id PK "AUTO_INCREMENT"
        VARCHAR(100) name "UNIQUE NOT NULL"
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    PEOPLE {
        INT id PK "AUTO_INCREMENT"
        VARCHAR(50) first_name "NOT NULL"
        VARCHAR(50) last_name "NOT NULL"
        TEXT biography
        ENUM gender "male, female, other"
        INT country_id FK "COUNTRIES(id)"
        INT primary_photo_id FK "FILES(id)"
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

     PERSON_PHOTOS {
        INT person_id FK "PEOPLE(id)"
        INT file_id FK "FILES(id)"
        BOOLEAN is_primary NOT NULL
    }

    GENRES {
        INT id PK "AUTO_INCREMENT"
        VARCHAR(50) name "UNIQUE NOT NULL"
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    MOVIES {
        INT id PK "AUTO_INCREMENT"
        VARCHAR(255) title "NOT NULL"
        TEXT description "NOT NULL"
        DECIMAL budget "20, 2"
        DATE release_date "NOT NULL"
        TIME duration "NOT NULL"
        INT director_id FK "PEOPLE(id)"
        INT country_id FK "COUNTRIES(id)"
        INT poster_file_id FK "FILES(id)"
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    MOVIE_GENRES {
        INT movie_id FK "MOVIES(id)"
        INT genre_id FK "GENRES(id)"
    }

    CHARACTERS {
        INT id PK "AUTO_INCREMENT"
        VARCHAR(255) name NOT NULL
        TEXT description NOT NULL
        ENUM role "leading, supporting, background"
        INT movie_id FK "MOVIES(id)"
        INT actor_id FK "PEOPLE(id)"
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    FAVORITES {
        INT user_id FK "USERS(id)"
        INT movie_id FK "MOVIES(id)"
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    USERS ||--o{ FILES : "avatar_file_id"
    COUNTRIES ||--o{ PEOPLE : "country_id"
    FILES ||--o{ PEOPLE : "primary_photo_id"
    PEOPLE ||--o{ PERSON_PHOTOS : "person_id"
    FILES ||--o{ PERSON_PHOTOS : "file_id"
    PEOPLE ||--o{ MOVIES : "director_id"
    COUNTRIES ||--o{ MOVIES : "country_id"
    FILES ||--o{ MOVIES : "poster_file_id"
    MOVIES ||--o{ MOVIE_GENRES : "movie_id"
    GENRES ||--o{ MOVIE_GENRES : "genre_id"
    MOVIES ||--o{ CHARACTERS : "movie_id"
    PEOPLE ||--o{ CHARACTERS : "actor_id"
    USERS ||--o{ FAVORITES : "user_id"
    MOVIES ||--o{ FAVORITES : "movie_id"
