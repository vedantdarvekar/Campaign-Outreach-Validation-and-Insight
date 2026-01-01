ALTER TABLE "CampaignData"
ADD COLUMN start_timestamp TIMESTAMP;

UPDATE "CampaignData"
SET start_timestamp = TO_TIMESTAMP("Start_Date", 'MM/DD/YYYY HH24:MI');

DELETE FROM "CampaignData" WHERE "ID" IS NULL;

UPDATE "CampaignData"
SET "Status" = INITCAP("Status");
