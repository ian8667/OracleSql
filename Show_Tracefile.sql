--------------------------------------------------------
--  Show_Tracefile.sql
--  Trace file name of the process. ie where to find
--  the trace file when you've created one.
--
--  Last updated: 19 August 2016 14:26:44
--------------------------------------------------------
--
SELECT p.tracefile
FROM   v$session s
       inner join v$process p
               ON ( p.addr = s.paddr )
                  AND Sys_context('userenv', 'sessionid') = audsid;

--------------------------------------------------------
--  End of script
--------------------------------------------------------
