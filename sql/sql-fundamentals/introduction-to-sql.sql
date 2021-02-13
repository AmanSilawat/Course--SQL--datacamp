-- Introduction to SQL

-- 1 Selecting columns
-- 1.1 Welcome to the course!
    -- video


-- 1.2 Onboarding | Tables
-- choose: 50 Cent


-- 1.3 Onboarding | Query Result
-- choose: A. Michael Baldwin


-- 1.4 Onboarding | Errors
-- Instructions 1
select 'DataCamp <3 SQL'
AS result;


-- 1.5 Onboarding | Bullet Exercises
-- Instructions 1
SELECT 'SQL'
AS result;

-- Instructions 2
SELECT 'SQL is'
AS result;

-- Instructions 3
SELECT 'SQL is cool'
AS result;


-- 1.5 Beginning your SQL journey
-- choose: 4


-- 1.6 SELECTing single columns
-- Instructions 1
select title from films

-- Instructions 2
select release_year from films

-- Instructions 3
select name from people


-- 1.7 SELECTing multiple columns
-- Instructions 1
select title from films

-- Instructions 2
SELECT title, release_year
FROM films;

-- Instructions 3
SELECT title, release_year, country
FROM films;

-- Instructions 4
SELECT *
FROM films;


-- 1.8 SELECT DISTINCT
-- Instructions 1
select DISTINCT country FROM films

-- Instructions 2
select DISTINCT certification from films

-- Instructions 3
select DISTINCT role from roles


-- 1.9 Learning to COUNT
-- choose: 4,968


-- 1.10 Practice with COUNT
-- Instructions 1
select count(*) from people

-- Instructions 2
SELECT count(*)
FROM people where birthdate IS NOT null;

-- Instructions 3
SELECT COUNT(DISTINCT birthdate)
FROM people WHERE birthdate IS NOT NULL;

-- Instructions 4
SELECT count(DISTINCT language)
FROM films WHERE language IS NOT NULL

-- Instructions 5
select count(distinct country)
from films where country IS NOT NULL



-- 2 Filtering rows
-- 2.1 Filtering results
-- choose: Films released after the year 2000 press


-- 2.2 Simple filtering of numeric values
-- Instructions 1
select *
from films
where release_year = 2016

-- Instructions 2
select count(*)
from films
where release_year < 2000

-- Instructions 3
select title, release_year
from films
where release_year > 2000


-- 2.3 Simple filtering of text
-- Instructions 1
select *
from films
where language='French'

-- Instructions 2
select name, birthdate
from people
where birthdate = '1974-11-11'

-- Instructions 3
select count(*)
from films
where language='Hindi'

-- Instructions 4
select *
from films
where certification='R'


-- 2.4 WHERE AND
-- Instructions 1
select title, release_year
from films
where language='Spanish' AND release_year < 2000

-- Instructions 2
select *
from films
where language='Spanish' and release_year > 2000

-- Instructions 3
select *
from films
where language='Spanish' AND release_year > 2000 and release_year < 2010


-- 2.5 WHERE AND OR
-- choose: Display only rows that meet at least one of the specified conditions.


-- 2.6 WHERE AND OR (2)
-- Instructions 1
select title, release_year
from films
where release_year >= 1990 AND release_year <= 1999

-- Instructions 2
SELECT title, release_year
FROM films
WHERE (release_year >= 1990 AND release_year < 2000)
AND
(language ='Spanish' OR language='French')

-- Instructions 3
SELECT title, release_year
FROM films
WHERE (release_year >= 1990 AND release_year < 2000)
AND (language = 'French' OR language = 'Spanish')
AND gross > 2000000


-- 2.7 BETWEEN
-- choose: Filter values in a specified range


-- 2.8 BETWEEN(2)
-- Instructions 1
select title, release_year
from films
where release_year BETWEEN 1990 AND 2000

-- Instructions 2
SELECT title, release_year
FROM films
WHERE release_year BETWEEN 1990 AND 2000
AND budget > 100000000

-- Instructions 3
SELECT title, release_year
FROM films
WHERE release_year BETWEEN 1990 AND 2000
AND budget > 100000000
AND language = 'Spanish'

-- Instructions 4
SELECT title, release_year
FROM films
WHERE release_year BETWEEN 1990 AND 2000
AND budget > 100000000
AND (language = 'Spanish' OR language = 'French');


-- 2.9 WHERE IN
-- Instructions 1
select title, release_year
from films
where release_year IN (1990, 2000)
And duration > 120

-- Instructions 2
select title, language
from films
where language in('English', 'Spanish', 'French')

-- Instructions 3
select title, certification
from films
where certification IN ('R', 'NC-17')


-- 2.10 Introduction to NULL and IS NULL
-- choose: A missing value


-- 2.11 NULL and IS NULL
-- Instructions 1
select name
from people
where deathdate is null 

-- Instructions 2
select title
from films
where budget is null

-- Instructions 3
select count(*)
from films
where language is null


