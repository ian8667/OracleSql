--------------------------------------------------------
-- Copyright (c) 1988, 2005, Oracle.  All Rights Reserved.
--
-- NAME
--   ianm_glogin.sql
--
-- DESCRIPTION
--   SQL*Plus global login "site profile" file
--
--   Add any SQL*Plus commands here that are to be executed when a
--   user starts SQL*Plus, or uses the SQL*Plus CONNECT command.
--
-- USAGE
--   This script should be run upon logging in.
--
-- Last updated: 01 September 2016 11:44:30
--------------------------------------------------------
--

-- for flat files
-- set long 32767 longchunksize 32767 trimout on trimspool on;

-- Set NLS_DATE_FORMAT
alter session set NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

SET AUTOCOMMIT OFF
SET ECHO OFF
SET EDITFILE /tmp/afiedt.buf
SET ESCAPE ON
SET EXITCOMMIT ON
SET FEEDBACK ON
SET HEADING ON
SET LINESIZE 80
SET LOBOFFSET 1
SET LONG 3000
SET LONGCHUNKSIZE 3000
SET NULL ~
SET PAGESIZE 32
SET SERVEROUTPUT ON SIZE UNLIMITED
SET SHOWMODE ON
-- Controls whether SQL*Plus puts blank lines within a
-- SQL command or script.
SET SQLBLANKLINES ON
SET SQLNUMBER ON
SET SQLPROMPT "_CONNECT_IDENTIFIER as user _USER ==> "
SET TRIMOUT ON
SET TRIMSPOOL ON
SET VERIFY ON
BEGIN
-- Populates column V$SESSION.CLIENT_INFO.
DBMS_APPLICATION_INFO.SET_CLIENT_INFO(client_info => 'IANM');

DBMS_APPLICATION_INFO.SET_MODULE (
   module_name => 'IANM',     -- Populates column V$SESSION.MODULE.
   action_name => 'SQL*PLUS'  -- Populates column V$SESSION.ACTION.
);

END;
/

--------------------------------------------------------
--  Instance information
--------------------------------------------------------
column instance_name format a15
column host_name format a14
PROMPT
PROMPT Instance information just to confirm where we are
PROMPT

SELECT To_char(SYSDATE, 'Day DD-Mon-YYYY HH24:MI:SS') AS currdatetime
FROM   dual;

-- See who we are logged in as.
SELECT 'Connected as user '
       || USER AS curruser
FROM   dual;

SELECT instance_name,
       host_name,
       logins,
       active_state,
       status
FROM   v$instance;


-- Information from V$DATABASE.
SET LINESIZE 121
SELECT database_role,
       dataguard_broker,
       CASE cdb
         WHEN 'YES' THEN 'Database is a CDB'
         ELSE 'Database is NOT a CDB'
       END              AS cdb_status,
       platform_name,
       flashback_on
FROM   v$database;
SET LINESIZE 80

--------------------------------------------------------
--  End of script
--------------------------------------------------------


