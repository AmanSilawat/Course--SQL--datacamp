-- Joining Data in SQL

-- 1 Introduction to joins
-- 1.1 Introduction to INNER JOIN
-- video


-- 1.2 Inner join
-- Instructions 1
select *
from cities


-- Instructions 2
SELECT * 
FROM cities
  -- 1. Inner join to countries
  INNER JOIN countries
    -- 2. Match on the country codes
    ON cities.country_code = countries.code;


-- Instructions 3
-- 1. Select name fields (with alias) and region 
SELECT cities.name as city, countries.name as country, countries.region
FROM cities
  INNER JOIN countries
    ON cities.country_code = countries.code;


-- 1.3 Inner join (2)
-- 3. Select fields with aliases
SELECT c.code AS country_code, name, year, inflation_rate
FROM countries AS c
  -- 1. Join to economies (alias e)
  INNER JOIN economies AS e
    -- 2. Match on code
    ON c.code = e.code;


-- 1.4 Inner join (3)
-- Instructions 1
Select c.code, c.name, c.region, p.year, p.fertility_rate
  From countries as c
  INNER JOIN populations as p
    ON c.code = p.country_code


-- Instructions 2
SELECT c.code, name, region, e.year, fertility_rate, e.unemployment_rate
  FROM countries AS c
  INNER JOIN populations AS p
    ON c.code = p.country_code
  INNER JOIN economies as e
    ON c.code = e.code


-- Instructions 3
SELECT c.code, name, region, e.year, fertility_rate, unemployment_rate
  -- 1. From countries (alias as c)
  FROM countries AS c
  -- 2. Join to populations (as p)
  INNER JOIN populations AS p
    -- 3. Match on country code
    ON c.code = p.country_code
  -- 4. Join to economies (as e)
  INNER JOIN economies AS e
    -- 5. Match on country code and year
    ON c.code = e.code and e.year = p.year


-- 1.5 INNER JOIN via USING
-- video


-- 1.5 Review inner join using on
-- choose: INNER JOIN requires a specification of the key field (or fields) in each table.


-- 1.6 Inner join with using
Select c.name as country, c.continent, l.name as language, l.official
  -- 1. From countries (alias as c)
  from countries as c
  -- 2. Join to languages (as l)
  inner join languages as l
    -- 3. Match using code
    using (code)


-- 1.7 Self-ish joins, just in CASE
-- video


-- 1.8 Self-join
-- Instructions 1
-- Select fields with aliases
Select p1.country_code,
p1.size as size2010,
p2.size as size2015
-- 1. From populations (alias as p1)
from populations as p1
  -- 2. Join to itself (alias as p2)
  inner join populations as p2
    -- 3. Match on country code
    on p1.country_code = p2.country_code


-- Instructions 2
-- Select fields with aliases
SELECT p1.country_code,
       p1.size AS size2010,
       p2.size AS size2015
-- 1. From populations (alias as p1)
FROM populations as p1
  -- 2. Join to itself (alias as p2)
  inner JOIN populations as p2
    -- 3. Match on country code
    ON p1.country_code = p2.country_code
        -- 4. and year (with calculation)
        AND p1.year = p2.year - 5


-- Instructions 3
SELECT p1.country_code,
       p1.size AS size2010, 
       p2.size AS size2015,
       -- 1. calculate growth_perc
       ((p2.size - p1.size)/p1.size * 100.0) AS growth_perc
-- 2. From populations (alias as p1)
FROM populations AS p1
  -- 3. Join to itself (alias as p2)
  INNER JOIN populations AS p2
    -- 4. Match on country code
    ON p1.country_code = p2.country_code
        -- 5. and year (with calculation)
        AND p1.year = p2.year - 5;


-- 1.9 Case when and then
SELECT name, continent, code, surface_area,
    -- 1. First case
    CASE WHEN surface_area > 2000000 THEN 'large'
        -- 2. Second case
        WHEN surface_area > 350000 THEN 'medium'
        -- 3. Else clause + end
        ELSE 'small' END
        -- 4. Alias name
        AS geosize_group
-- 5. From table
FROM countries;


-- 1.10 Inner challenge
-- Instructions 1
SELECT country_code, size,
    -- 1. First case
    CASE WHEN size > 50000000 THEN 'large'
        -- 2. Second case
        WHEN size > 1000000 THEN 'medium'
        -- 3. Else clause + end
        ELSE 'small' END
        -- 4. Alias name (popsize_group)
        AS popsize_group
