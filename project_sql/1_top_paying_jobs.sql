/* 
Question: What are the top-paying business analyst jobs?**
- Identify the top 10 highest-paying Business Analyst roles that are available locally for my location.
- Focuses on job postings with specified salaries. (remove nulls)
- Why? Aims to highlight the top-paying opportunities for Business Analysts, offering insights into employment options and location flexibility.
*/

SELECT
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
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
LIMIT 10;

/*
Analysis: Top-Paying Business Analyst Jobs
- All of the top paying jobs in my region are in Texas.
- The salary range for the top paying jobs ranges from $120,000 to $172,500. With the average being $146,121.
- USAA appears to be a well paying employer, contributing 5 of the 10 highest paying jobs
- Unsurpisingly, the top paying jobs are all senior/lead-level positions, with 5 of the 10 being senior-level roles.
*/