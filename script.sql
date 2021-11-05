drop table if exists bookings;
drop table if exists hotels;
drop table if exists customers;

CREATE TABLE customers (
  id       SERIAL PRIMARY KEY,
  name     VARCHAR(30) NOT NULL,
  email    VARCHAR(120) NOT NULL,
  address  VARCHAR(120),
  city     VARCHAR(30),
  postcode VARCHAR(12),
  country  VARCHAR(20)
);

CREATE TABLE hotels (
  id       SERIAL PRIMARY KEY,
  name     VARCHAR(120) NOT NULL,
  rooms    INT NOT NULL,
  postcode VARCHAR(10)
);

CREATE TABLE bookings (
  id            SERIAL PRIMARY KEY,
  customer_id   INT REFERENCES customers(id),
  hotel_id      INT REFERENCES hotels(id),
  checkin_date  DATE NOT NULL,
  nights        INT NOT NULL
);

INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('John Smith','j.smith@johnsmith.org','11 New Road','Liverpool','L10 2AB','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Sue Jones','s.jones1234@gmail.com','120 Old Street','London','N10 3CD','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Alice Evans','alice.evans001@hotmail.com','3 High Road','Manchester','m13 4ef','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Mohammed Trungpa','mo.trungpa@hotmail.com','25 Blue Road','Manchester','M25 6GH','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Steven King','steve.king123@hotmail.com','19 Bed Street','Newtown', 'xy2 3ac','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Nadia Sethuraman','nadia.sethuraman@mail.com','135 Green Street','Manchester','M10 4BG','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Melinda Marsh','mel.marsh-123@gmail.com','7 Preston Road','Oldham','OL3 5XZ','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Mart�n Sommer','martin.sommer@dfgg.net','C/ Romero, 33','Madrid','28016','Spain');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Laurence Lebihan','laurence.lebihan@xmzx.net','12, rue des Bouchers','Marseille','13008','France');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Keith Stewart','keith.stewart@gmail.com','84 Town Lane','Tadworth','td5 7ng','UK');

INSERT INTO hotels (name, rooms, postcode) VALUES ('Golden Cavern Resort', 10, 'L10ABC');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Elder Lake Hotel', 5, 'L10ABC');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Pleasant Mountain Hotel', 7, 'ABCDE1');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Azure Crown Resort & Spa', 18, 'DGQ127');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Jade Peaks Hotel', 4, 'DGQ127');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Elegant Resort', 14, 'DGQ127');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Cozy Hotel', 20, 'AYD189');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Snowy Echo Motel', 15, 'AYD189');

INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (1, 1, '2019-10-01', 2);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (1, 1, '2019-12-10', 6);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (1, 3, '2019-07-20', 4);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (2, 3, '2020-03-10', 4);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (2, 5, '2020-04-01', 1);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (3, 1, '2019-11-01', 1);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (3, 2, '2019-11-23', 2);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (4, 8, '2019-12-23', 3);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (4, 2, '2019-09-16', 5);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (6, 5, '2019-09-14', 2);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (6, 6, '2020-01-14', 5);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (8, 4, '2020-02-01', 3);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (8, 5, '2020-01-03', 7);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (8, 8, '2019-12-25', 4);

-- Retrieve all information for the customer Laurence Lebihan.
select * from customers where name='Laurence Lebihan';
-- Output
-- 9	Laurence Lebihan	laurence.lebihan@xmzx.net	12, rue des Bouchers	Marseille	13008	France

-- Retrieve all customers name living in UK.
select name from customers where country='UK';
-- Output
-- John Smith
-- Sue Jones
-- Alice Evans
-- Mohammed Trungpa
-- Steven King
-- Nadia Sethuraman
-- Melinda Marsh
-- Keith Stewart

-- Retrieve the address, city and postcode of Melinda Marsh
select address,city,postcode from customers where name='Melinda Marsh';
-- Output
-- 7 Preston Road	Oldham	OL3 5XZ

-- Retrieve all hotels located in the postcode DGQ127.
select * from hotels where postcode='DGQ127';
-- Output
-- 4	Azure Crown Resort & Spa	18	DGQ127
-- 5	Jade Peaks Hotel	4	DGQ127
-- 6	Elegant Resort	14	DGQ127

-- Retrieve all hotels with more than 11 rooms
select * from hotels where rooms > 11;
-- Output
-- 4	Azure Crown Resort & Spa	18	DGQ127
-- 6	Elegant Resort	14	DGQ127
-- 7	Cozy Hotel	20	AYD189
-- 8	Snowy Echo Motel	15	AYD189

-- Retrieve all hotels with more than 6 rooms but less than 15 rooms
select * from hotels where rooms > 6 and rooms < 15;
-- Output
-- 1	Golden Cavern Resort	10	L10ABC
-- 3	Pleasant Mountain Hotel	7	ABCDE1
-- 6	Elegant Resort	14	DGQ127

-- Retrieve all hotels with exactly 10 rooms or 20 rooms
select * from hotels where rooms = 10 or rooms = 20;
-- Output
-- 1	Golden Cavern Resort	10	L10ABC
-- 7	Cozy Hotel	20	AYD189

-- Retrieve all bookings for customer id 1
select * from bookings where customer_id=1;
-- Output
-- 1	1	1	2019-10-01	2
-- 2	1	1	2019-12-10	6
-- 3	1	3	2019-07-20	4

