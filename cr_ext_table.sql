-- Is it possible to pass the file name(s) into an Oracle
-- external table?  My source files are from multiple
-- sources with the same format but different names.
--    $ alter table ext_paed_op location ('new_filename.txt');
--
-- $ CREATE OR REPLACE DIRECTORY PAED_OP_DATA as 'c:\ian';
--
-- $ GRANT READ, WRITE ON DIRECTORY PAED_OP_DATA TO IANM;
--
prompt
prompt Dropping table ext_paed_op
prompt

drop table ext_paed_op;

prompt
prompt Creating table ext_paed_op
prompt

CREATE TABLE ext_paed_op
  (
   cds_unique_id                  varchar2(35 char),
   system_number                  number(10,0),
   nhs_number                     varchar2(10 char),
   nhs_number_status              varchar2(2 char),
   patient_name                   varchar2(70 char),
   dob                            date,
   age_at_event                   number(5,2),
   gender_code                    number(1,0),
   gender_desc                    varchar2(6 char),
   ethnic_cat_code                varchar2(2 char),
   ethnic_cat_desc                varchar2(30 char),
   address                        varchar2(100 char),
   postcode                       varchar2(8 char),
   lsoa                           varchar2(9 char),
   org_code_pct_of_res            varchar2(12 char),
   gp_code                        varchar2(8 char),
   gp_desc                        varchar2(50 char),
   gp_practice_code               varchar2(12 char),
   gp_practice_desc               varchar2(50 char),
   GP_Pract_PCT_Code              varchar2(3 char),
   patient_pathway_identifier     varchar2(20 char),
   ppi_start_date                 date,
   referral_received_date         date,
   service_code                   varchar2(8 char),
   service_desc                   varchar2(50 char),
   reason_for_referral            varchar2(50 char),
   referral_source                varchar2(20 char),
   gp_or_other_referral           varchar2(6 char),
   referred_by_code               varchar2(8 char),
   referred_by_org_code           varchar2(8 char),
   event_date                     date,
   event_month                    varchar2(6 char),
   examiner_code                  varchar2(12 char),
   examiner_desc                  varchar2(30 char),
   examiner_type                  varchar2(30 char),
   venue_code                     varchar2(30 char),
   venue_desc                     varchar2(30 char),
   appointment_type_desc          varchar2(35 char),
   ppi_stop_date                  date,
   ppi_stop_month                 varchar2(20 char),
   result_code                    varchar2(20 char),
   attendance_rtt_code            varchar2(20 char),
   attendance_rtt_desc            varchar2(30 char),
   rtt_inc                        varchar2(50 char),
   attendance_status_desc         varchar2(30 char),
   wait_days                      varchar2(20 char),
   wait_timeband                  varchar2(20 char),
   seen_in_13_weeks               varchar2(10 char),
   seen_in_18_weeks               varchar2(10 char),
   imd_score                      number(10,2),
   imd_rank                       number(10,0),
   imd_national_quintile          number(1,0)
  )
organization external
(
   TYPE oracle_loader
   DEFAULT directory "PAED_OP_DATA"
   ACCESS parameters
   (
       RECORDS DELIMITED BY NEWLINE
       BADFILE PAED_OP_DATA:'ext_paed_op.bad'
       LOGFILE PAED_OP_DATA:'ext_paed_op.log'
       DISCARDFILE PAED_OP_DATA:'ext_paed_op.dsc'
       fields terminated BY ',' optionally enclosed BY '"'
       missing field VALUES are NULL
       (
         cds_unique_id,
         system_number,
         nhs_number,
         nhs_number_status,
         patient_name,
         dob                           DATE "DD/MM/YY",
         age_at_event,
         gender_code,
         gender_desc,
         ethnic_cat_code,
         ethnic_cat_desc,
         address,
         postcode,
         lsoa,
         org_code_pct_of_res,
         gp_code,
         gp_desc,
         gp_practice_code,
         gp_practice_desc,
         gp_pract_pct_code,
         patient_pathway_identifier,
         ppi_start_date                 DATE "DD/MM/YY",
         referral_received_date         DATE "DD/MM/YY",
         service_code,
         service_desc,
         reason_for_referral,
         referral_source,
         gp_or_other_referral,
         referred_by_code,
         referred_by_org_code,
         event_date                     DATE "DD/MM/YY",
         event_month,
         examiner_code,
         examiner_desc,
         examiner_type,
         venue_code,
         venue_desc,
         appointment_type_desc,
         ppi_stop_date                  DATE "DD/MM/YY",
         ppi_stop_month,
         result_code,
         attendance_rtt_code,
         attendance_rtt_desc,
         rtt_inc,
         attendance_status_desc,
         wait_days,
         wait_timeband,
         seen_in_13_weeks,
         seen_in_18_weeks,
         imd_score,
         imd_rank,
         imd_national_quintile
        )
   )
   location ( 'Apr-June1213.csv' )
)
reject limit UNLIMITED;
