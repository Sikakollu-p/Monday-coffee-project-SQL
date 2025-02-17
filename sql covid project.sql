--a.datewise likelihood of dying due to covid - totalcases vs totaldeaths - in India
select date, total_cases, total_deaths 
FROM "CovidDeaths"
WHERE location like '%India%';

--b.total % of deaths out of entire population in india
SELECT (MAX(total_deaths) / AVG(CAST(population AS integer)) * 100) AS percentage
FROM "CovidDeaths"
WHERE location LIKE '%India%';

--c.verify b by getting info separately
SELECT total_deaths, population FROM "CovidDeaths"
WHERE location like '%India%';

--d.country with highest death as a % of population
select location, (max(total_deaths)/avg(cast(population as bigint))*100) as percentage
from "CovidDeaths"
group by location 
order by percentage DESC;

--e.total % of covid +ve cases in india
select (max(total_cases)/avg(cast(population as bigint))*100) as percentagepositive 
from "CovidDeaths"
where location like '%India%';

--f.total % of covid +ve cases in the world
select location, (max(total_cases)/avg(cast(population as bigint))*100) as percentagepositive 
from "CovidDeaths"
group by location
order by percentagepositive DESC;

--g.continentwise +ve cases
select location, max(total_cases) as total_case
from "CovidDeaths"
where continent is null
group by location
order by total_case DESC;

--h.continentwise deaths
select location, max(total_deaths) as total_death
from "CovidDeaths"
where continent is null
group by location
order by total_death DESC;

--i.daily newcases vs hospitalizations vs icu patients in india 
select date, new_cases, hosp_patients, icu_patients
from "CovidDeaths"
where location like '%India%';

--j.countrywise age 65>
-- Query 1: Select location and aged_65_older
SELECT "CovidDeaths".location, "CovidVaccinations".aged_65_older
FROM "CovidDeaths"
JOIN "CovidVaccinations"
ON "CovidDeaths".iso_code = "CovidVaccinations".iso_code
   AND "CovidDeaths".date = "CovidVaccinations".date;

-- Query 2: Aggregates and grouping
SELECT 
    AVG(CAST("CovidDeaths".population AS BIGINT)) AS avg_population,
    MAX("CovidVaccinations".people_fully_vaccinated) AS max_fully_vaccinated,
    MAX("CovidVaccinations".total_boosters) AS total_boosters,
    "CovidVaccinations".location
FROM "CovidDeaths"
INNER JOIN "CovidVaccinations"
ON "CovidDeaths".iso_code = "CovidVaccinations".iso_code
   AND "CovidDeaths".date = "CovidVaccinations".date
GROUP BY "CovidVaccinations".location;

--k. Countrywise total vaccinated persons
select "CovidDeaths".location as country,max("CovidVaccinations".people_fully_vaccinated) as Fully_vaccinated 
from "CovidDeaths" 
join "CovidVaccinations" 
on "CovidDeaths".iso_code="CovidVaccinations".iso_code and "CovidDeaths".date="CovidVaccinations".date 
where "CovidDeaths".continent is not null 
group by country 
order by Fully_vaccinated desc;








