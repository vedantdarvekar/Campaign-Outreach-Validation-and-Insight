CREATE OR REPLACE VIEW v_master_table AS
SELECT
  o."Reference_ID"                 AS app_id,
  a."Country",
  a."University"                   AS applicant_university,
  a."Phone_Number",
  o.received_at_ts,
  o."Caller_Name",
  o."Outcome_1",
  o."Remark",
  o."Campaign_ID",
  c."Name"                         AS campaign_name,
  c."Category",
  c."Intake",
  c."Status",
  c.start_timestamp
FROM "OutreachData" o
LEFT JOIN "Applicantdata" a
  ON a."App_ID" = o."Reference_ID"
LEFT JOIN "CampaignData" c
  ON c."ID" = o."Campaign_ID";

SELECT * FROM public.v_master_table

UPDATE v_master_table SET "Country" = 'Unknown' where "Country" is NULL;