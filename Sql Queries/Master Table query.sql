SELECT * FROM "MasterTable"

UPDATE "MasterTable" SET "Country" = 'Unknown' where "Country" = 'NULL';
UPDATE "MasterTable" SET "applicant_university" = 'Unknown' where "applicant_university" = 'NULL';
UPDATE "MasterTable" SET "Phone_Number" = 'Unknown' where "Phone_Number" = 'NULL';

ALTER TABLE "MasterTable" ADD COLUMN call_hour INT;
UPDATE "MasterTable" SET call_hour = EXTRACT(HOUR FROM received_at_ts::timestamp);

ALTER TABLE "MasterTable" ADD COLUMN call_date DATE;
UPDATE "MasterTable" SET call_date = CAST(received_at_ts AS DATE);

ALTER TABLE "MasterTable" RENAME COLUMN "Phone_Number" TO phone_number;
ALTER TABLE "MasterTable" ADD COLUMN id SERIAL PRIMARY KEY;


