CREATE TABLE
    users (
        user_id SERIAL PRIMARY KEY,
        name varchar(50) NOT NULL,
        email varchar(60) NOT NULL UNIQUE,
        phone varchar(15) NOT NULL,
        role text NOT NULL CHECK (role IN ('Admin', 'Customer'))
    );

CREATE TABLE
    vehicles (
        vehicle_id SERIAL PRIMARY KEY,
        name varchar(70) NOT NULL,
        type varchar(10) NOT NULL CHECK (type IN ('car', 'bike', 'truck')),
        model varchar(20) NOT NULL,
        registration_number varchar(100) NOT NULL UNIQUE,
        rental_price int NOT NULL,
        status text NOT NULL CHECK (status IN ('available', 'rented', 'maintenance'))
    );

CREATE TABLE
    bookings (
        booking_id SERIAL PRIMARY KEY,
        user_id int REFERENCES users (user_id) ON DELETE CASCADE,
        vehicle_id int REFERENCES vehicles (vehicle_id) ON DELETE CASCADE,
        start_date DATE NOT NULL,
        end_date DATE NOT NULL,
        status text NOT NULL CHECK (
            status IN ('pending', 'confirmed', 'completed', 'cancelled')
        ),
        total_cost int NOT NULL
    );

-- Query 1
SELECT
    users.name,
    vehicles.name
FROM
    bookings
    INNER JOIN users ON users.user_id = bookings.user_id
    INNER JOIN vehicles ON vehicles.vehicle_id = bookings.vehicle_id;

-- Query 2
SELECT
    *
FROM
    vehicles
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            bookings
        WHERE
            bookings.vehicle_id = vehicles.vehicle_id
    );

-- Query 3
SELECT
    *
FROM
    vehicles
WHERE
    type = 'car';

-- Query 4
SELECT
    vehicles.vehicle_id,
    vehicles.name,
    COUNT(*) AS "number of bookings"
FROM
    bookings
    INNER JOIN vehicles ON bookings.vehicle_id = vehicles.vehicle_id
GROUP BY
    vehicles.vehicle_id
HAVING
    COUNT(*) > 2