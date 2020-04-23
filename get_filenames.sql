--------------------------------------------------------
--  Obtains filename and log_mode information for a
--  database. This information can be useful when
--  preparing for a clone (copy) of a database.
--
--  Last updated: 16 May 2016 09:59:05
--------------------------------------------------------


--------------------------------------------------------
--  Get datafile information
--------------------------------------------------------
set heading on
set feedback on
set pagesize 1000

column file# format 99 heading "File-ID"
column name format a60 heading "Datafile"
select file#, name from v$dbfile order by file#;


--------------------------------------------------------
--  Get online redo log information.
--------------------------------------------------------
column group# format 99 heading "Group-Nr"
column member format a60 heading "Logfile"
select group#, member from v$logfile order by group#, member;


--------------------------------------------------------
--  Get archive log mode information.
--------------------------------------------------------
select log_mode from v$database;

--------------------------------------------------------
--  End of script
--------------------------------------------------------
