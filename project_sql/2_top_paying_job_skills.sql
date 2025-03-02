
/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS(
    SELECT
        jp.job_id,
        jp.job_title,
        cd.name AS company,
        jp.salary_year_avg
    FROM
        job_postings_fact AS jp
    LEFT JOIN company_dim AS cd ON jp.company_id = cd.company_id 
    WHERE
        jp.job_title_short = 'Data Analyst' 
        AND jp.job_location = 'Anywhere'
        AND jp.salary_year_avg IS NOT NULL
    ORDER BY jp.salary_year_avg DESC
    LIMIT 10
)

SELECT
    tp.*,
    sd.skills
FROM top_paying_jobs AS tp 
INNER JOIN skills_job_dim AS sj ON tp.job_id = sj.job_id
INNER JOIN skills_dim AS sd ON sj.skill_id = sd.skill_id
ORDER BY tp.salary_year_avg DESC