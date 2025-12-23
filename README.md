# Vehicle Rental System Database

This is a relational database designed to manage a vehicle rental service. It keeps track of users, vehicles, and bookings.

There are 4 queries for demonstrating the concepts of **JOIN, EXISTS, WHERE, GROUP BY, HAVING, and COUNT**.

---

## users

| Column Name  | Description              |
| ------------ | ------------------------ |
| user_id (PK) | Primary key              |
| name         | Name of the user         |
| email        | Email address            |
| phone        | Phone number             |
| role         | Role (Admin or Customer) |

---

## vehicles

| Column Name         | Description                             |
| ------------------- | --------------------------------------- |
| vehicle_id (PK)     | Primary key                             |
| name                | Name of the vehicle                     |
| type                | Type (car, bike, truck)                 |
| model               | Vehicle model                           |
| registration_number | Vehicle registration number             |
| rental_price        | Rental price                            |
| status              | Status (available, rented, maintenance) |

---

## bookings

| Column Name                | Description                                       |
| -------------------------- | ------------------------------------------------- |
| booking_id (PK)            | Primary key                                       |
| user_id (FK → users)       | User who made the booking                         |
| vehicle_id (FK → vehicles) | Vehicle booked                                    |
| start_date                 | Start date of the booking                         |
| end_date                   | End date of the booking                           |
| status                     | Status (pending, confirmed, completed, cancelled) |
| total_cost                 | Total cost of the booking                         |

---

## Query 1: JOIN

Retrieve booking information along with **Customer name** and **Vehicle name**.

```sql
SELECT
    users.name,
    vehicles.name
FROM
    bookings
    INNER JOIN users ON users.user_id = bookings.user_id
    INNER JOIN vehicles ON vehicles.vehicle_id = bookings.vehicle_id;

```

This query joins the `bookings` table with `users` and `vehicles` tables and shows the name of the user and the vehicle. The method of join used here is **INNER JOIN**.

---

## Query 2: EXISTS

Find vehicles that have **never been booked**.

```sql

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

```

This query shows the vehicles which have never been booked. It uses a **subquery** with `NOT EXISTS`.

---

## Query 3: WHERE

Retrieve all vehicles of a specific type, e.g., `car`.

```sql
SELECT
    *
FROM
    vehicles
WHERE
    type = 'car';
```

This query demonstrates the use of the **WHERE** clause to filter vehicles by type.

---

## Query 4: GROUP BY and HAVING

Find vehicles that have been **booked more than 2 times**.

```sql
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
    COUNT(*) > 2;
```

This query joins `vehicles` and `bookings` tables, groups by `vehicle_id`, counts the number of bookings per vehicle, and shows only vehicles booked more than 2 times.

---

**Note:** These queries are written in PostgreSQL.
