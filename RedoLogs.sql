--------------------------------------------------------
--  RedoLogs.sql
--  Obtains information relating to the online redo logs.
--
--  Last updated: 19 August 2016 14:50:10
--------------------------------------------------------


--------------------------------------------------------
--  Online redo log information.
--------------------------------------------------------
set heading on
set feedback on
set linesize 300
column REDOLOG_FILE_NAME format a42
column STATUS format a15

PROMPT
PROMPT Online redo log information
PROMPT
SELECT a.group#,
       a.thread#,
       a.sequence#,
       a.archived,
       a.status,
       b.member                  AS REDOLOG_FILE_NAME,
       ( a.bytes / 1048576 ) AS SIZE_MB
FROM   v$log a
       inner join v$logfile b
               ON (a.group# = b.group#)
ORDER  BY a.group# ASC;

set linesize 80
--------------------------------------------------------
--  End of script
--------------------------------------------------------

