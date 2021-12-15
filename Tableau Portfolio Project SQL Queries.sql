/*

Queries used for Tableau Project of COVID Data Analysis

*/


-- 1. 

-- In this first query we will calculate the total COVID cases, total COVID Deats and the death percentage


SELECT Sum(new_cases)                                      AS [Total Cases],
       Sum(Cast(new_deaths AS INT))                        AS [Total Deaths],
       Sum(Cast(new_deaths AS INT)) / Sum(new_cases) * 100 AS [Death Percentage]
FROM   [COVID Project].[dbo].[coviddeaths]
WHERE  continent IS NOT NULL
ORDER  BY 1,
          2 

-- 2. 

-- In this query, we will get the total death count for each continent.
--For this reason we will exclude every location that is not a continent.


SELECT location                     AS Continent,
       Sum(Cast(new_deaths AS INT)) AS [Total Death Count]
FROM   [COVID Project].[dbo].[coviddeaths]
WHERE  continent IS NULL
       AND location NOT IN ( 'World', 'European Union', 'International',
                             'Upper middle income',
                             'High income', 'Lower middle income', 'Low income'
                           )
GROUP  BY location
ORDER  BY [total death count] DESC 


-- 3.

--In this query, we will calculate the highest infection count and the percentage of population infected per country.


SELECT location                                AS Country,
       population,
       Max(total_cases)                        AS [Highest Infection Count],
       MAX(ROUND((( total_cases / population ) * 100),2)) AS [Percent Population Infected]
FROM   [COVID Project].[dbo].[coviddeaths]
GROUP  BY location,
          population
ORDER  BY [percent population infected] DESC 


-- 4.

-- In this query we will see the gradual development of COVID situation (infection rate and percentage of people infected) per country


SELECT location                                              AS Country,
       population,
       date,
       Max(total_cases)                                      AS [Highest Infection Count],
       Max(Round(( ( total_cases / population ) * 100 ), 2)) AS [Percent Population Infected]
FROM   [COVID Project].[dbo].[coviddeaths]
GROUP  BY location,
          population,
          date
ORDER  BY [percent population infected] DESC 
