/*
Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
offering strategic insights for career development in data analysis
*/

WITH skils_demand AS (
    SELECT 
        sd.skill_id,
        skills,
        COUNT(jp.job_id) as demand_count
    FROM
        job_postings_fact AS jp
    INNER JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
    INNER JOIN skills_dim AS sd ON sj.skill_id = sd.skill_id
    WHERE 
        jp.job_title_short = 'Data Analyst'
        AND jp.salary_year_avg IS NOT NULL
        AND jp.job_work_from_home = true
    GROUP BY sd.skill_id
), 
average_salary As (
    SELECT 
        sd.skill_id,
        skills,
        round(AVG(jp.salary_year_avg),0) as salary_avg
    FROM
        job_postings_fact AS jp
    INNER JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
    INNER JOIN skills_dim AS sd ON sj.skill_id = sd.skill_id
    WHERE 
        jp.job_title_short = 'Data Analyst'
        AND jp.salary_year_avg IS NOT NULL
        AND jp.job_work_from_home = true
    GROUP BY sd.skill_id
)

SELECT
    sd.skill_id,
    sd.skills,
    sd.demand_count,
    avs.salary_avg
FROM
    skils_demand AS sd
    INNER JOIN average_salary AS avs ON sd.skill_id = avs.skill_id 
ORDER BY
    sd.demand_count DESC, avs.salary_avg DESC
LIMIT 25

