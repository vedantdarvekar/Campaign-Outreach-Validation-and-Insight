Delete from "ApplicantData" where "App_ID" is null;

Delete from "ApplicantData" a
using(
select min(ctid) as ctid, "App_ID", "Country", "University", "Phone_Number"
from "ApplicantData"
group by "App_ID", "Country", "University", "Phone_Number"
having count(*) > 1
) dups
where a."App_ID" = dups."App_ID"
and a."Country" = dups."Country"
and a."University" = dups."University"
and a."Phone_Number" = dups."Phone_Number"
and a.ctid <> dups.ctid;

Delete from "ApplicantData" where Length("Phone_Number") <10 or Length("Phone_Number") >13;

Update "ApplicantData" set "Country" = INITCAP("Country");

Delete from "ApplicantData" where "Country" ILIKE '%@%.%'; 
Delete from "ApplicantData" where "Country" = '-';

DELETE FROM "ApplicantData"
WHERE LENGTH("App_ID") <> 6
  OR "App_ID" ~ '[^0-9]';