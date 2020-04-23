--------------------------------------------------------
-- dictionary_statistics.sql
-- This article describes how to check dictionary statistics
-- including statistics on fixed objects. Since version 10g,
-- statistics on the data dictionary are mandatory for the
-- cost-based optimizer to work properly. Dictionary statistics
-- include the statistics on the tables and indexes owned by
-- SYS (and other internal RDBMS schemas like SYSTEM) and the
-- statistics on the fixed objects. Fixed objects are the internal
-- X$ tables and the so called dynamic performance views or V$
-- views which are based upon them. These are not real tables and
-- indexes, but rather memory structures. The statistics for the
-- fixed objects need to be gathered manually; they are not
-- updated by the automatic statistics gathering.
--
-- The following SQL*Plus script can be used to determine the
-- status of these statistics. It does not check statistics
-- for other internal schemas like for example SYSTEM as these
-- are less critical. If needed, the WHERE-clause in the first
-- query can to be modified accordingly.
--
-- Some fixed tables(X$) have no CBO statistics against them
-- and use defaults. It is expected behavior that some fixed
-- objects have no statistics. The fixed objects may be too
-- expensive to gather stats or be too volatile to gather
-- optimal stats. As an example, the fixed table
-- 'X$KGLCURSOR_CHILD' does not have statistics collected for it. 
--
-- To gather dictionary stats, execute one of the following:-
-- SQL> EXEC DBMS_STATS.GATHER_SCHEMA_STATS ('SYS');
-- SQL> exec DBMS_STATS.GATHER_DATABASE_STATS (gather_sys=>TRUE);
-- SQL> EXEC DBMS_STATS.GATHER_DICTIONARY_STATS;
-- 
-- To gather the fixed objects stats, use the following:-
-- SQL> EXEC DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;
--
-- See also:
-- How to check dictionary and fixed objects statistics (Doc ID 1474937.1)
-- Fixed Objects Statistics(GATHER_FIXED_OBJECTS_STATS) Considerations (Doc ID 798257.1)
--
-- Last updated: 19 August 2016 14:38:16
--------------------------------------------------------
--
alter session set NLS_DATE_FORMAT='YYYY-Mon-DD';

column last_analyzed format a13
set trimout on
set trimspool on
set heading on
set feedback on
set termout on
set serveroutput on
-- spool /tmp/dictionary_statistics.lst
define spoolfile=/tmp/dictionary_statistics.lst
PROMPT
PROMPT Spooling output to file &&spoolfile

spool &spoolfile


PROMPT
PROMPT
PROMPT Instance and host name
column instance_name format a14
column host_name format a18
SELECT instance_name,
       host_name
FROM   v$instance;


PROMPT
PROMPT
PROMPT Current date/time
select to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') as currdate
from dual ;


PROMPT
PROMPT
PROMPT Statistics for SYS tables
SELECT Nvl(To_char(last_analyzed, 'YYYY-Mon-DD'), 'No Stats') as last_analyzed,
       Count(*)                                               as dictionary_tables
FROM   dba_tables
WHERE  owner = 'SYS'
GROUP  BY To_char(last_analyzed, 'YYYY-Mon-DD')
ORDER  BY 1 DESC;



PROMPT
PROMPT
PROMPT Statistics for Fixed Objects
SELECT Nvl(To_char(last_analyzed, 'YYYY-Mon-DD'), 'No Stats') as last_analyzed,
       Count(*)                                               as fixed_objects
FROM   dba_tab_statistics
WHERE  object_type = 'FIXED TABLE'
GROUP  BY To_char(last_analyzed, 'YYYY-Mon-DD')
ORDER  BY 1 DESC;


PROMPT
PROMPT
PROMPT Statistics for table SYS.AUX_STATS$
column sname format a18
column pname format a18
column pval2 format a25
select * from sys.aux_stats$;



PROMPT
PROMPT
PROMPT All done now!
PROMPT See file &&spoolfile for details
PROMPT
PROMPT


spool off
alter session set NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

--------------------------------------------------------
--  End of script
--------------------------------------------------------
