-- SysPostCloneBits.sql
-- SYS post clone things.
-- This script should be run as database user SYS.
--
-- Last updated: 01 September 2016 10:18:31
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


BEGIN
DBMS_APPLICATION_INFO.SET_CLIENT_INFO(client_info => 'IANM');

DBMS_APPLICATION_INFO.SET_MODULE ( 
   module_name => 'SysPostCloneBits.sql', 
   action_name => 'SYS_POSTCLONE_ACTIONS'
); 

END;
/


prompt
prompt Carrying out SYS post clone actions
prompt


prompt
prompt Compile invalid objects
@?/rdbms/admin/utlrp.sql
prompt Done

prompt
prompt Gathering system stats
EXEC DBMS_STATS.GATHER_SYSTEM_STATS(gathering_mode => 'NOWORKLOAD');
prompt Done

prompt
prompt Gathering fixed objects stats
EXEC DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;
prompt Done

-- This procedure gathers statistics for dictionary schemas
-- 'SYS', 'SYSTEM' and schemas of RDBMS components.
prompt
prompt Gathering dictionary stats
EXEC DBMS_STATS.GATHER_DICTIONARY_STATS();
prompt Done


prompt A quick look at logins, etc
SELECT logins,
       active_state,
       status
FROM   v$instance;

prompt All done now!

--------------------------------------------------------
--  End of script
--------------------------------------------------------

