CREATE TABLE movies (
    tconst VARCHAR(20) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    start_year INTEGER,
    runtime_minutes INTEGER
);

CREATE TABLE ratings (
    tconst VARCHAR(20) PRIMARY KEY,
    average_rating NUMERIC(3,1),
    num_votes INTEGER DEFAULT 0,

    CONSTRAINT fk_ratings_movies
        FOREIGN KEY (tconst)
        REFERENCES movies(tconst),

    CONSTRAINT chk_average_rating
        CHECK (average_rating BETWEEN 0 AND 10),

    CONSTRAINT chk_num_votes
        CHECK (num_votes >= 0)
);

CREATE TABLE movie_genres (
    tconst VARCHAR(20) NOT NULL,
    genre VARCHAR(50) NOT NULL,

    PRIMARY KEY (tconst, genre),

    CONSTRAINT fk_movie_genres_movies
        FOREIGN KEY (tconst)
        REFERENCES movies(tconst)
);

CREATE TABLE bookings (
    booking_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    event_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tconst VARCHAR(20) NOT NULL,
    cinema_id VARCHAR(50) NOT NULL,
    city VARCHAR(100) NOT NULL,
    seats INTEGER NOT NULL,
    ticket_price NUMERIC(10,2) NOT NULL,
    payment_method VARCHAR(50),

    CONSTRAINT fk_bookings_movies
        FOREIGN KEY (tconst)
        REFERENCES movies(tconst),

    CONSTRAINT chk_booking_seats
        CHECK (seats > 0),

    CONSTRAINT chk_ticket_price
        CHECK (ticket_price >= 0)
);

CREATE TABLE booking_stats_minute (
    window_start TIMESTAMP NOT NULL,
    tconst VARCHAR(20) NOT NULL,
    city VARCHAR(100) NOT NULL,
    bookings BIGINT NOT NULL DEFAULT 0,
    seats BIGINT NOT NULL DEFAULT 0,
    revenue NUMERIC(14,2) NOT NULL DEFAULT 0,

    PRIMARY KEY (window_start, tconst, city),

    CONSTRAINT fk_booking_stats_movies
        FOREIGN KEY (tconst)
        REFERENCES movies(tconst),

    CONSTRAINT chk_stats_bookings
        CHECK (bookings >= 0),

    CONSTRAINT chk_stats_seats
        CHECK (seats >= 0),

    CONSTRAINT chk_stats_revenue
        CHECK (revenue >= 0)
);
