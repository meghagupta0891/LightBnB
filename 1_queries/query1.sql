-- User login
-- SELECT id, name, email, password from users where email ='asherpoole@gmx.com';

--Average Duration

SELECT AVG(end_date - start_date) AS average_duration
FROM reservations;

-- All reservations for user
SELECT properties.id, title, cost_per_night, start_date, avg(rating) FROM properties
INNER JOIN property_reviews AS reviews
ON reviews.property_id = properties.id
INNER JOIN reservations AS res
ON res.property_id = reviews.property_id
INNER JOIN users
ON reviews.guest_id = users.id
WHERE res.guest_id = 1
AND end_date < now()::date
GROUP BY properties.id, title, cost_per_night, start_date
ORDER BY start_date
LIMIT 10

--Property list by city
SELECT city, COUNT(reservations.*) AS total_reservations FROM properties
INNER JOIN reservations
ON property_id = properties.id
GROUP BY city
ORDER BY total_reservations DESC;

--Most visited city
SELECT properties.id, title, cost_per_night, AVG(rating)
FROM properties INNER JOIN property_reviews
ON properties.id = property_id
WHERE city LIKE '%Vancouver%'
GROUP BY properties.id, title, cost_per_night
HAVING AVG(rating) >= 4
ORDER BY cost_per_night
limit 10;