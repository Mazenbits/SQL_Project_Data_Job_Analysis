/*

Answer: What are the top skills based on salary?
Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and
helps identify the most financially rewarding skills to acquire or improve

*/

SELECT 
    skills,
    round(AVG(jp.salary_year_avg),0) as salary_avg
FROM
    job_postings_fact AS jp
INNER JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
INNER JOIN skills_dim AS sd ON sj.skill_id = sd.skill_id
WHERE 
    jp.job_title_short = 'Data Analyst'
    AND jp.salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY salary_avg DESC
LIMIT 25