-- 5. From table
FROM populations
-- 6. Focus on 2015
WHERE year = 2015;


-- Instructions 2
SELECT country_code, size,
    CASE WHEN size > 50000000 THEN 'large'
        WHEN size > 1000000 THEN 'medium'
        ELSE 'small' END
        AS popsize_group
-- 1. Into table
INTO pop_plus
FROM populations
WHERE year = 2015;
-- 2. Select all columns of pop_plus
SELECT * FROM pop_plus;


-- Instructions 3
SELECT country_code, size,
  CASE WHEN size > 50000000
            THEN 'large'
       WHEN size > 1000000
            THEN 'medium'
       ELSE 'small' END
       AS popsize_group
INTO pop_plus       
FROM populations
WHERE year = 2015;
-- 5. Select fields
SELECT name, continent, geosize_group, popsize_group
-- 1. From countries_plus (alias as c)
from countries_plus as c
  -- 2. Join to pop_plus (alias as p)
  inner join pop_plus as p
    -- 3. Match on country code
    on c.code = p.country_code
-- 4. Order the table    
order by geosize_group;



-- 2 Outer joins and cross joins
-- 2.1 LEFT and RIGHT JOINs
-- video


-- 2.2 Left Join
-- Instructions 1
-- Select the city name (with alias), the country code,
-- the country name (with alias), the region,
-- and the city proper population
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
-- From left table (with alias)
FROM cities AS c1
  -- Join to right table (with alias)
  INNER JOIN countries AS c2
    -- Match on country code
    ON c1.country_code = c2.code
-- Order by descending country code
ORDER BY code desc;


-- Instructions 2
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
FROM cities AS c1
  -- 1. Join right table (with alias)
  left JOIN countries AS c2
    -- 2. Match on country code
    ON c1.country_code = c2.code
-- 3. Order by descending country code
ORDER BY code DESC;


-- 2.3 Left join (2)
-- Instructions 1
/*
5. Select country name AS country, the country's local name,
the language name AS language, and
the percent of the language spoken in the country
*/
select c.name AS country, local_name, l.name AS language, percent
-- 1. From left table (alias as c)
FROM countries AS c
  -- 2. Join to right table (alias as l)
  inner JOIN languages AS l
    -- 3. Match on fields
    ON c.code = l.code
-- 4. Order by descending country
ORDER BY country desc;


-- Instructions 2
/*
5. Select country name AS country, the country's local name,
the language name AS language, and
the percent of the language spoken in the country
*/
select c.name AS country, local_name, l.name AS language, percent
-- 1. From left table (alias as c)
FROM countries AS c
  -- 2. Join to right table (alias as l)
  left JOIN languages AS l
    -- 3. Match on fields
    ON c.code = l.code
-- 4. Order by descending country
ORDER BY country DESC;


-- 2.4 Left join (3)
-- Instructions 1
-- 5. Select name, region, and gdp_percapita
SELECT name, region, gdp_percapita
-- 1. From countries (alias as c)
FROM countries AS c
  -- 2. Left join with economies (alias as e)
  LEFT JOIN economies AS e
    -- 3. Match on code fields
    ON c.code = e.code
-- 4. Focus on 2010
WHERE e.year = 2010;


-- Instructions 2
-- Select fields
SELECT region, avg(gdp_percapita) AS avg_gdp
-- From countries (alias as c)
FROM countries AS c
  -- Left join with economies (alias as e)
  LEFT JOIN economies AS e
    -- Match on code fields
    ON c.code = e.code
-- Focus on 2010
WHERE e.year = 2010
-- Group by region
GROUP BY region;


-- Instructions 3
-- Select fields
SELECT region, AVG(gdp_percapita) AS avg_gdp
-- From countries (alias as c)
from countries as c
  -- Left join with economies (alias as e)
  left join economies as e
    -- Match on code fields
    on c.code = e.code
-- Focus on 2010
where year = 2010
-- Group by region
group by region
-- Order by descending avg_gdp
order by avg_gdp desc;


-- 2.5 Right join
-- convert this code to use RIGHT JOINs instead of LEFT JOINs
/*
SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM cities
  LEFT JOIN countries
    ON cities.country_code = countries.code
  LEFT JOIN languages
    ON countries.code = languages.code
ORDER BY city, language;
*/


SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM languages
  RIGHT JOIN countries
    ON languages.code = countries.code
  RIGHT JOIN cities
    ON countries.code = cities.country_code
ORDER BY city, language;


-- 2.5 FULL JOINs
-- video


