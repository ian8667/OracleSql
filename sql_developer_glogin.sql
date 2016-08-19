--------------------------------------------------------
-- Copyright (c) 1988, 2005, Oracle.  All Rights Reserved.
--
-- NAME
--   sql_developer_glogin.sql
--
-- DESCRIPTION
--   SQL*Plus global login "site profile" file
--
--   Add any SQL*Plus commands here that are to be executed when a
--   user starts SQL*Plus, or uses the SQL*Plus CONNECT command.
--
-- USAGE
--   This script is automatically run from SQL Developer upon
--   opening a connection.
--
-- KEYWORDS
--   oracle glogin sqlplus database sqldeveloper
--
-- Last updated: 19 August 2016 23:57:04
--------------------------------------------------------

-- Set NLS_DATE_FORMAT
alter session set NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

BEGIN
DBMS_APPLICATION_INFO.SET_CLIENT_INFO(client_info => 'IANM');

DBMS_APPLICATION_INFO.SET_MODULE(
   module_name => 'SQLDEVELOPER',
   action_name => 'SQLDEVELOPER');
END;
/

--------------------------------------------------------
--  End of script
--------------------------------------------------------
