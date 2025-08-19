CREATE DATABASE company_db;
USE company_db;

CREATE TABLE country (
    id INT PRIMARY KEY,
    country_name VARCHAR(50),
    country_name_eng VARCHAR(50),
    country_code VARCHAR(10)
);

CREATE TABLE city (
    id INT PRIMARY KEY,
    city_name VARCHAR(50),
    lat DECIMAL(10,6),
    lon DECIMAL(10,6),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(id)
);

CREATE TABLE customer (
    id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city_id INT,
    customer_address VARCHAR(100),
    next_call_date DATE,
    ts_inserted DATETIME,
    FOREIGN KEY (city_id) REFERENCES city(id)
);


INSERT INTO country (id, country_name, country_name_eng, country_code) VALUES
(1, 'Deutschland', 'Germany', 'DEU'),
(2, 'Srbija', 'Serbia', 'SRB'),
(3, 'Hrvatska', 'Croatia', 'HRV'),
(4, 'United States of America', 'United States of America', 'USA'),
(5, 'Polska', 'Poland', 'POL'),
(6, 'Espana', 'Spain', 'ESP'),
(7, 'Rossiya', 'Russia', 'RUS');

INSERT INTO city (id, city_name, lat, lon, country_id) VALUES
(1, 'Berlin', 52.520008, 13.404954, 1),
(2, 'Belgrade', 44.787197, 20.457273, 2),
(3, 'Zagreb', 45.815399, 15.966568, 3),
(4, 'New York', 40.730610, -73.935242, 4),
(5, 'Los Angeles', 34.052235, -118.243683, 4),
(6, 'Warsaw', 52.237049, 21.017532, 5);

INSERT INTO customer (id, customer_name, city_id, customer_address, next_call_date, ts_inserted) VALUES
(1, 'Jewelry Store', 4, 'Long Street 120', '2020-01-21', '2020-01-09 14:01:20'),
(2, 'Bakery', 1, 'Kurfürstendamm 25', '2020-01-22', '2020-01-09 17:52:15'),
(3, 'Café', 3, 'Tauentzienstraße 44', '2020-01-21', '2020-01-10 08:02:49'),
(4, 'Restaurant', 2, 'Ulica Ipa 15', '2020-01-21', '2020-01-10 09:20:21');


select * from city;
select * from country;
select * from customer;

#List all Countries and customers related to these countries.

select 
co.country_name,
cu.customer_name
from country co
left join city ci
on co.id=ci.country_id
left join customer cu
on cu.city_id=ci.id;


-- For each country displaying its name in English, the name of the city customer is located in as
-- well as the name of the customer. 

select 
	co.country_name_eng,
	ci.city_name,
    cu.customer_name
from country co
left join city ci
on co.id=ci.country_id
left join customer cu
on ci.id=cu.city_id;

#Return even countries without related cities and customers

select 
co.country_name,
co.country_name_eng
from country co
left join city
on co.id=city.country_id
LEFT JOIN customer cu 
    ON city.id = cu.city_id
WHERE city.id IS NULL 
   OR cu.id IS NULL
group by co.id,co.country_name, co.country_name_eng;


-- Return the list of all countries that have pairs(exclude countries which are not referenced by any
-- city). For such pairs return all customers.

select 
	ci.city_name,
    country.country_name,
    cu.customer_name
from city ci
join country
on ci.country_id=country.id
left join customer cu
on ci.id=cu.city_id;


#Return even pairs of not having a single customer
select 
	ci.city_name,
    country.country_name
from city ci
join country
on ci.country_id=country.id
left join customer cu
on ci.id=cu.city_id
where cu.id is null ;

