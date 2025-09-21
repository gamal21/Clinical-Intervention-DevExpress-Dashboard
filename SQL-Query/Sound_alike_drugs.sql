select   t.trade_name ,count(g.Sys_key) as No
from Drug_table t inner join GetClinicalIntervnetions22 g

on t.Drug_code = g.Drug_code

where t.SoundALike = 1 
and date between @from and @to
group by t.trade_name
order by No desc