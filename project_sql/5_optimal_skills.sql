/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill) for a business analyst?** 
- Identify skills in high demand and associated with high average salaries for Business Analyst roles
- Concentrates on local positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
  offering strategic insights for career development in data analysis
*/

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(DISTINCT job_postings_fact.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Business Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location ILIKE ANY (
        ARRAY['%, AR', '%, OK', '%, TX', '%, TN', '%, MS']
    )
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(DISTINCT job_postings_fact.job_id) > 5
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

/* Analysis: Optimal Skills for Business Analysts
- Tableau appears to be the most optimal skill to learn for Business Analysts,
  appearing 29 times and having the 4th highest average salary among qualified skills
  with an average salary of $107,688.
- Phoenix is the highest paying optimal skill, being demanded 7 times in my region with
  an average salary of $143,303.
*/