/*
Q: What are the most optimal skills to learn (they in high demand
and a high paying skill).
- Identify skills in high demand and associated with high average
salaries for data analyst roles.
- Concentrate on remote positions with specific salaries.
- Why? Target skills that offer job security (high demand) and 
financial benefits (high salary), offering strategic insights for
career development in the data analyst field.
*/



WITH skills_demand as (
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS skill_count
FROM job_postings_fact

INNER JOIN  skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN  skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE job_title_short = 'Data Analyst'
    AND job_work_from_home = True
    AND salary_year_avg IS NOT NULL

GROUP BY 
    skills_dim.skill_id
), 

average_salary AS (

SELECT 
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
    
FROM job_postings_fact

INNER JOIN  skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN  skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True

GROUP BY 
    skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    skill_count,
    avg_salary

from skills_demand

inner join average_salary
    on skills_demand.skill_id = average_salary.skill_id

WHERE skill_count > 10

ORDER BY 
    skill_count DESC,
    avg_salary DESC

LIMIT 25;

/* Alternate version, more concise */

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS skill_count,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary

FROM job_postings_fact

INNER JOIN  skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id

INNER JOIN  skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE job_title_short = 'Data Analyst'
    AND job_work_from_home = True
    AND salary_year_avg IS NOT NULL

GROUP BY 
    skills_dim.skill_id

HAVING COUNT(skills_job_dim.job_id) > 10

ORDER BY
    skill_count DESC,
    avg_salary DESC

LIMIT 25;