-- 2.6 Full join
-- Instructions 1
 SELECT name AS country, code, region, basic_unit
-- 3. From countries
FROM countries
  -- 4. Join to currencies
  FULL JOIN currencies
    -- 5. Match on code
    USING (code)
-- 1. Where region is North America or null
WHERE region = 'North America' OR region IS null
-- 2. Order by region
ORDER BY region;


-- Instructions 2
SELECT name AS country, code, region, basic_unit
-- 1. From countries
FROM countries
  -- 2. Join to currencies
  left JOIN currencies
    -- 3. Match on code
    USING (code)
-- 4. Where region is North America or null
WHERE region = 'North America' OR region IS null
-- 5. Order by region
ORDER BY region;


-- Instructions 3
SELECT name AS country, code, region, basic_unit
FROM countries
  -- 1. Join to currencies
  inner JOIN currencies
    USING (code)
-- 2. Where region is North America or null
WHERE region = 'North America' OR region IS NULL
-- 3. Order by region
ORDER BY region;


-- 2.7 Full join (2)
-- Instructions 1
SELECT countries.name, code, languages.name AS language
-- 3. From languages
FROM languages
  -- 4. Join to countries
  full JOIN countries
    -- 5. Match on code
    USING (code)
-- 1. Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS null
-- 2. Order by ascending countries.name
ORDER BY countries.name;


-- Instructions 2
SELECT countries.name, code, languages.name AS language
FROM languages
  -- 1. Join to countries
  left JOIN countries
    -- 2. Match using code
    USING (code)
-- 3. Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
ORDER BY countries.name;


-- Instructions 3
SELECT countries.name, code, languages.name AS language
FROM languages
  -- 1. Join to countries
  inner JOIN countries
    USING (code)
-- 2. Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
ORDER BY countries.name;


-- 2.8 Full join (3)
-- 7. Select fields (with aliases)
SELECT c1.name AS country, region, l.name AS language,
       basic_unit, frac_unit
-- 1. From countries (alias as c1)
FROM countries AS c1
  -- 2. Join with languages (alias as l)
  FULL JOIN languages AS l
    -- 3. Match on code
    USING (code)
  -- 4. Join with currencies (alias as c2)
  FULL JOIN currencies AS c2
    -- 5. Match on code
    USING (code)
-- 6. Where region like Melanesia and Micronesia
WHERE region LIKE 'M%esia';


-- 2.9 Review outer joins
-- choose: None of the above are true


-- 2.10 CROSSing the rubicon
-- video


-- 2.11 A table of two cities
-- Instructions 1
-- 4. Select fields
SELECT c.name AS city, l.name AS language
-- 1. From cities (alias as c)
FROM cities AS c        
  -- 2. Join to languages (alias as l)
  CROSS JOIN languages AS l
-- 3. Where c.name like Hyderabad
WHERE c.name LIKE 'Hyder%';


-- Instructions 2
-- Select fields
SELECT c.name as city, l.name as language
-- 1. From cities (alias as c)
from cities as c
  -- 2. Join to languages (alias as l)
  inner JOIN languages AS l
    -- 3. Match on country code
    on c.country_code = l.code
-- 4. Where c.name like Hyderabad
WHERE c.name LIKE 'Hyder%';


-- 2.12 Outer challenge
-- Select fields
Select c.name as country, region, p.life_expectancy as life_exp
-- From countries (alias as c)
from countries as c
  -- Join to populations (alias as p)
  left join populations as p
    -- Match on country code
    on c.code = p.country_code
-- Focus on 2010
where p.year = 2010
-- Order by life_exp
order by life_exp
-- Limit to 5 records
limit 5



-- 3 Set theory clauses
-- 3.1 State of the UNION
-- video


-- 3.2 Union
-- Select fields from 2010 table
Select *
  -- From 2010 table
  from economies2010
	-- Set theory clause
	union
-- Select fields from 2015 table
Select *
  -- From 2015 table
  from economies2015
-- Order by code and year
order by code, year;


-- 3.3 Union (2)
-- Select field
select country_code
  -- From cities
  from cities
	-- Set theory clause
	union
-- Select field
select code
  -- From currencies
  from currencies
-- Order by country_code
order by country_code;


-- 3.4 Union all
-- Select fields
SELECT code, year
  -- From economies
  FROM economies
	-- Set theory clause
	UNION ALL
-- Select fields
SELECT country_code, year
  -- From populations
  FROM populations
-- Order by code, year
ORDER BY code, year;


-- 3.5 INTERSECTional data science
-- video