-- Retrieve all bookings for more than 4 nights.
select * from bookings where nights > 4;
-- Output
-- 2	1	1	2019-12-10	6
-- 9	4	2	2019-09-16	5
-- 11	6	6	2020-01-14	5
-- 13	8	5	2020-01-03	7

-- Retrieve all bookings starting in 2020
select * from bookings where checkin_date >= '2020-01-01';
-- Output
-- 4	2	3	2020-03-10	4
-- 5	2	5	2020-04-01	1
-- 11	6	6	2020-01-14	5
-- 12	8	4	2020-02-01	3
-- 13	8	5	2020-01-03	7

-- Retrieve all bookings before 2020 for less than 4 nights
select * from bookings where checkin_date < '2020-01-01' and nights < 4;
-- Output
-- 1	1	1	2019-10-01	2
-- 6	3	1	2019-11-01	1
-- 7	3	2	2019-11-23	2
-- 8	4	8	2019-12-23	3
-- 10	6	5	2019-09-14	2

-- EXERCISE 1 WEEK 2
-- For example, to add a new column to the existing customers table:2
alter table customers add column date_of_birth date;

-- To rename the table customers into clients:
alter table customers rename column date_of_birth to birthdate;

-- To delete an existing column from the customers table:
alter table customers drop column birthdate;

-- EXERCISE 2 WEEK 2
-- creating a table
create table test (
	id serial primary key	
);

-- deleting a table
drop table test;

-- EXERCISE 3 WEEK 2

-- Update the postcode of the hotel named Elder Lake Hotel to L10XYZ
update hotels set postcode='L10XYZ' where name='Elder Lake Hotel';

-- Update the number of rooms of Cozy Hotel to 25
update hotels set rooms=25 where name='Cozy Hotel';

-- For the customer named Nadia Sethuraman, update her address to 2 Blue Street, her city to Glasgow and her postcode to G11ABC 
-- in one query
update customers set address='2 Blue Street', city='Glasgow', postcode='G11ABC' where name='Nadia Sethuraman';

-- Update all the bookings of customer with ID 1 for the hotel with ID 1 to 5 nights in one query
update bookings set nights=5 where customer_id=1 and hotel_id=1;

-- EXERCISE 4 WEEK 2

-- Delete the booking of customer ID 8 for the date 2020-01-03
delete from bookings where customer_id=8 and checkin_date='2020-01-03';

-- Delete all the bookings of customer ID 6
delete from bookings where customer_id=6;

-- Delete the customer with ID 6
delete from customers where id=6;

-- EXERCISE 5 WEEK 2

-- selecting a customer
select * from customers where name='John Smith';

-- all bookings
select * from bookings where id=1;

-- get all the same information like above with a single query!
select 	
	c.name as customer_name, 
	h.name as hotel_name, 
	b.checkin_date, 
	b.nights 
from customers c 
inner join bookings b on b.customer_id=c.id 
inner join hotels h on h.id=b.hotel_id
where c.name='John Smith';

-- give me ONLY the hotel names where Martin Sommer has stayed or will stay
select
	h.name as hotel_name
from customers c 
inner join bookings b on b.customer_id=c.id
inner join hotels h on h.id=b.hotel_id
where c.name='Martín Sommer';

select * from customers;

-- Retrieve all the bookings along with customer data for bookings starting in 2020
select *
from bookings b
inner join customers c on c.id=b.customer_id
where b.checkin_date >= '2020-01-01' and b.checkin_date <= '2020-12-31';

-- Retrieve the customer names, booking start dates and number of nights for all customers who 
-- booked the hotel name Jade Peaks Hotel
select 
	c.name as customer_name,
	b.checkin_date,
	b.nights 
from customers c 
inner join bookings b on b.customer_id=c.id 
inner join hotels h on h.id=b.hotel_id 
where h.name='Jade Peaks Hotel';

-- Retrieve all the booking start dates with customer names and hotel names for all bookings for more than 5 nights
select 
	b.checkin_date,
	c.name as customer_name,
	h.name as hotel_name
from bookings b
inner join customers c on b.customer_id=c.id 
inner join hotels h on h.id=b.hotel_id
where b.nights >= 5;

-- EXERCISE 6 WEEK 2

-- returning a table with order by id 
select * from customers order by id;

-- returning a table by id in a descending way
select * from bookings order by id desc;

-- returning just 5 hotels from a table hotels
select * from hotels limit 5;

-- returning just a especific ids
select * from customers where id in (1,3,7);

-- returning all the names from the table where the name start with a S if you use '%%'
-- is that the name have to include those letters together
select * from customers where name like 'S%';

-- Retrieve all customers whose name starts with the letter S
select * from customers where name like 'S%';

-- Retrieve all hotels which have the word Hotel in their name
select * from hotels where name like '%Hotel%';

-- Retrieve the booking start date, customer name, hotel name for the top 5 bookings ordered 
-- by number of nights in descending order
select
	b.nights,
	b.checkin_date,
	c.name as customer_name,
	h.name as hotel_name
from bookings b 
inner join customers c on c.id=b.customer_id 
inner join hotels h on h.id=b.hotel_id
order by nights desc
limit 5;