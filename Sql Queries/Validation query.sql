-- Record Count
SELECT COUNT(*) FROM "MasterTable";

-- Connected Calls (excluding Not connected + Disconnected)
SELECT COUNT(*) AS connected_calls
FROM "MasterTable"
WHERE "Outcome_1" NOT IN ('Not connected', 'Disconnected')
  AND "Outcome_1" IS NOT NULL;

-- Not Connected Calls 
SELECT COUNT(*) AS not_connected_calls
FROM "MasterTable"
WHERE "Outcome_1" IN ('Not connected', 'Disconnected');

-- Completed Applications
SELECT COUNT(*) FROM "MasterTable" 
WHERE "Outcome_1" = 'Completed application';

-- Call Completion Rate
SELECT 
  ROUND(
    (SELECT COUNT(*) FROM "MasterTable" WHERE "Outcome_1" = 'Completed application')::numeric 
    / 
    (SELECT COUNT(*) FROM "MasterTable" WHERE "Outcome_1" IS NOT NULL AND "Outcome_1" <> 'Disconnected')::numeric, 
  2) AS call_completion_rate;

-- Record Count over Time
SELECT 
  DATE_TRUNC('month', TO_TIMESTAMP(received_at_ts, 'YYYY-MM-DD HH24:MI:SS'))::date AS month,
  COUNT(*) AS record_count
FROM "MasterTable"
GROUP BY month
ORDER BY month;

-- Record Count by Country
SELECT "Country",
	COUNT (*) as record_count
FROM "MasterTable"
GROUP BY "Country"
ORDER BY record_count DESC LIMIT 10;

-- Campaign Performance 
SELECT
  "Campaign_ID" AS campaign_id,
  COUNT(*) AS total_calls
FROM "MasterTable"
GROUP BY campaign_id
ORDER BY total_calls DESC LIMIT 5;

-- Call Outcome Distribution
SELECT
  CASE
    WHEN "Outcome_1" IN ('Not connected', 'Disconnected') THEN 'Not Connected'
    WHEN "Outcome_1" IN (
      'Will Submit the docx', 'Completed application', 'Will confirm later', 
      'Reschedule', 'Ready to pay the docx'
    ) THEN 'Connected'
    ELSE 'Others'
  END AS call_category,
  COUNT(*) AS call_count
FROM "MasterTable"
GROUP BY call_category
ORDER BY call_category;

-- Agent Performance
SELECT 
  "Caller_Name" AS agent_name,
  COUNT(*) AS call_count
FROM "MasterTable"
GROUP BY agent_name
ORDER BY call_count DESC LIMIT 10;


-- Call Distribution per Hour 
SELECT
    EXTRACT(HOUR FROM TO_TIMESTAMP(received_at_ts, 'YYYY-MM-DD HH24:MI:SS')) AS call_hour,
    "Outcome_1",
    COUNT(*) AS total_calls
FROM "MasterTable"
GROUP BY 
    EXTRACT(HOUR FROM TO_TIMESTAMP(received_at_ts, 'YYYY-MM-DD HH24:MI:SS')), 
    "Outcome_1"
ORDER BY call_hour DESC LIMIT 10;





	