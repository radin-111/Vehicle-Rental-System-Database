CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name varchar(50) NOT NULL,
    email varchar(60) NOT NULL UNIQUE,
    phone varchar(15) NOT NULL,
    role text NOT NULL CHECK (role IN ('Admin', 'Customer'))
);
CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    name varchar(70) NOT NULL,
    type varchar(10) NOT NULL CHECK (type IN ('car', 'bike', 'truck')),
    model varchar(20) NOT NULL,
    registration_number varchar(100) NOT NULL UNIQUE,
    rental_price int NOT NULL,
    status text NOT NULL CHECK (status IN ('available', 'rented', 'maintenance'))
);
CREATE TABLE bookings (
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