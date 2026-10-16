# Event Ticketing and Venue Booking System

A RESTful web application for managing users, events, venues and ticket bookings.
Built for **SWC 3633 Web API Development** (Group 5).

- **Backend:** PHP (PDO), MySQL/MariaDB, JWT authentication
- **Frontend:** a single-page app (`front_end/index.html`) in HTML, CSS and vanilla JavaScript
- **Third-party API:** SendGrid (booking confirmation and cancellation emails)
- **Local server:** XAMPP

## My contribution (Muhammad Amirul Asyraf bin Bosri, AM2512021779)

- **Venues RESTful API** (`backend/venues.php`): list, view, create, update and delete venues, with validation, search, filtering, sorting, pagination and business rules.
- **Individual frontend "Gate Pass"** (`front_end/index.html`): a role-based interface for Administrator, Organiser, Staff and Customer.
- Postman testing of the Venues API.

The other backend modules were developed by the other group members.

## Features

- Login with JWT (token expires after 1 hour)
- Role-based access control: Administrator, Organiser, Staff, Customer
- Customers browse published events, book tickets and cancel bookings
- Organisers and Staff create, edit and delete events
- Administrators manage users and venues and view every booking
- Search, filtering, sorting and pagination on the APIs
- Booking confirmation and cancellation emails through SendGrid

## Role permissions

| Role | Events | Bookings | Venues | Users |
| --- | --- | --- | --- | --- |
| Administrator | View all (read-only) | View and cancel all | Full CRUD | Full CRUD |
| Organiser | Create, edit and delete own events | View bookings for own events | View | No access |
| Staff | Create, edit and delete any event | View all | View | No access |
| Customer | View published events | Create, view and cancel own bookings | View | No access |

## Project structure

```text
events_booking/
├── backend/
│   ├── auth.php        # JWT authentication and role checks
│   ├── bookings.php    # Bookings API
│   ├── db.php          # Database connection (PDO)
│   ├── events.php      # Events API
│   ├── login.php       # Login API
│   ├── users.php       # Users API
│   └── venues.php      # Venues API
├── database/
│   └── database.sql    # Tables and sample data
├── front_end/
│   └── index.html      # Gate Pass frontend
├── composer.json
├── composer.lock
├── api.md              # Postman guide
└── README.md
```

## Requirements

- XAMPP (Apache, PHP 8 and MySQL/MariaDB)
- PHP cURL extension enabled (needed for SendGrid)
- Optional: Composer, to install the `firebase/php-jwt` library

## Installation

1. Copy the project folder to `C:\xampp\htdocs\events_booking`.
2. Start **Apache** and **MySQL** in the XAMPP Control Panel.
3. Open phpMyAdmin, create a database named `events_booking`, and import
   `database/database.sql` into it.
4. Open `backend/db.php` and make sure the settings match your setup:

   ```php
   $host = "127.0.0.1";
   $port = 3306;
   $dbname = "events_booking";   // must match the database you created
   $username = "root";
   $password = "";
   ```

5. Set the secrets as Apache environment variables. Open `C:\xampp\apache\conf\httpd.conf`,
   add these lines at the bottom, then **restart Apache**:

   ```apache
   SetEnv EVENT_BOOKING_JWT_SECRET "use-a-long-random-string"
   SetEnv SENDGRID_API_KEY "your-sendgrid-key"
   ```

   The JWT secret is required, otherwise login returns a 500 error.
   The SendGrid key is optional: without it bookings still work, but the API
   reports `email_sent: false`. Never put real keys in the source code or in GitHub.

6. (Optional) From the project folder, run `composer install` to install the JWT library.
   The backend has a built-in fallback if it is missing.
7. Open the app:

   ```text
   http://localhost/events_booking/front_end/index.html
   ```

   Serve the page from the same XAMPP host as the backend. `events.php` and `users.php`
   do not send CORS headers, so opening the page from another port or server will fail.

## Sign in

Use any account in the `users` table. The sample data contains one account for each role
(Administrator, Organiser and Customer). An administrator can create more accounts from
the **Users** page. Passwords stored as plain text are converted to secure hashes the first
time that user logs in.

## API overview

Every request except `login.php` needs the header `Authorization: Bearer <token>`.
All responses are JSON.

| Endpoint | Methods | Notes |
| --- | --- | --- |
| `login.php` | POST | Returns a JWT and the user profile |
| `users.php` | GET, POST, PUT, DELETE | Administrator only |
| `events.php` | GET, POST, PUT, DELETE | GET for all roles; write for Organiser and Staff |
| `bookings.php` | GET, POST, PUT | Customers create and cancel; staff view |
| `venues.php` | GET, POST, PUT, PATCH, DELETE | GET for all roles; write for Administrator |

### Venues API

```http
GET    /backend/venues.php?page=1&limit=10&search=hall&status=Available&sort=capacity&order=desc
GET    /backend/venues.php?id=1
POST   /backend/venues.php
PUT    /backend/venues.php?id=1
DELETE /backend/venues.php?id=1
```

Example request body:

```json
{
  "venue_name": "Nilam Hall",
  "location": "UPTM Campus",
  "capacity": 100,
  "status": "Available"
}
```

Rules enforced by the API:

- `venue_name` (up to 100 characters), `location` (up to 255) and `capacity` (whole number above 0) are required.
- `status` is `Available`, `In Use` or `Unavailable`.
- A venue with the same name at the same location cannot be created twice (409).
- Capacity cannot be lowered below the tickets of an assigned event (409).
- A venue used by an active event must stay `In Use` (409).
- A venue that still has events cannot be deleted (409).

### HTTP status codes

| Code | Meaning |
| --- | --- |
| 200 / 201 | Success / created |
| 400 | Invalid ID or query parameter |
| 401 | Missing, invalid or expired token |
| 403 | Role not allowed |
| 404 | Record not found |
| 409 | Conflict with a business rule or duplicate |
| 422 | Validation failed (field errors are returned) |
| 500 | Server error |

## Troubleshooting

- **"Database connection failed":** `$dbname`, `$port` or the password in `backend/db.php` does not match your MySQL setup.
- **"Authentication service is not configured":** `EVENT_BOOKING_JWT_SECRET` is not set, or Apache was not restarted.
- **Booking says the email could not be sent:** `SENDGRID_API_KEY` is missing, or the sender address is not verified in SendGrid.
- **401 after some time:** the token lasts 1 hour. Log in again.
- **Page cannot reach the server:** check that Apache is running and the page is opened from `http://localhost/events_booking/...`.

## Security notes

- Passwords are stored as hashes (`password_hash`).
- Do not commit API keys, JWT secrets or database passwords.
- Revoke and replace any key that has been exposed.
- Replace demo credentials before any real deployment.
