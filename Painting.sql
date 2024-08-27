select * from artist;
select * from canvas_size;
select * from image_link;
select * from museum_hours;
select * from museum;
select * from product_size;
select * from subject;
select * from work;

-- select * from work where museum_id is null

-- select count( distinct museum_id) from work where museum_id is Not Null 

-- are there museums without any paintings?

/*SELECT *, (SELECT COUNT(DISTINCT museum_id) FROM work
WHERE museum_id IN (SELECT DISTINCT museum_id FROM museum)) AS distinct_museum_count FROM work
WHERE museum_id IN (SELECT DISTINCT museum_id FROM museum)
ORDER BY museum_id ASC


select * from museum m
	where not exists (select * from work w
					 where w.museum_id=m.museum_id)
*/
-- How many paintings have an asking price of more than their regular price? 

/*select * from product_size
where sale_price > regular_price */

-- Identify the paintings whose asking price is less than 50% of its regular price
/*
select w.work_id, w.name, p.sale_price, p.regular_price from product_size p
JOIN work w ON p.work_id = w.work_id
where sale_price < (regular_price*0.50)
order by w.name ASC
*/

-- Which canva size costs the most?

/*
SELECT s.*, (s.width * s.height) AS Size , p.sale_price
FROM canvas_size s
JOIN product_size p ON s.size_id = p.size_id
WHERE (s.width * s.height) IS NOT NULL
AND p.sale_price = (SELECT MAX(sale_price) FROM product_size)
ORDER BY Size ASC;
*/

-- select (count(work_id) - count(Distinct work_id)) As Difference from work

-- Identify the museums with invalid city information in the given dataset

/*
SELECT *
FROM museum
WHERE city REGEXP '[^a-zA-Z ]';
*/
  
  -- Fetch the top 10 most famous painting subject
   
/*
SELECT 
    COUNT(subject) AS top, subject
FROM
    subject
GROUP BY subject
ORDER BY top DESC
LIMIT 10;
*/

--  Identify the museums which are open on both Sunday and Monday. Display museum name, city.

/*
select distinct m.name as museum_name, m.city from museum_hours mh 
	join museum m on m.museum_id=mh.museum_id
	where day='Sunday'
	and exists (select 1 from museum_hours mh2 
				where mh2.museum_id=mh.museum_id 
			    and mh2.day='Monday');
*/

--  How many museums are open every single day?

/*
SELECT mh.museum_id, m.name, m.city
FROM museum_hours mh
JOIN museum m ON mh.museum_id = m.museum_id
WHERE mh.day IN ('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')
GROUP BY mh.museum_id, m.name, m.city
HAVING COUNT(DISTINCT mh.day) = 7;
*/

--  Which are the top 5 most popular museum? (Popularity is defined based on most no of paintings in a museum)

/*
SELECT m.name, w.museum_id, Count(*) AS Total FROM work w
JOIN museum m ON w.museum_id = m.museum_id 
WHERE w.museum_id IS NOT NULL
GROUP BY w.museum_id, m.name
ORDER BY TOTAL DESC  LIMIT  5;
*/

-- Who are the top 5 most popular artist? (Popularity is defined based on most no of paintings done by an artist)

/*
SELECT w.artist_id, a.full_name, a.nationality, count(*) AS Total FROM work w
JOIN artist a ON w.artist_id = a.artist_id
WHERE w.artist_id IS NOT NULL 
GROUP BY w.artist_id, a.full_name, a.nationality
ORDER BY TOTAL DESC LIMIT 5
*/

-- Display the 3 least popular canva sizes

/*
SELECT cs.size_id, cs.label, COUNT(*) AS no_of_paintings
FROM work w
JOIN product_size ps ON ps.work_id = w.work_id
JOIN canvas_size cs ON cs.size_id = ps.size_id
GROUP BY cs.size_id, cs.label
ORDER BY no_of_paintings DESC
LIMIT 3;
*/

--  Which museum is open for the longest during a day. Dispay museum name, state and hours open and which day?

/*
SELECT m.name, m. state, mh.museum_id, count(open - close) + 2 AS Hours_Open from museum_hours mh
JOIN museum m ON mh.museum_id = m.museum_id
GROUP BY mh.museum_id,m.name,m. state
HAVING Hours_Open > 8
ORDER BY m.name ASC
*/

--  Which museum has the most no of most popular painting style?

SELECT museum_id, name, city, state, country FROM museum 
WHERE museum_id = (SELECT museum_id FROM (
        SELECT museum_id, COUNT(museum_id) AS Popular 
        FROM work
        WHERE style IS NOT NULL AND museum_id IS NOT NULL
        GROUP BY museum_id
        ORDER BY Popular DESC
        LIMIT 1
    ) AS popular_museum
);









































