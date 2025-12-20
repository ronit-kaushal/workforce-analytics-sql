-- =========================
-- CREATING TABLES
-- =========================

-- 1. CREATING THE clients TABLE
CREATE TABLE clients (
	client_id SERIAL PRIMARY KEY,
	client_name VARCHAR (100),
	industry VARCHAR (50),
	region VARCHAR (50)
);


-- 2. CREATING THE jobs TABLE
CREATE TABLE jobs (
	job_id SERIAL PRIMARY KEY,
	client_id INT REFERENCES clients(client_id),
	job_created_date DATE,
	job_status VARCHAR (30),
	priority VARCHAR (20),
	expected_start_date DATE
);


-- 3. CREATING THE candidates TABLE
CREATE TABLE candidates (
    candidate_id SERIAL PRIMARY KEY,
    source VARCHAR(50),
    experience_years NUMERIC(4,1),
    location VARCHAR(50)
);


-- 4. CREATING THE applications TABLE
CREATE TABLE applications (
	application_id SERIAL PRIMARY KEY,
	job_id INT REFERENCES jobs(job_id),
	candidate_id INT REFERENCES candidates(candidate_id),
	application_date DATE,
	current_stage VARCHAR (30)
);


-- 5. CREATING THE stage_events TABLE
CREATE TABLE stage_events (
	event_id SERIAL PRIMARY KEY,
	application_id INT REFERENCES applications(application_id),
	stage_name VARCHAR(30),
	stage_date DATE
);


-- 6. CREATING THE offers TABLE
CREATE TABLE offers (
	offer_id SERIAL PRIMARY KEY,
	application_id INT REFERENCES applications(application_id),
	offered_salary INT,
	accepted_flag BOOLEAN
);


-- Final schema check
SELECT
    table_name
FROM information_schema.tables
WHERE table_schema = 'public';