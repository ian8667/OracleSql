--------------------------------------------------------
--  Get_FileInfo.sql
--  Obtains file name (and file path) information for a
--  database. This information can be useful when preparing
--  for a clone (copy) of a database when you have to remove
--  these files.
--
--  Last updated: 02 September 2016 15:10:00
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


-- A distinct listing of the above.
with positions
as (
  select file_name,
      instr(file_name, '/', -1) as pos1,
      instr(file_name, '.', -1) as pos2
  from dba_data_files )
select distinct REPLACE(t1.file_name, substr(t1.file_name, t2.pos1, (t2.pos2-t2.pos1)), '/*') as distinct_paths
from dba_data_files t1, positions t2
where t1.file_name = t2.file_name;

--------------------------------------------------------
--  Get online redo log information.
--------------------------------------------------------
PROMPT
PROMPT Online redo files.
PROMPT
column group# format 99 heading "Group-Nr"
column member format a60 heading "Logfile"
select group#, member from v$logfile order by group#, member;


-- A distinct listing of the above.
with positions
as (
  select member,
      instr(member, '/', -1) as pos1,
      instr(member, '.', -1) as pos2
  from v$logfile )
select distinct REPLACE(t1.member, substr(t1.member, t2.pos1, (t2.pos2-t2.pos1)), '/*') as distinct_paths
from v$logfile t1, positions t2
where t1.member = t2.member;

--------------------------------------------------------
--  Get controlfile names
--------------------------------------------------------
PROMPT
PROMPT Control files
PROMPT
column name format a52
column SUMMARY_OF_PATHS format a52
select rownum, name from v$controlfile order by name;


-- A distinct listing of the above.
WITH positions
     AS (SELECT name,
                Instr(name, '/', -1) AS pos1,
                Instr(name, '.', -1) AS pos2
         FROM   v$controlfile)
SELECT DISTINCT Replace(t1.name, Substr(t1.name, t2.pos1,
                ( t2.pos2 - t2.pos1 )), '/*') AS
                distinct_paths
FROM   v$controlfile t1,
       positions t2
WHERE  t1.name = t2.name;


--------------------------------------------------------
--  Archive log mode currently in use
--------------------------------------------------------
select log_mode from v$database;


set pagesize 32
set linesize 80
--------------------------------------------------------
--  End of script
--------------------------------------------------------