-- 3.5 Intersect
-- Select fields
Select code, year
  -- From economies
  from economies
	-- Set theory clause
	INTERSECT
-- Select fields
Select country_code, year
  -- From populations
  from populations
-- Order by code and year
order by code, year;


-- 3.6 Intersect (2)
-- Select fields
Select name
  -- From countries
  from countries
	-- Set theory clause
	intersect
-- Select fields
Select name
  -- From cities
  from cities;


-- 3.7 Review union and intersect
-- choose: INTERSECT: returns only records appearing in both tables


-- 3.8 EXCEPTional
-- video


-- 3.9 Except
-- Select field
SELECT name
  -- From cities
  FROM cities
	-- Set theory clause
	EXCEPT
-- Select field
SELECT capital
  -- From countries
  FROM countries
-- Order by result
ORDER BY name;


-- 3.10 Except (2)
-- Select field
Select capital
  -- From countries
  from countries
	-- Set theory clause
  except
-- Select field
  Select name
  -- From cities
  from cities
-- Order by ascending capital
Order by capital;


-- 3.11 Semi-joins and Anti-joins
-- video


-- 3.12 Semi-join
-- Instructions 1
-- Select code
Select code
  -- From countries
  from countries
-- Where region is Middle East
where region = 'Middle East';


-- Instructions 2
/*
SELECT code
  FROM countries
WHERE region = 'Middle East';
*/

-- Select field
  Select distinct name
  -- From languages
  from languages
-- Order by name
Order by name;


-- Instructions 3
-- Select distinct fields
Select distinct name
  -- From languages
  from languages
-- Where in statement
WHERE code IN
  -- Subquery
  (Select code
   from countries
   where region = 'Middle East')
-- Order by name
Order by name;


-- 3.13 Relating semi-join to a tweaked inner join
-- choose: DISTINCT


-- 3.14 Diagnosing problems using anti-join
-- Instructions 1
-- Select statement
Select count(*)
  -- From countries
  From countries
-- Where continent is Oceania
Where continent = 'Oceania';


-- Instructions 2
-- 5. Select fields (with aliases)
Select c1.code, c1.name, c2.basic_unit as currency
  -- 1. From countries (alias as c1)
  from countries as c1
  	-- 2. Join with currencies (alias as c2)
  	inner join currencies as c2
    -- 3. Match on code
    using (code)
-- 4. Where continent is Oceania
where continent = 'Oceania';


-- Instructions 3
-- 3. Select fields
Select code, name
  -- 4. From Countries
  From Countries
  -- 5. Where continent is Oceania
  Where continent = 'Oceania'
  	-- 1. And code not in
  	And code not in 
  	-- 2. Subquery
  	(Select code
	  from currencies);


-- 3.15 Set theory challenge
-- Select the city name
Select c1.name
  -- Alias the table where city name resides
  from cities AS c1
  -- Choose only records matching the result of multiple set theory clauses
  WHERE c1.country_code IN
(
    -- Select appropriate field from economies AS e
    SELECT e.code
    FROM economies AS e
    -- Get all additional (unique) values of the field from currencies AS c2  
    union
    SELECT c2.code
    FROM currencies AS c2
    -- Exclude those appearing in populations AS p
    except
    SELECT p.country_code
    FROM populations AS p
);



-- 4 Subqueries
-- 4.1 Subqueries inside WHERE and SELECT clauses
-- video


-- 4.2 Subquery inside where
-- Instructions 1
-- Select average life_expectancy
Select avg(p.life_expectancy)
  -- From populations
  from populations as p
-- Where year is 2015
where year = 2015


-- Instructions 2
-- Select fields
Select *
  -- From populations
  from populations
-- Where life_expectancy is greater than
where life_expectancy > 1.15 * (
  Select avg(life_expectancy)
  from populations
  where year = 2015
)
-- 1.15 * subquery
  and year = 2015;


-- 4.3 Subquery inside where (2)
-- 2. Select fields
Select name, country_code, urbanarea_pop
  -- 3. From cities
  from cities
-- 4. Where city name in the field of capital cities
where name IN
  -- 1. Subquery
  (Select capital
   from countries)
ORDER BY urbanarea_pop DESC;


-- 4.4 Subquery inside select
-- Instructions 1
/*
SELECT countries.name AS country, COUNT(*) AS cities_num
  FROM cities
    INNER JOIN countries
    ON countries.code = cities.country_code
GROUP BY country
ORDER BY cities_num DESC, country
LIMIT 9;
*/

