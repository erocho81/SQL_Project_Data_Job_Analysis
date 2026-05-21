/* What are the top-paying data analyst jobs?
-Top 10 highest-paying Data Analyst roles available remotely.
- Job postings with salaries (remove nulls).
- Why? Highlight top-paying opportunities for data analysts, offering insights
*/

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name
    
    
FROM job_postings_fact

left JOIN company_dim
ON job_postings_fact.company_id = company_dim.company_id

WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL

ORDER BY salary_year_avg DESC

limit 10
