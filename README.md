Famous-Paintings-Insights-SQL
Overview
This project explores the Famous Paintings & Museum dataset from Kaggle, aiming to gain insights using SQL queries. The dataset includes information about paintings, museums, artists, and related details.

Dataset Source
The dataset was obtained from Kaggle and consists of CSV files containing information about famous paintings, museums, and more.

Project Structure
The project includes Python scripts for loading CSV files into a SQL database and SQL queries for analyzing the dataset. The queries are designed to answer various questions related to paintings, museums, and artists.

Project Files
loadDataToSQL.py: Python script to load CSV files into the SQL database.
queriesSolved.sql: SQL Script for each query.
Running the Code
Load CSV files to SQL Database:

Execute the loadDataToSQL.py script to load CSV files into your SQL database.
Run SQL Queries:

Execute SQL queries from the queriesSolved.sql to gain insights from the dataset.
Query Difficulty Levels
Basic Level: Simple queries involving selections and filtering.
Intermediate Level: Queries with aggregations, joins, and conditional filtering.
Advanced Level: Complex queries requiring subqueries, aggregations, and data manipulation.
Contributions
Contributions, issues, and feature requests are welcome. Feel free to open an issue for discussions or submit a pull request.

License
This project is licensed under the MIT License.

Acknowledgements
Special thanks to Kaggle for providing the Famous Paintings dataset.



# MySQL_Painting-Analysis

1,"Are there museums that don't have any paintings?"

select * from museum m
	where not exists (select * from work w
					 where w.museum_id=m.museum_id)

![image](https://github.com/user-attachments/assets/a1675aff-71ea-48cd-a22b-7385cd9bc570)

2,How many paintings have an asking price of more than their regular price? 

select * from product_size
where sale_price > regular_price

![image](https://github.com/user-attachments/assets/da1c7d8c-5ee4-48b0-89fa-255d51e013c6)

3,Identify the paintings whose asking price is less than 50% of its regular price

select w.work_id, w.name, p.sale_price, p.regular_price from product_size p
JOIN work w ON p.work_id = w.work_id
where sale_price < (regular_price*0.50)
order by w.name ASC

![image](https://github.com/user-attachments/assets/23158d86-ece6-452a-8e53-9ca82da27103)

4, Which canva size costs the most?


SELECT s.*, (s.width * s.height) AS Size , p.sale_price
FROM canvas_size s
JOIN product_size p ON s.size_id = p.size_id
WHERE (s.width * s.height) IS NOT NULL
AND p.sale_price = (SELECT MAX(sale_price) FROM product_size)
ORDER BY Size ASC;

![image](https://github.com/user-attachments/assets/dc83b371-6608-4692-8ffa-d1825f8d77a6)

5,Identify the museums with invalid city information in the given dataset

SELECT *
FROM museum
WHERE city REGEXP '[^a-zA-Z ]';

![image](https://github.com/user-attachments/assets/c331744d-ac8f-4be2-817b-1ff5d632822f)

6, Fetch the top 10 most famous painting subject

SELECT 
    COUNT(subject) AS top, subject
FROM
    subject
GROUP BY subject
ORDER BY top DESC
LIMIT 10;

![image](https://github.com/user-attachments/assets/2be3f7af-6243-447d-8642-c2434198e8d3)

7, Identify the museums which are open on both Sunday and Monday. Display museum name, city.

select distinct m.name as museum_name, m.city from museum_hours mh 
	join museum m on m.museum_id=mh.museum_id
	where day='Sunday'
	and exists (select 1 from museum_hours mh2 
				where mh2.museum_id=mh.museum_id 
			    and mh2.day='Monday');

![image](https://github.com/user-attachments/assets/ebcd8de5-d7ad-410e-a9af-797508597bb8)

8, How many museums are open every single day?

SELECT mh.museum_id, m.name, m.city
FROM museum_hours mh
JOIN museum m ON mh.museum_id = m.museum_id
WHERE mh.day IN ('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')
GROUP BY mh.museum_id, m.name, m.city
HAVING COUNT(DISTINCT mh.day) = 7;

![image](https://github.com/user-attachments/assets/4942f875-b8d2-43b1-b800-93b5aee8095e)

9, Which are the top 5 most popular museum? (Popularity is defined based on most no of paintings in a museum)

SELECT m.name, w.museum_id, Count(*) AS Total FROM work w
JOIN museum m ON w.museum_id = m.museum_id 
WHERE w.museum_id IS NOT NULL
GROUP BY w.museum_id, m.name
ORDER BY TOTAL DESC  LIMIT  5;

![image](https://github.com/user-attachments/assets/0f7e7531-26d3-4e58-8875-52a610bbc425)

10, Who are the top 5 most popular artist? (Popularity is defined based on most no of paintings done by an artist)

SELECT w.artist_id, a.full_name, a.nationality, count(*) AS Total FROM work w
JOIN artist a ON w.artist_id = a.artist_id
WHERE w.artist_id IS NOT NULL 
GROUP BY w.artist_id, a.full_name, a.nationality
ORDER BY TOTAL DESC LIMIT 5

![image](https://github.com/user-attachments/assets/5b85afdc-7f78-4f19-8603-19fe66d8960c)

11, Display the 3 least popular canva sizes

SELECT cs.size_id, cs.label, COUNT(*) AS no_of_paintings
FROM work w
JOIN product_size ps ON ps.work_id = w.work_id
JOIN canvas_size cs ON cs.size_id = ps.size_id
GROUP BY cs.size_id, cs.label
ORDER BY no_of_paintings DESC
LIMIT 3;

![image](https://github.com/user-attachments/assets/4e72cb42-47dd-4ce5-b95d-eecdfc3bf4a9)

12, Which museum is open for the longest during a day. Dispay museum name, state and hours open and which day?

SELECT m.name, m. state, mh.museum_id, count(open - close) + 2 AS Hours_Open from museum_hours mh
JOIN museum m ON mh.museum_id = m.museum_id
GROUP BY mh.museum_id,m.name,m. state
HAVING Hours_Open > 8
ORDER BY m.name ASC

![image](https://github.com/user-attachments/assets/61ab724e-151c-4df8-be67-228025940e10)

13, Which museum has the most no of most popular painting style?

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

![image](https://github.com/user-attachments/assets/6c7bdde0-83e3-49b7-ac55-898f1cfc7d34)



























   


