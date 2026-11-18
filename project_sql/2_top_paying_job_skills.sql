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

/* Analysis: Top-Paying Business Analyst Jobs and Required Skills with Them
- Data visualizations skills are clearly essential for Business Analysts,
  with Tableau appearing in 89% of the top-paying jobs
- SQL is heavily in demand as well, appearing in 78% of the top-paying jobs
- Python and R both appear in 56% of postings
- Excel may be old, but it still appears in 44% of postings, showing it's relevance still
*/