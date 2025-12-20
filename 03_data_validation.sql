-- =========================
-- DATA VALIDATION
-- =========================

-- 1. Every application must have exactly one Submission event
SELECT COUNT(*) AS missing_submission_apps
FROM applications a
LEFT JOIN stage_events se
	ON a.application_id = se.application_id
	AND se.stage_name = 'Submission'
WHERE se.application_id IS NULL;
-- Result: 0


-- 2. Interview without Shortlist should not exist
SELECT COUNT(*) AS interview_without_shortlist
FROM stage_events i
LEFT JOIN stage_events s
    ON i.application_id = s.application_id
	AND s.stage_name = 'Shortlist'
WHERE i.stage_name = 'Interview'
  AND s.application_id IS NULL;
-- Result: 0


-- 3. No offers for invalid application stages
SELECT COUNT(*) AS invalid_offers
FROM offers o
JOIN applications a
	ON o.application_id = a.application_id
WHERE a.current_stage NOT IN ('Offer','Hire');
-- Result: 0


-- 4. Hired applications must have accepted offers
SELECT COUNT(*) AS hired_without_accepted_offer
FROM applications a
LEFT JOIN offers o
    ON a.application_id = o.application_id
WHERE a.current_stage = 'Hire'
  AND o.accepted_flag IS DISTINCT FROM true;
-- Result: 0


-- 5. Validate Funnel Order
SELECT
    current_stage,
    COUNT(*) AS applications
FROM applications
GROUP BY current_stage
ORDER BY applications DESC;
-- Submission: 1773, Shortlist: 1034, Interview: 754, Offer: 601, Rejected: 477 and Hire: 361