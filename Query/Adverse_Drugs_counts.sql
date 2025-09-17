select DrugRelatedProblem, COUNT (documentkey) as documentno 
from clinicalinterventionreport
where DrugRelatedProblem like '%toxicity%'
and
[Date] between @from and @to
group by DrugRelatedProblem