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
    u.name AS customer_name,
    v.name AS vehicle_name
FROM
    bookings b
    INNER JOIN users u ON u.user_id = b.user_id
    INNER JOIN vehicles v ON v.vehicle_id = b.vehicle_id;
```

This query joins the `bookings` table with `users` and `vehicles` tables and shows the name of the user and the vehicle. The method of join used here is **INNER JOIN**.

---

## Query 2: EXISTS

Find vehicles that have **never been booked**.

```sql
SELECT
    *
FROM
    vehicles v
WHERE
    NOT EXISTS (
        SELECT 1
        FROM bookings b
        WHERE b.vehicle_id = v.vehicle_id
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
    v.vehicle_id,
    v.name,
    COUNT(b.booking_id) AS number_of_bookings
FROM
    bookings b
    INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id
GROUP BY
    v.vehicle_id
HAVING
    COUNT(b.booking_id) > 2;
```

This query joins `vehicles` and `bookings` tables, groups by `vehicle_id`, counts the number of bookings per vehicle, and shows only vehicles booked more than 2 times.

---

**Note:** These queries are written in PostgreSQL.
