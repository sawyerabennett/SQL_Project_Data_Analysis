/* 
Question: What are the top-paying business analyst jobs, and what skills are required?** 
- Identify the top 10 highest-paying Business Analyst jobs and the specific skills required for these roles.
- Filters for roles with specified salaries that are available locally for my location. (remove nulls)
- Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers like myself understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        job_location,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Business Analyst'
        AND job_location ILIKE ANY (
            ARRAY['%, AR', '%, OK', '%, TX', '%, TN', '%, MS'])
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC;

/*
Analysis: Top-Paying Business Analyst Jobs
- Tableau (75%), SQL (62.5%), and Snowflake (62.5%) were the most requested skills.
- Python and R appeared in 50% of positions.
- Results suggest strong demand for data visualization, SQL, and cloud analytics.
- Dataset includes 8 unique high-paying jobs in Texas, primarily senior-level roles.
*/