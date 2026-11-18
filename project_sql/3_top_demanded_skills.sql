/*
Question: What are the most in-demand skills for business analysts?**
- Identify the top 5 in-demand skills for a business analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
  providing insights into the most valuable skills for job seekers.
*/

SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
  job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Business Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

/* Analysis: Most In-Demand Skills for Business Analysts
- SQL is the most demanded skill for Business Analysts, showing up 17,372 times!
- Excel appeared nearly as much, with 17,134 postings. This is interesting because it 
  showed up in 44% of the top-paying jobs, showing that while it may not be a high-paying skill,
  it is still highly demanded in the job market and an essential entry level skill.
- Tableau and Power BI both appeared roughly 9,300 times, showing that data visualization 
  is a highly demanded skill for Business Analysts.
- Python leans more into data science, but it still came in as the 5th most demanded skill
  for Business Analysts, appearing 8,097 times. It's a skill that takes time to learn but is
  essential for the high paying jobs
*/