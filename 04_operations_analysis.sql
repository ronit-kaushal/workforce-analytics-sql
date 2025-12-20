-- =========================
-- OPERATIONAL & BUSINESS QUESTIONS
-- =========================

-- Q1. How many applications are at each final stage?
SELECT
	current_stage,
	COUNT(*) AS application_count
FROM applications
GROUP BY current_stage
ORDER BY application_count DESC;
-- Result: Submission=1773, Shortlist=1034, Interview=754, Offer=601, Rejected=477 and Hire=361


-- Q2. What is the overall submission to hire conversion rate?
SELECT
	ROUND(
    	100.0 * 
		SUM(CASE WHEN current_stage = 'Hire' THEN 1 ELSE 0 END)
    	/ COUNT(*),
    	2) AS submission_to_hire_rate
FROM applications;
-- Result: 7.22% 


-- Q3. What are the stage-wise funnel drop-off counts?
SELECT
    current_stage,
    applications,
    LAG(applications) OVER (ORDER BY stage_rank) - applications AS drop_off
FROM (
    SELECT
        current_stage,
        COUNT(*) AS applications,
        CASE current_stage
            WHEN 'Submission' THEN 1
            WHEN 'Shortlist'  THEN 2
            WHEN 'Interview'  THEN 3
            WHEN 'Offer'      THEN 4
            WHEN 'Hire'       THEN 5 END AS stage_rank
    FROM applications
    WHERE current_stage IN ('Submission', 'Shortlist', 'Interview', 'Offer', 'Hire')
	GROUP BY current_stage) AS stage_counts
ORDER BY stage_rank;
-- Result: Submission→Shortlist=739, Shortlist→Interview=280, Interview→Offer=153 and Offer→Hire=240


-- Q4. What is the average time to hire (in days)?
SELECT 
	ROUND (
		AVG(h.stage_date - s.stage_date), 2) AS avg_time_to_hire_days
FROM stage_events s
JOIN stage_events h
	ON s.application_id = h.application_id
WHERE s.stage_name = 'Submission'
  AND h.stage_name = 'Hire';
-- Result: 20.45 days


-- Q5. What is the average time spent at each stage?
SELECT
	stage_name,
	ROUND(AVG(stage_date - prev_stage_date), 2) AS avg_days_in_stage
FROM (
	SELECT
		application_id,
		stage_name,
		stage_date,
		LAG(stage_date) OVER(PARTITION BY application_id ORDER BY stage_date) AS prev_stage_date
	FROM stage_events) AS stage_transitions
WHERE prev_stage_date IS NOT NULL
GROUP BY stage_name
ORDER BY avg_days_in_stage DESC;
-- Result: Hire=13.89, Interview=2.94, Offer=2.64 and Shortlist=1.13 days


-- Q6. What is the overall offer acceptance rate?
SELECT
	ROUND(
    	100.0 * 
		SUM(CASE WHEN accepted_flag = true THEN 1 ELSE 0 END)
    	/ COUNT(*),
    	2) AS offer_acceptance_rate
FROM offers;
-- Result: 72.77%


-- Q7. How does the average offered salary (USD) differ between hired and non-hired candidates?
SELECT
	CASE
		WHEN a.current_stage = 'Hire' THEN 'Hired'
		ELSE 'Not Hired'
	END as outcome,
	ROUND(AVG(o.offered_salary)) AS avg_offered_salary
FROM offers o
JOIN applications a
	ON o.application_id = a.application_id
GROUP BY outcome;
-- Result: Not hired=115491 USD, Hired=121828 USD


-- Q8. Which clients have the highest hiring volume?
SELECT 
	c.client_name,
	COUNT(*) AS hire_count
FROM applications a
JOIN jobs j
	ON a.job_id = j.job_id
JOIN clients c
	ON j.client_id = c.client_id
WHERE a.current_stage = 'Hire'
GROUP BY c.client_name
ORDER BY hire_count DESC
LIMIT 5;
-- Result: CLIENT_4=37, CLIENT_12=31, CLIENT_2=30, CLIENT_3=29 AND CLIENT_13=29


-- Q9. Which sourcing channels have the highest hire efficiency?
SELECT
	c.source,
	COUNT(*) AS total_applications,
	COUNT(*) FILTER (WHERE a.current_stage='Hire') AS hires,
	ROUND(
		100.0 *
		COUNT(*) FILTER (WHERE a.current_stage='Hire')
		/ COUNT (*),
		2) AS hire_rate
FROM applications a
JOIN candidates c
	ON a.candidate_id = c.candidate_id
GROUP BY c.source
ORDER BY hire_rate DESC;
-- Result: Job portal=9.31, Agency=7.40, Career Page=7.21, LinkedIn=6.86 and Referral=6.55


-- Q10. What percentage of interviewed candidates ultimately convert to hires?
-- Measures post-interview funnel efficiency
WITH interview_pool AS (
	SELECT application_id, current_stage
	FROM applications
	WHERE current_stage IN ('Interview', 'Offer', 'Hire')
)
SELECT
	ROUND(
		100.0 * 
		COUNT(*) FILTER (WHERE current_stage = 'Hire')
		/ COUNT(*),
		2) AS interview_to_hire_conversion
FROM interview_pool;
-- Result: 21.04%