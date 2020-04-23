--------------------------------------------------------
--  noarchivelog.sql
--  Places the database in noarchivelog mode, ie no
--  archive logs will be produced.
--
--  Last updated: 19 August 2016 16:27:04
--------------------------------------------------------
--
Rem =====================================================================
Rem Exit immediately if there are errors in the initial checks
Rem =====================================================================

WHENEVER SQLERROR EXIT;

DOC
######################################################################
######################################################################
    The following statement will cause an "ORA-01722: invalid number"
    error if the user running this script is not SYS.  Disconnect
    and reconnect with AS SYSDBA.
######################################################################
######################################################################
#

SELECT TO_NUMBER('MUST_BE_AS_USER_SYS') FROM DUAL
WHERE USER != 'SYS';

Rem =====================================================================
Rem Checks now complete. Carry on wth the script.
Rem =====================================================================

prompt
prompt Placing the database in noarchivelog mode
prompt
-- Make sure we're in the right database on the right server.
SELECT instance_name,
       host_name
FROM   v$instance;
-- Pause for a few seconds to consolidate the above information.
EXECUTE DBMS_LOCK.SLEEP(seconds  => 10);


ALTER SYSTEM SWITCH LOGFILE ;
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE NOARCHIVELOG;
ALTER DATABASE OPEN;


archive log list;

SELECT instance_name,
       host_name,
       logins,
       active_state,
       status
FROM   v$instance;

--------------------------------------------------------
--  End of script
--------------------------------------------------------
