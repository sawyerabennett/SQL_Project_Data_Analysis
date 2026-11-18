/*Answer: What are the top skills based on salary?** 
- Look at the average salary associated with each skill for Business Analyst positions.
- Focuses on roles with specified salaries, with a focus on local job postings. (remove nulls)
- Why? It reveals how different skills impact salary levels for Business Analysts and helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM
  job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Business Analyst' AND
    salary_year_avg IS NOT NULL AND    
    job_location ILIKE ANY (
            ARRAY['%, AR', '%, OK', '%, TX', '%, TN', '%, MS'])
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/* Analysis: Top Skills Based on Salary for Business Analysts
- This query returned a much more niche set of skills that I'm not super familiar with
- The results lead me to want to explore the quantity of postings associated with each of these
  niche skills
- Python has an average salary of $104,038. Supporting the claim that it is a high-paying skill,
  but it is not as in-demand as other skills like SQL and Excel
- Excel doesn't appear here, but SQL does with an average salary of $92,964
*/