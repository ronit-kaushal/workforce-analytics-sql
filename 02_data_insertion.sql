-- =========================
-- INSERTING DATA INTO TABLES
-- =========================

-- 1. INSERT DATA INTO clients
INSERT INTO clients (client_name, industry, region)
SELECT
	'CLIENT_' || gs AS client_name,
	(ARRAY['Technology', 'Healthcare', 'Finance', 'Manufacturing', 'Retail'])
		[1 + (random() * 4)::int] AS industry,
	(ARRAY['North', 'South', 'East', 'West'])
		[1 + (random() * 3)::int] AS region
FROM generate_series(1, 15) gs;


-- 2. INSERT DATA INTO jobs
INSERT INTO jobs (client_id, job_created_date, job_status, priority, expected_start_date)
SELECT 
	(random() * 14 + 1)::int AS client_id,
	CURRENT_DATE - (random() * 365)::int AS job_created_date,
	(ARRAY['Open', 'Closed', 'On Hold'])
		[1 + (random() * 2)::int] AS job_status,
	(ARRAY['High', 'Medium', 'Low'])
		[1 + (random() * 2)::int] AS priority,
	CURRENT_DATE + (random() * 60)::int AS expected_start_date
FROM generate_series(1, 300);


-- 3. INSERT DATA INTO candidates
INSERT INTO candidates (source, experience_years, location)
SELECT 
	(ARRAY['Job Portal', 'Referral', 'LinkedIn', 'Career Page', 'Agency'])
		[1 + (random() * 4)::int] AS source,
	ROUND((random() * 12)::numeric, 1) AS experience_years,
	(ARRAY['North', 'South', 'East', 'West', 'Central'])
		[1 + (random() * 4)::int] AS location
FROM generate_series(1, 2000);


-- 4. INSERT DATA INTO applications
INSERT INTO applications (job_id, candidate_id, application_date, current_stage)
SELECT 
	(random () * 299 + 1)::int AS job_id,
	(random () * 1999 + 1)::int AS candidate_id,
	CURRENT_DATE - (random() * 300)::int AS application_date,
	CASE
        WHEN r < 0.35 THEN 'Submission'
        WHEN r < 0.55 THEN 'Shortlist'
        WHEN r < 0.70 THEN 'Interview'
        WHEN r < 0.82 THEN 'Offer'
        WHEN r < 0.90 THEN 'Hire'
        ELSE 'Rejected' END AS current_stage
FROM (
    SELECT random() AS r
    FROM generate_series(1, 5000)
) t;


-- 5. INSERT DATA INTO stage_events
-- Submission
INSERT INTO stage_events (application_id, stage_name, stage_date)
SELECT
    application_id,
    'Submission',
    application_date
FROM applications;

-- Shortlist
INSERT INTO stage_events (application_id, stage_name, stage_date)
SELECT
    a.application_id,
    'Shortlist',
    se.stage_date + (random() * 2)::int
FROM applications a
JOIN stage_events se
    ON se.application_id = a.application_id
	AND se.stage_name = 'Submission'
WHERE a.current_stage IN ('Shortlist', 'Interview', 'Offer', 'Hire');

-- Interview
INSERT INTO stage_events (application_id, stage_name, stage_date)
SELECT
    a.application_id,
    'Interview',
    se.stage_date + (1 + (random() * 4)::int)
FROM applications a
JOIN stage_events se
    ON se.application_id = a.application_id
	AND se.stage_name = 'Shortlist'
WHERE a.current_stage IN ('Interview', 'Offer', 'Hire');

-- Offer
INSERT INTO stage_events (application_id, stage_name, stage_date)
SELECT
    a.application_id,
    'Offer',
    se.stage_date + (random() * 5)::int
FROM applications a
JOIN stage_events se
    ON se.application_id = a.application_id
	AND se.stage_name = 'Interview'
WHERE a.current_stage IN ('Offer', 'Hire');

-- Hire
INSERT INTO stage_events (application_id, stage_name, stage_date)
SELECT
    a.application_id,
    'Hire',
    se.stage_date + (7 + (random() * 14)::int)
FROM applications a
JOIN stage_events se
    ON se.application_id = a.application_id
	AND se.stage_name = 'Offer'
WHERE a.current_stage = 'Hire';


-- 6. INSERT DATA INTO offers
INSERT INTO offers (application_id, offered_salary, accepted_flag)
SELECT
    application_id,
    (40000 + (random() * 150000))::int AS offered_salary,
    CASE
        WHEN current_stage = 'Hire' THEN true
        WHEN current_stage = 'Offer' THEN random() < 0.6
    END AS accepted_flag
FROM applications
WHERE current_stage IN ('Offer', 'Hire');


-- Final Validation check
SELECT
    (SELECT COUNT(*) FROM clients) AS clients,
    (SELECT COUNT(*) FROM jobs) AS jobs,
    (SELECT COUNT(*) FROM candidates) AS candidates,
    (SELECT COUNT(*) FROM applications) AS applications,
    (SELECT COUNT(*) FROM stage_events) AS stage_events,
    (SELECT COUNT(*) FROM offers) AS offers;
-- Result: clients=15, jobs=300, candidates=2000, applications=5000, stage_events=10789 and offers=962