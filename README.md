# Vehicle Rental System Database

This is a relational database designed to manage a vehicle rental service. It keeps track of users, vehicles, and bookings.

There are 4 queries for demonstrating the concepts of **JOIN, EXISTS, WHERE, GROUP BY, HAVING, and COUNT**.  

The three tables are:

---

## users
| Column Name | Description |
| ----------- | ----------- |
| user_id (PK) | Primary key |
| name | Name of the user |
| email | Email address |
| phone | Phone number |
| role | Role (Admin or Customer) |

---

## vehicles
| Column Name | Description |
| ----------- | ----------- |
| vehicle_id (PK) | Primary key |
| name | Name of the vehicle |
| type | Type (car, bike, truck) |
| model | Vehicle model |
| registration_number | Vehicle registration number |
| rental_price | Rental price |
| status | Status (available, rented, maintenance) |

---

## bookings
| Column Name | Description |
| ----------- | ----------- |
| booking_id (PK) | Primary key |
| user_id (FK → users) | User who made the booking |
| vehicle_id (FK → vehicles) | Vehicle booked |
| start_date | Start date of the booking |
| end_date | End date of the booking |
| status | Status (pending, confirmed, completed, cancelled) |
| total_cost | Total cost of the booking |

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
