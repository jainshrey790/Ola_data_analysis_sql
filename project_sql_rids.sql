CREATE DATABASE IF NOT EXISTS Bookings;

USE Bookings;

DROP TABLE IF EXISTS Ola_Bookings;

CREATE TABLE Ola_Bookings (
Date1 DATE,
    Time1 TIME,
    Booking_id VARCHAR(255),
    Booking_status VARCHAR(255),
    Customer_ID VARCHAR(255),
    Vehicle_type VARCHAR(255),
    Pickup_Location VARCHAR(255),
    Drop_Location VARCHAR(255),
    V_TAT INT,
    C_TAT INT,
    Canceled_Rides_by_customer VARCHAR(255),
    Canceled_Rides_by_Driver VARCHAR(255),
    Incomplete_Rides VARCHAR(10),
    Incomplete_Rides_Reason VARCHAR(255),
    Booking_Value INT,
    Payment_Method VARCHAR(50),
    Ride_Distance INT,
    Driver_Ratings FLOAT,
    Customer_Ratings FLOAT,
    Vehicle_Images VARCHAR(255)
);
DESCRIBE Ola_Bookings;
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Data/bookings/uber.csv'
INTO TABLE Ola_Bookings
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM Ola_Bookings;
-- LIMIT 1;

#1. Retrive all successful bookings:
CREATE VIEW successful_bookings AS
SELECT * FROM Ola_Bookings
WHERE Booking_status = 'Success';

#1. Retrive all successful bookings:
SELECT * FROM successful_bookings;

#2. Find the averae ride distance for each type of vehicle .
create view ride_distance_for_each_vehicle As 
SELECT Vehicle_type , Avg(Ride_Distance) 
FROM Ola_Bookings
group by Vehicle_type;

SELECT * FROM ride_distance_for_each_vehicle;

#3. Find the total no. of rides cancelled by customer 
SELECT COUNT(*) FROM Ola_Bookings
WHERE Booking_status = 'Canceled by Customer';

#4. List the top 5 customers who has booked the highest no. of rides 
SELECT Customer_ID, COUNT(Booking_id) as total_rides
FROM Ola_Bookings
GROUP BY Customer_ID
ORDER BY total_rides DESC
LIMIT 5;

SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

#5. Get the no. of rides canceled by drivers due to personal and car related issues :
SELECT COUNT(*) 
from Ola_Bookings
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';

#6. Find the max and min driver ratings for Prime Sedan Bookings:
SELECT MAX(Driver_Ratings) as max_rating,
MIN(Driver_Ratings) as min_rating
FROM Ola_Bookings
WHERE Vehicle_Type = 'Prime Sedan';

#7. Retrieve all rides where payment was made using UPI
SELECT * FROM Ola_Bookings
WHERE Payment_Method = "UPI";

#8. Find the average customer rating per vehicle type 
SELECT Vehicle_Type, AVG(Customer_Ratings) AS avg_customer_rating
FROM Ola_Bookings
GROUP BY Vehicle_type; 

#9. Calculate the total booking value of rides completed successfully:
SELECT SUM(Booking_Value) as total_successful_ride_value
FROM Ola_Bookings
WHERE Booking_status = 'Success';

#10. List all incomplete rides with the reason
SELECT  Booking_id, Incomplete_Rides_Reason 
FROM Ola_Bookings
WHERE Incomplete_Rides = 'Yes';

















