DELETE FROM "OutreachData" a
USING (
    SELECT MIN(ctid) AS ctid, "Reference_ID", "Recieved_At", "University", 
           "Caller_Name", "Outcome_1", "Remark", "Campaign_ID", "Escalation_Required"
    FROM "OutreachData"
    GROUP BY "Reference_ID", "Recieved_At", "University", 
             "Caller_Name", "Outcome_1", "Remark", "Campaign_ID", "Escalation_Required"
    HAVING COUNT(*) > 1
) dups
WHERE a."Reference_ID" = dups."Reference_ID"
  AND a."Recieved_At" = dups."Recieved_At"
  AND a."University" = dups."University"
  AND a."Caller_Name" = dups."Caller_Name"
  AND a."Outcome_1" = dups."Outcome_1"
  AND COALESCE(a."Remark", '') = COALESCE(dups."Remark", '')
  AND a."Campaign_ID" = dups."Campaign_ID"
  AND a."Escalation_Required" = dups."Escalation_Required"
  AND a.ctid <> dups.ctid;

ALTER TABLE "OutreachData"
ADD COLUMN received_at_ts TIMESTAMP;

UPDATE "OutreachData"
SET received_at_ts = TO_TIMESTAMP("Recieved_At", 'MM/DD/YYYY HH24:MI');

ALTER TABLE "OutreachData" RENAME COLUMN "Recieved_At" TO "Received_At";

DELETE FROM "OutreachData" WHERE "Reference_ID" IS NULL;

UPDATE "OutreachData"
SET "Escalation_Required" = INITCAP("Escalation_Required");

DELETE FROM "OutreachData"
WHERE LENGTH("Reference_ID") <> 6
  OR "Reference_ID" ~ '[^0-9]';
