# Introduction
Focusing on data analyst roles, this project explores top paying jobs, in demand skills, and where high demand meets high salary in data analytics in 2023.

Check Sql queries: [Project_Sql folder](/Project_Sql/)

# Background

### The questions that this project wants to answer are: 
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal kills to learn?

# Tools Used
For this research the following tools have been used:

- **SQL:** to query the database and get insights.
- **PostgreSQL:** database management system.
- **Visual Studio Code:** for database management and executing SQL queries.
- **Git & Github:** for version control and sharing SQL scripts and analysis. 

# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market.
Here's how I approached each question: 

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the top paying opportunities in the field. 


```sql
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
```

Here is the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range**: Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers**: Companies like SmartAsset, Meta and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety**: There's a high diversity in Job Titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

| job_id | job_title | job_location | job_schedule_type | salary_year_avg | job_posted_date | company_name |
|---|---|---|---|---|---|---|
| 226942 | Data Analyst | Anywhere | Full-time | 650000.0 | 2023-02-20 15:13:33 | Mantys |
| 547382 | Director of Analytics | Anywhere | Full-time | 336500.0 | 2023-08-23 12:04:42 | Meta |
| 552322 | Associate Director- Data Insights | Anywhere | Full-time | 255829.5 | 2023-06-18 16:03:12 | AT&T |
| 99305 | Data Analyst, Marketing | Anywhere | Full-time | 232423.0 | 2023-12-05 20:00:40 | Pinterest Job Advertisements |
| 1021647 | Data Analyst (Hybrid/Remote) | Anywhere | Full-time | 217000.0 | 2023-01-17 00:17:23 | Uclahealthcareers |
| 168310 | Principal Data Analyst (Remote) | Anywhere | Full-time | 205000.0 | 2023-08-09 11:00:01 | SmartAsset |
| 731368 | Director, Data Analyst - HYBRID | Anywhere | Full-time | 189309.0 | 2023-12-07 15:00:13 | Inclusively |
| 310660 | Principal Data Analyst, AV Performance Analysis | Anywhere | Full-time | 189000.0 | 2023-01-05 00:00:25 | Motional |
| 1749593 | Principal Data Analyst | Anywhere | Full-time | 186000.0 | 2023-07-11 16:00:05 | SmartAsset |
| 387860 | ERM Data Analyst | Anywhere | Full-time | 184000.0 | 2023-06-09 08:01:04 | Get It Recruit - Information Technology |


### 2. Skills for top Paying Jobs
To underdstand what skills are required for the top paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name as company_name
        
    FROM job_postings_fact

    LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id

    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL

    ORDER BY salary_year_avg DESC

    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills

FROM top_paying_jobs

INNER JOIN  skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN  skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id

order by 
    salary_year_avg DESC
```

This is the breakdown for the most demanded skills for the top :
- Sql is the most in-demand skill. SQL appears in every single high-paying role listed, making it the core technical skill for data analysts.
- Python is the Second Most Valuable Skill. Python appears in most top-paying jobs, especially senior and director-level roles.
This suggests that combining SQL + Python significantly increases salary potential.
- Business Intelligence Tools are Highly Valued: Python appears in most top-paying jobs, especially senior and director-level roles.
This suggests that combining SQL + Python significantly increases salary potential.
- Cloud & Big Data Skills Increase Salary Potential. Higher-paying leadership roles included cloud and data engineering technologies (AWS, Azure, Databricks, Snowflake,Pyspark)
-Senior Roles Require Broader Tech Stacks: Director and Principal Analyst positions requested Collaboration tools (Jira, Confluence), DevOps/version control (Git, Bitbucket, GitLab, Jenkins), Cloud platforms. This suggests senior analysts are expected to work cross-functionally with engineering teams.

| Skill | Frequency |
|---|---|
| SQL | 7 |
| Python | 6 |
| Tableau | 5 |
| R | 4 |
| Snowflake | 3 |
| Excel | 3 |
| AWS | 2 |
| Azure | 2 |
| Power BI | 2 |
| Pandas | 2 |
| NumPy | 2 |
| Jira | 2 |
| Confluence | 2 |
| Bitbucket | 2 |
| Atlassian | 2 |
| Go | 2 |
| Oracle | 2 |


### 3. Top Paying Data Analyst Jobs

This query helped identify the skills most frequently requested in Data Analysts job postings, directing focus to areas with high demand.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS skill_count
FROM job_postings_fact

INNER JOIN  skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN  skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE job_title_short = 'Data Analyst'
AND job_work_from_home = True

GROUP BY 
    skills

ORDER BY
    skill_count DESC

limit 5
```
The insights are:
- SQL is the Most In-Demand Skill for Remote Data Analysts: SQL appeared in 7,291 job postings, making it the most requested skill by a large margin.
This confirms SQL as the foundational skill for data analyst roles.
- Excel Remains Extremely Important: Despite modern analytics tools, Excel ranked second with 4,611 postings.
This highlights that spreadsheet analysis and business reporting are still core responsibilities in many analyst positions.
- Python is a Critical Technical Skill: Python appeared in 4,330 postings, showing strong demand for automation, data cleaning, and advanced analytics capabilities.
- Visualization Skills are Highly Valued: Tableau and Power BI ranked in the top five. This indicates companies heavily prioritize dashboarding and data storytelling skills.

