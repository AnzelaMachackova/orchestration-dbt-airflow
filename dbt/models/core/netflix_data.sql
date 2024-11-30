WITH updated_columns AS (
    SELECT
        title,
        type,
        genres,
        releaseYear AS release_year,
        imdbId AS imdb_id,
        imdbAverageRating AS imdb_average_rating,
        imdbNumVotes AS imdb_num_votes,
        availableCountries AS available_countries,
        ROUND(imdbAverageRating) AS rounded_rating
    FROM {{ source('raw_data', 'raw_netflix_data') }}
),

joined_with_ratings AS (
    SELECT
        rc.title,
        rc.type,
        rc.genres,
        rc.release_year,
        rc.imdb_id,
        rc.imdb_average_rating,
        rc.imdb_num_votes,
        rc.available_countries,
        rt.description AS rating_description
    FROM updated_columns rc
    LEFT JOIN {{ ref('rating') }} rt 
    ON rc.rounded_rating = rt.rating
)

SELECT * FROM joined_with_ratings