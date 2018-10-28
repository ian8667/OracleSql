--------------------------------------------------------
-- NAME
--   where.sql
--
-- DESCRIPTION
--   Displays information showing where (which database)
--   the user is logged in to.
--
--   This script can be run anytime when logged in and also
--   by a non-privileged user.
--
-- USAGE
--   This script can be run anytime when loged in.
--
-- Last updated: 01 September 2016 14:22:42
--------------------------------------------------------
--


--------------------------------------------------------
--  Instance information
--------------------------------------------------------
PROMPT
PROMPT Information showing where we are
PROMPT

SELECT To_char(SYSDATE, 'Day DD-Mon-YYYY HH24:MI:SS') AS currdatetime
FROM   dual;

-- See who we are logged in as.
SELECT 'Connected as user '
       || USER AS curruser
FROM   dual;

column sid format a10
column client_info format a16
column instance_name format a14
column connected_from format a14 heading 'CONNECTED|FROM HOST'
column connected_to format a14 heading 'CONNECTED|TO HOST'
SELECT Sys_context ('USERENV', 'SID')           AS sid,
       Sys_context ('USERENV', 'CLIENT_INFO')   AS client_info,
       Sys_context ('USERENV', 'INSTANCE_NAME') AS instance_name,
       Sys_context ('USERENV', 'HOST')          AS connected_from,
       Sys_context ('USERENV', 'SERVER_HOST')   AS connected_to
FROM   dual;

column sid clear
column client_info clear
column instance_name clear
column connected_from clear
column connected_to clear

--------------------------------------------------------
--  End of script
--------------------------------------------------------