-- 2.12 LIKE and NOT LIKE
-- Instructions 1
select name
from people
where name like 'B%'

-- Instructions 2
select name
from people
where name like '_r%'

-- Instructions 3
select name
from people
where name not like 'A%'



-- 3 Aggregate Functions
-- 3.1 Aggregate functions
-- Instructions 1
select sum(duration)
from films

-- Instructions 2
select avg(duration)
from films

-- Instructions 3
select min(duration)
from films

-- Instructions 4
select max(duration)
from films


-- 3.2 Aggregate functions practice
-- Instructions 1
select sum(gross)
from films

-- Instructions 2
select avg(gross)
from films

-- Instructions 3
select min(gross)
from films;

-- Instructions 4
select max(gross)
from films


-- 3.3 Combining aggregate functions with WHERE
-- Instructions 1
select sum(gross)
from films
where release_year >= 2000;

-- Instructions 2
select avg(gross)
from films
where title like 'A%'

-- Instructions 3
select min(gross)
from films
where release_year = 1994

-- Instructions 4
select max(gross)
from films
where release_year between 2000 and 2012


-- 3.4 A note on arithmetic
-- choose: 3


-- 3.5 A It's AS simple AS aliasing
-- Instructions 1
select title, (gross - budget) as net_profit
from films

-- Instructions 2
select title, (duration / 60.0) as duration_hours
from films

-- Instructions 3
select (avg(duration) / 60.0) as avg_duration_hours
from films


-- 3.6 Even more aliasing
-- Instructions 1
select ((count(deathdate) * 100.0) / count(*))  as percentage_dead
from  people

-- Instructions 2
select (Max(release_year) - min(release_year)) as difference
from films

-- Instructions 3
select ((max(release_year) - min(release_year)) / 10.0) as number_of_decades
from films



-- 4 Sorting and grouping 
-- 4.1 ORDER BY
-- choose: Alphabetically (A-Z)


-- 4.2 Sorting single columns
-- Instructions 1
select name
from people
order by name

-- Instructions 2
select name
from people
order by birthdate

-- Instructions 3
select birthdate, name
from people
order by birthdate


-- 4.3 Sorting single columns (2)
-- Instructions 1
select title
from films
where release_year = 2000 or release_year = 2012
order by release_year

-- Instructions 2
select *
from films
where release_year <> 2015
order by duration

-- Instructions 3
select title, gross
from films
where title like 'M%'
order by title


-- 4.4 Sorting single columns (DESC)
-- Instructions 1
select imdb_score, film_id
from reviews
order by imdb_score desc

-- Instructions 2
select title
from films
order by title desc

-- Instructions 3
select title, duration
from films
order by duration desc


-- 4.5 Sorting multiple columns
-- Instructions 1
select birthdate, name
from people
order by birthdate, name

-- Instructions 2
select release_year, duration, title
from films
order by release_year, duration

-- Instructions 3
select certification, release_year, title
from films
order by certification, release_year

-- Instructions 4
select name, birthdate
from people
order by name, birthdate


-- 4.6 GROUP BY
-- choose: Performing operations by group


-- 4.7 GROUP BY practice
-- Instructions 1
select release_year, count(*)
from films
group by release_year

-- Instructions 2
select release_year, avg(duration)
from films
group by release_year

-- Instructions 3
select release_year, max(budget)
from films
group by release_year

-- Instructions 4
select imdb_score, count(*)
from reviews
group by imdb_score


-- 4.8 GROUP BY practice (2)
-- Instructions 1
select release_year, min(gross)
from films
group by release_year

-- Instructions 2
select language, sum(gross)
from films
group by language

-- Instructions 3
select country, sum(budget)
from films
group by country

-- Instructions 4
select release_year, country, max(budget)
from films
group by release_year, country
order by release_year, country

-- Instructions 5
select country, release_year, min(gross)
from films
group by release_year, country
order by country, release_year


-- 4.9 HAVING a great time
-- choose: 13


-- 4.10 All together now
-- Instructions 1
select release_year, budget, gross
from films

-- Instructions 2
SELECT release_year, budget, gross
FROM films
where release_year > 1990;

-- Instructions 3
SELECT release_year
FROM films
group by release_year
having release_year > 1990;

-- Instructions 4
SELECT release_year, avg(budget) as avg_budget, avg(gross) as avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year;

-- Instructions 5
SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
GROUP BY release_year
having release_year > 1990 and AVG(budget) > 60000000;

-- Instructions 6
SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000
order by avg_gross desc;


-- 4.11 All together now (2)
select country, avg(budget) as avg_budget, avg(gross) as avg_gross
from films
group by country
having count(country) > 10
order by country
limit 5


-- 4.12 A taste of things to come
-- Instructions 1
SELECT f.title, r.imdb_score
FROM films as f
JOIN reviews as r
ON f.id = r.film_id
WHERE title = 'To Kill a Mockingbird';

-- Instructions 2
-- choose: A taste of things to come