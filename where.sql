-- - - - - - - - - - - - - - Script begins here - - - - - - - - - - - - - -
--  NAME:  where.sql
--  Version: 1.1
--  Executed as any valid database user.
-- ------------------------------------------------------------------------
-- AUTHOR:
-- Ian Molloy
-- ------------------------------------------------------------------------
-- PURPOSE:
-- Uses SYS_CONTEXT to obtain relevant and pertinent database
-- related information such as instance name, os_user. etc.
--
-- Saves manually running SQL queries to confirm which database
-- you are in, who you are logged in as etc, etc.
-- ------------------------------------------------------------------------
-- NOTE:
-- Asserts that this script, where.sql, writes no database
-- state (does not modify database tables).
-- ------------------------------------------------------------------------
--
PROMPT
PROMPT ========================================
PROMPT

PROMPT
PROMPT

PROMPT Name of the default schema being used in the current
PROMPT schema. This value can be changed during the session
PROMPT with an ALTER SESSION SET CURRENT_SCHEMA statement.
PROMPT
column CURRENT_SCHEMA format a20
SELECT Sys_context('userenv', 'CURRENT_SCHEMA') AS CURRENT_SCHEMA
FROM   dual;
column CURRENT_SCHEMA clear

PROMPT
PROMPT ========================================
PROMPT

PROMPT
PROMPT
PROMPT Name of the database as specified in the DB_NAME
PROMPT initialization parameter.
PROMPT
column DDB_NAME format a20
SELECT Sys_context('userenv', 'DB_NAME') AS DDB_NAME
FROM   dual;
column DDB_NAME clear

PROMPT
PROMPT ========================================
PROMPT

PROMPT
PROMPT
PROMPT Name of the database as specified in the DB_UNIQUE_NAME
PROMPT initialization parameter.
PROMPT
column DB_UNIQUE_NAME format a20
SELECT Sys_context('userenv', 'DB_UNIQUE_NAME') AS DB_UNIQUE_NAME
FROM   dual;
column DB_UNIQUE_NAME clear

PROMPT
PROMPT ========================================
PROMPT

PROMPT
PROMPT
PROMPT Operating system user name of the client process that
PROMPT initiated the database sessionOperating system user
PROMPT name of the client process that initiated the database
PROMPT session.
PROMPT
column OS_USER format a20
SELECT Sys_context('userenv', 'OS_USER') as OS_USER
FROM   dual;
column OS_USER clear

PROMPT
PROMPT ========================================
PROMPT

PROMPT
PROMPT SID for the session
PROMPT
column SID format a20
SELECT Sys_context('userenv', 'SID') AS SID
FROM   dual; 
column SID clear


PROMPT
PROMPT ========================================
PROMPT

PROMPT
PROMPT SHOW section.
PROMPT

show linesize
show pagesize
show spool
show autocommit

PROMPT
PROMPT ========================================
PROMPT

PROMPT
PROMPT Summary.
PROMPT

column instance format a15
column instance_num format a15
column hostname format a15
column current_user format a15
SELECT INSTANCE,
       instance_num,
       hostname,
       current_user
FROM   (SELECT Sys_context('userenv', 'INSTANCE_NAME') AS INSTANCE
        FROM   dual),
       (SELECT Sys_context('userenv', 'INSTANCE') AS INSTANCE_NUM
        FROM   dual),
       (SELECT Sys_context('userenv', 'SERVER_HOST') AS HOSTNAME
        FROM   dual),
       (SELECT Sys_context('userenv', 'SESSION_USER') AS CURRENT_USER
        FROM   dual);
column instance clear
column instance_num clear
column hostname clear
column current_user clear

-- - - - - - - - - - - - - - - - Script ends here - - - - - - - - - - - - - -