| skills | skill_count |
|---|---|
| sql | 7291 |
| excel | 4611 |
| python | 4330 |
| tableau | 3745 |
| power bi | 2609 |


### 4. Top Paying Data Analyst Jobs
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT 
    skills,
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
    skills

ORDER BY
    avg_salary DESC
    
limit 25
```

The Insights are:
- Big Data & Machine Learning Skills Command the Highest Salaries: Big data processing, Machine learning, Cloud engineering, Data infrastructure. PySpark ranked #1 with an average salary of $208,172, significantly higher than traditional analyst tools.
- Data Engineering Skills Increase Analyst Salaries: Databricks, Airflow, Kubernetes, Linux, PostgreSQL appear among the top-paying skills, suggesting analysts with engineering capabilities are highly valued.
- Machine Learning Libraries Are Extremely Valuable: Scikit-learn, Pandas, NumPy, DataRobot, Watson. This indicates that analysts who can move beyond reporting into predictive analytics and machine learning can access much higher salaries.
- Cloud & Platform Knowledge Leads to Better Compensation: associated with salaries above $120K+, highlighting the growing importance of cloud-based analytics environments.
- DevOps & Collaboration Tools are Surprisingly Valuable: this suggests companies increasingly expect senior analysts to collaborate closely with software and data engineering teams.
- Traditional BI Skills Are Less Represented Among Top Salaries: Unlike previous analyses where SQL, Excel, and Tableau dominated demand, this salary-focused query shows that specialized technical skills tend to correlate with higher compensation.

| skills | avg_salary |
|---|---|
| pyspark | 208172 |
| bitbucket | 189155 |
| couchbase | 160515 |
| watson | 160515 |
| datarobot | 155486 |
| gitlab | 154500 |
| swift | 153750 |
| jupyter | 152777 |
| pandas | 151821 |
| elasticsearch | 145000 |
| golang | 145000 |
| numpy | 143513 |
| databricks | 141907 |
| linux | 136508 |
| kubernetes | 132500 |
| atlassian | 131162 |
| twilio | 127000 |
| airflow | 126103 |
| scikit-learn | 125781 |
| jenkins | 125436 |
| notion | 125000 |
| scala | 124903 |
| postgresql | 123879 |
| gcp | 122500 |
| microstrategy | 121619 |


### 5. Top Paying Data Analyst Jobs
Combining insights from the demand and salary data, this query aimed to highlight skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
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
```

The keys insights are: 
- SQL Has the Best Combination of Demand and Salary. Highest demand (398 job postings) & Strong average salary ($97,237). This confirms SQL as the most essential skill for remote data analyst roles.
- Python Offers Higher Salaries Than Other Core Analyst Tools. Although Python appeared in fewer postings than SQL or Excel, it had one of the highest salaries among commonly requested skills. This suggests Python skills provide a strong salary advantage.
- Visualization Tools Are Highly Requested.Business intelligence tools continue to dominate analyst requirements.
- Cloud & Data Engineering Skills Lead to Higher Salaries.
- Traditional Office Tools Have High Demand but Lower Salaries (Excel, Word, PowerPoint,...). They appear frequently but generally correlate with lower salaries compared to programming and cloud technologies.
- The Best Skill Combination for Data Analysts: The results suggest the most valuable analyst profile combines SQL for querying, Python or R for analytics, Tableau / Power BI for visualization, Cloud & warehouse tools like Snowflake or AWS.

| skill_id | skills | skill_count | avg_salary |
|---|---|---|---|
| 0 | sql | 398 | 97237 |
| 181 | excel | 256 | 87288 |
| 1 | python | 236 | 101397 |
| 182 | tableau | 230 | 99288 |
| 5 | r | 148 | 100499 |
| 183 | power bi | 110 | 97431 |
| 7 | sas | 63 | 98902 |
| 186 | sas | 63 | 98902 |
| 196 | powerpoint | 58 | 88701 |
| 185 | looker | 49 | 103795 |
| 188 | word | 48 | 82576 |
| 80 | snowflake | 37 | 112948 |
| 79 | oracle | 37 | 104534 |
| 61 | sql server | 35 | 97786 |
| 74 | azure | 34 | 111225 |
| 76 | aws | 32 | 108317 |
| 192 | sheets | 32 | 86088 |
| 215 | flow | 28 | 97200 |
| 8 | go | 27 | 115320 |
| 199 | spss | 24 | 92170 |
| 22 | vba | 24 | 88783 |
| 97 | hadoop | 22 | 113193 |
| 233 | jira | 20 | 104918 |
| 9 | javascript | 20 | 97587 |
| 195 | sharepoint | 18 | 81634 |

# What I Learned

- **Complex SQL quering:** advanced SQL, CTE, WITH clauses and temp tables.
- **Data Aggregation:** GROUP BY, COUNT(), AVG().
- **Analytical skills:** turned questions into actionable, insightful SQL queries. 

# Conclusions

### Insights

1. **Top-Paying Data Analyst Jobs:** the highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000.
2. **Skills for Top-Paying Jobs:** high-paying data analyst jobs require advanced proficency in SQL, suggesting it's a critical skill for earning a top salary.
3. **Most In-Demand Skills:** SQL is also the most demanded skill in the data analyst job market, making it essential for job seekers.
4. **Skills with higher salaries:** specialized skills, such as SVN and Solidity, are associated with highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value:** SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.


