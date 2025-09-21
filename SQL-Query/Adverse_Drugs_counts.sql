select DrugRelatedProblem, COUNT (documentkey) as documentno 
from Clinicalview
where DrugRelatedProblem like '%toxicity%'
and
[Date] between @from and @to
group by DrugRelatedProblem