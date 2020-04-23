--------------------------------------------------------
--  Get_FileInfo.sql
--  Obtains file name (and file path) information for a
--  database. This information can be useful when preparing
--  for a clone (copy) of a database when you have to remove
--  these files.
--
--  Last updated: 19 August 2016 14:51:40
--------------------------------------------------------
set heading on
set feedback on
set pagesize 1000

--------------------------------------------------------
--  Instance information
--------------------------------------------------------
column instance_name format a15
column host_name format a14
PROMPT
PROMPT Instance information
PROMPT

SELECT To_char(SYSDATE, 'DAY DD-Mon-YYYY HH24:MI:SS') AS currdatetime
FROM   dual;

SELECT instance_name,
       host_name,
       logins,
       active_state,
       status
FROM   v$instance;

--------------------------------------------------------
--  Get datafile information
--------------------------------------------------------
PROMPT
PROMPT Tablespace data files.
PROMPT
column file_id format 99 heading "File-ID"
column file_name format a52 heading "Datafile"
SELECT file_id,
       file_name
FROM   dba_data_files;


--------------------------------------------------------
--  Get online redo log information.
--------------------------------------------------------
PROMPT
PROMPT Online redo files.
PROMPT
column group# format 99 heading "Group-Nr"
column member format a60 heading "Logfile"
select group#, member from v$logfile order by group#, member;


--------------------------------------------------------
--  Get controlfile names
--------------------------------------------------------
PROMPT
PROMPT Control files
PROMPT
column name format a52
select rownum, name from v$controlfile order by name;

--------------------------------------------------------
--  Archive log mode currently in use
--------------------------------------------------------
select log_mode from v$database;


set pagesize 32
set linesize 80
--------------------------------------------------------
--  End of script
--------------------------------------------------------
