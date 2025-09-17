select top 5  DrugName, COUNT(Sys_key) AS category_count
FROM GetClinicalIntervnetions22
where DrugName is not null
and 
Date between @from and @to
group by DrugName
order by category_count desc;