SELECT countries.name AS country,
  (SELECT COUNT(*)
   FROM cities
   WHERE countries.code = cities.country_code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;


-- Instructions 2
/*
SELECT countries.name AS country, COUNT(*) AS cities_num
  FROM cities
    INNER JOIN countries
    ON countries.code = cities.country_code
GROUP BY country
ORDER BY cities_num DESC, country
LIMIT 9;
*/
 
SELECT countries.name AS country,
  (SELECT count(*)
   FROM cities
   WHERE countries.code = cities.country_code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;


-- 4.5 Subquery inside FROM clause
-- video


-- 4.5 Subquery inside from
-- Instructions 1
-- Select fields (with aliases)
Select code,  count(*) as lang_num
  -- From languages
  from languages
-- Group by code
Group by code;


-- Instructions 2
-- Select fields
Select local_name, subquery.lang_num
  -- From countries
  from countries,
  	-- Subquery (alias as subquery)
  	(
      Select code, count(name) as lang_num
      from languages
      Group by code
    ) AS subquery
  -- Where codes match
  where countries.code = subquery.code
-- Order by descending number of languages
order by subquery.lang_num desc;


-- 4.6 Advanced subquery
-- Instructions 1
-- Select fields
select countries.name, countries.continent, economies.inflation_rate
  -- From countries
  from countries
  	-- Join to economies
  	inner join economies
    -- Match on code
    using (code)
-- Where year is 2015
where year = 2015;


-- Instructions 2
-- Select the maximum inflation rate as max_inf
select Max(inflation_rate) as max_inf
  -- Subquery using FROM (alias as subquery)
  FROM (
    select name, continent, inflation_rate
    from countries
    inner join economies
    using (code)
    where year = 2015
  ) AS subquery
-- Group by continent
group by continent;


-- Instructions 3
-- Select fields
SELECT name, continent, inflation_rate
  -- From countries
  FROM countries
	-- Join to economies
	INNER JOIN economies
	-- Match on code
	using (code)
  -- Where year is 2015
  WHERE year = 2015
    -- And inflation rate in subquery (alias as subquery)
    AND inflation_rate in (
        SELECT MAX(inflation_rate) AS max_inf
        FROM (
             SELECT name, continent, inflation_rate
             FROM countries
             INNER JOIN economies
             on countries.code = economies.code
             WHERE year = 2015) AS subquery
      -- Group by continent
        GROUP BY continent);


-- 4.7 Subquery challenge
-- Select fields
SELECT code, inflation_rate, unemployment_rate
  -- From economies
  FROM economies
  -- Where year is 2015 and code is not in
  WHERE year = 2015 AND code not in
  	-- Subquery
  	(SELECT code
  	 FROM countries
  	 WHERE (gov_form = 'Constitutional Monarchy' OR gov_form LIKE '%Republic%'))
-- Order by inflation rate
ORDER BY inflation_rate;


-- 4.8 Subquery review
-- choose: WHERE


-- 4.9 Course review
-- video


-- 4.10 Final challenge
-- Select fields
SELECT DISTINCT name, total_investment, imports
  -- From table (with alias)
  FROM economies AS e
    -- Join with table (with alias)
    LEFT JOIN countries AS c
      -- Match on code
      ON (e.code = c.code
      -- and code in Subquery
        AND e.code IN (
          SELECT l.code
          FROM languages AS l
          WHERE official = 'true'
        ) )
  -- Where region and year are correct
  WHERE region = 'Central America'  AND year = 2015
-- Order by field
ORDER BY name;


-- 4.11 Final challenge (2)
-- Select fields
SELECT region, continent, avg(fertility_rate) AS avg_fert_rate
  -- From left table
  FROM countries AS c
    -- Join to right table
    INNER JOIN populations AS p
      -- Match on join condition
      ON c.code = p.country_code
  -- Where specific records matching some condition
  WHERE year = 2015
-- Group appropriately
GROUP BY region, continent
-- Order appropriately
ORDER BY avg_fert_rate;


-- 4.12 Final challenge (3)
-- Select fields
SELECT name, country_code, city_proper_pop, metroarea_pop,  
      -- Calculate city_perc
      city_proper_pop / metroarea_pop * 100 AS city_perc
  -- From appropriate table
  FROM cities
  -- Where 
  WHERE name IN
    -- Subquery
    (SELECT capital
     FROM countries
     WHERE (continent = 'Europe'
        OR continent LIKE '%America'))
       AND metroarea_pop IS not null
-- Order appropriately
ORDER BY city_perc desc
-- Limit amount
limit 10;