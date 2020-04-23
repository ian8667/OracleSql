--------------------------------------------------------
--  log_switches.sql
--  http://www.oracle-wiki.net/startsqlshowredoswitches
--  Script to check the frequency of Oracle log switches.
--  Estimating the Amount of Redo Per Day (Doc ID 1037780.6)
--
--  Can Not Allocate Log (Doc ID 1265962.1)
--
--  Last updated: 19 August 2016 14:10:22
--------------------------------------------------------
--
COL DAY FORMAT a15;
COL HOUR FORMAT a4;
SELECT to_char(first_time, 'yyyy-mm-dd') as perday,
       to_char(first_time, 'hh24') as hour,
       count(*) as total
FROM   v$log_history
WHERE  thread# = 1
GROUP BY to_char(first_time, 'yyyy-mm-dd'),
         to_char(first_time, 'hh24')
ORDER BY to_char(first_time, 'yyyy-mm-dd'),
         to_char(first_time, 'hh24') asc;

# -----

select * from v$log_history
where trunc(sysdate) = trunc(first_time);

# -----

Here is the query for the redo log switch frequency:

select to_char(first_time,'YYYY-MON-DD') day,
to_char(sum(decode(to_char(first_time,'HH24'),'00',1,0)),'999') as "00",
to_char(sum(decode(to_char(first_time,'HH24'),'01',1,0)),'999') as "01",
to_char(sum(decode(to_char(first_time,'HH24'),'02',1,0)),'999') as "02",
to_char(sum(decode(to_char(first_time,'HH24'),'03',1,0)),'999') as "03",
to_char(sum(decode(to_char(first_time,'HH24'),'04',1,0)),'999') as "04",
to_char(sum(decode(to_char(first_time,'HH24'),'05',1,0)),'999') as "05",
to_char(sum(decode(to_char(first_time,'HH24'),'06',1,0)),'999') as "06",
to_char(sum(decode(to_char(first_time,'HH24'),'07',1,0)),'999') as "07",
to_char(sum(decode(to_char(first_time,'HH24'),'08',1,0)),'999') as "08",
to_char(sum(decode(to_char(first_time,'HH24'),'09',1,0)),'999') as "09",
to_char(sum(decode(to_char(first_time,'HH24'),'10',1,0)),'999') as "10",
to_char(sum(decode(to_char(first_time,'HH24'),'11',1,0)),'999') as "11",
to_char(sum(decode(to_char(first_time,'HH24'),'12',1,0)),'999') as "12",
to_char(sum(decode(to_char(first_time,'HH24'),'13',1,0)),'999') as "13",
to_char(sum(decode(to_char(first_time,'HH24'),'14',1,0)),'999') as "14",
to_char(sum(decode(to_char(first_time,'HH24'),'15',1,0)),'999') as "15",
to_char(sum(decode(to_char(first_time,'HH24'),'16',1,0)),'999') as "16",
to_char(sum(decode(to_char(first_time,'HH24'),'17',1,0)),'999') as "17",
to_char(sum(decode(to_char(first_time,'HH24'),'18',1,0)),'999') as "18",
to_char(sum(decode(to_char(first_time,'HH24'),'19',1,0)),'999') as "19",
to_char(sum(decode(to_char(first_time,'HH24'),'20',1,0)),'999') as "20",
to_char(sum(decode(to_char(first_time,'HH24'),'21',1,0)),'999') as "21",
to_char(sum(decode(to_char(first_time,'HH24'),'22',1,0)),'999') as "22",
to_char(sum(decode(to_char(first_time,'HH24'),'23',1,0)),'999') as "23"
from v$log_history
group by to_char(first_time,'YYYY-MON-DD');

--------------------------------------------------------
--  End of script
--------------------------------------------------------
