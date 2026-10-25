CREATE TABLE movies (
    movie_id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_date DATE,
    rating DECIMAL(3,1),
    popularity DECIMAL(12,3),
    language VARCHAR(10),
    overview TEXT,
    rating_category VARCHAR(20),
    popularity_category VARCHAR(20),
    movie_age INT,
    CONSTRAINT chk_movies_rating
        CHECK (rating IS NULL OR (rating >= 0 AND rating <= 10)),

    CONSTRAINT chk_movies_popularity
        CHECK (popularity IS NULL OR popularity >= 0),

    CONSTRAINT chk_movies_age
        CHECK (movie_age IS NULL OR movie_age >= 0)
);

CREATE TABLE booking_analytics (
    booking_id VARCHAR(50) PRIMARY KEY,
    movie_id VARCHAR(50) NOT NULL,
    movie_name VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    theater VARCHAR(150) NOT NULL,

    tickets INT NOT NULL,
    ticket_price BIGINT NOT NULL,
    total_amount BIGINT NOT NULL,

    booking_status ENUM('CONFIRMED', 'CANCELLED') NOT NULL,
    booking_time TIMESTAMP NOT NULL,
    booking_date DATE NOT NULL,
    booking_hour INT NOT NULL,
    revenue_category ENUM('Low', 'Medium', 'High') NOT NULL,

    CONSTRAINT chk_booking_movies
        FOREIGN KEY (movie_id)
        REFERENCES movies(movie_id),

    CONSTRAINT chk_booking_tickets
        CHECK (tickets > 0),

    CONSTRAINT chk_booking_ticket_price
        CHECK (ticket_price >= 0),

    CONSTRAINT chk_booking_total_amount
        CHECK (total_amount >= 0),

    CONSTRAINT chk_booking_hour
        CHECK (booking_hour BETWEEN 0 AND 23)
);