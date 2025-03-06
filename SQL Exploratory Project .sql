-- Exploratory Data Analysis 

Select *
From layoffs_staging;

Select MAX(total_laid_off), MAX(percentage_laid_off)
From layoffs_staging;


Select * 
From layoffs_staging
Where percentage_laid_off = 1 
ORDER BY funds_raised_millions DESC; 


Select company, SUM(total_laid_off)
From layoffs_staging
GROUP By company
ORDER BY 2 DESC;

Select Min(`date`), Max(`date`)
From layoffs_staging;

Select *
From layoffs_staging;

Select YEAR(`date`), SUM(total_laid_off)
From layoffs_staging
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;


Select company, AVG(percentage_laid_off)
From layoffs_staging
GROUP By company
ORDER BY 2 DESC;

Select SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
From layoffs_staging
Where SUBSTRING(`date`,1,7) IS NOT NULL
Group by `MONTH`
ORDER BY 1 ASC
;

WITH ROLLING_TOTAL AS
(
Select SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS TOTAL_OFF
From layoffs_staging
Where SUBSTRING(`date`,1,7) IS NOT NULL
Group by `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, TOTAL_OFF
,SUM(TOTAL_OFF) OVER(ORDER BY `MONTH`) AS ROLLING_TOTAL
FROM ROLLING_TOTAL;

Select company, SUM(total_laid_off)
From layoffs_staging
GROUP By company
ORDER BY 2 DESC;

Select company, YEAR(`date`), SUM(total_laid_off)
From layoffs_staging
GROUP By company, (`date`)
ORDER BY 3 DESC;

WITH Company_Year (company,years, total_laid_off) AS
(
Select company, YEAR(`date`), SUM(total_laid_off)
From layoffs_staging
GROUP By company, (`date`)
), COMPANY_YEAR_RANK AS 
(SELECT *, 
DENSE_RANK () OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS RANKING
From Company _Year
WHERE years IS NOT NULL
)
SELECT * 
FROM Company_year_rank
Where ranking <= 5 
;






