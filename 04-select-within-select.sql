-- 1.
-- List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world WHERE population > (SELECT population FROM world WHERE name = 'Russia')

-- 2.
-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

-- Per Capita GDP
-- The per capita GDP is the gdp/population

/*
1. get capita gdp of UK
2. get countries WHERE continet = europe and gdp/population > step 1
*/

SELECT name FROM world WHERE continent = 'Europe' AND GDP/population > (SELECT GDP/population FROM world WHERE name = 'United Kingdom')

-- 3.

-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

/*
1. get continents whbre country is Arg or Aus
2. get countries where continents are in 1
*/

SELECT name, continent FROM world WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'))
-- 4.
-- Which country has a population that is more than United Kingom but less than Germany? Show the name and the population.

SELECT name, population FROM world WHERE population BETWEEN (SELECT population FROM world WHERE name = 'United Kingdom') AND (SELECT population FROM world WHERE name = 'Germany') AND name NOT IN ('United Kingdom', 'Germany')

-- 5.
-- Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

-- The format should be Name, Percentage for example:

-- name	percentage
-- Albania	3%
-- Andorra	0%
-- Austria	11%
-- ...	...
-- Decimal places
-- You can use the function ROUND to remove the decimal places.
-- Percent symbol %
-- You can use the function CONCAT to add the percentage symbol.

/*
get population of germany
get countries, population in europe
divide population of country by population of germany
round and concat
*/

SELECT name, CONCAT(CAST(ROUND(population/(SELECT population FROM world WHERE name = 'Germany') * 100, 0) AS int), '%') as percentage FROM world WHERE continent = 'Europe'


-- 6.
-- Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)


SELECT name FROM world WHERE gdp > (SELECT max(gdp) FROM world WHERE name IN (SELECT name FROM world WHERE continent = 'Europe'))

-- 7.
-- Find the largest country (by area) in each continent, show the continent, the name and the area:

/*
1. select distinct continent from world
2. max(area) from world where continent IN step 1

*/
select name, continent, area where area >= contarea (SELECT distinct continent, max(area) as contarea  FROM world group by continent)
-- 8.
-- List each continent and the name of the country that comes first alphabetically.

-- 9.
-- Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.

-- 10.
-- Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.

/*
select the continents
select the same countries in a continent
select the population for those countries

*/

SELECT population, continent FROM world WHERE name IN (SELECT name FROM world WHERE continent IN (SELECT continent FROM world))
