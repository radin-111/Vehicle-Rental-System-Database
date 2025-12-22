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