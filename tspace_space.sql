--------------------------------------------------------
--  tspace_space.sql
--  Shows space statistics in the tablespaces. ie how
--  much free space we have etc.
--
--  Last updated: 19 August 2016 14:34:51
--------------------------------------------------------

-- Show the database name.
SELECT SYS_CONTEXT ('USERENV', 'INSTANCE_NAME') as database_name
FROM DUAL;


SELECT 
       TRIM(TO_CHAR(COALESCE(Round (c.bytes / 1024 / 1024 - Nvl(b.bytes, 0) / 1024 / 1024, 2),0))) as space_used
FROM   dba_tablespaces a,
       (SELECT tablespace_name,
               SUM (bytes) BYTES
        FROM   dba_free_space
        GROUP  BY tablespace_name) b,
       (SELECT Count (1)   DATAFILES,
               SUM (bytes) BYTES,
               tablespace_name
        FROM   dba_data_files
        GROUP  BY tablespace_name) c
WHERE  b.tablespace_name(+) = a.tablespace_name
       AND c.tablespace_name(+) = a.tablespace_name
ORDER  BY b.tablespace_name;

--------------------------------------------------------
--  End of script
--------------------------------------------------------
