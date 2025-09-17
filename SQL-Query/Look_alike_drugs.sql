select   t.trade_name ,count(g.Sys_key) as No
from trade_drug t inner join GetClinicalIntervnetions22 g

on t.trade_code = g.Drug_code

where t.LookAlike = 1 
and date between @from and @to
group by t.trade_name
order by No desc