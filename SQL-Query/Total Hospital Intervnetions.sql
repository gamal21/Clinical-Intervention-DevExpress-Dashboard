--Total Interventions per hospital
SELECT 
    Metric,
    Value,
	CASE
		WHEN Metric IN ('Number Of Patients','Number Of Total Interventions') THEN NULL
		ELSE Value*1.0 / NULLIF(MAX(Value) OVER(), 0)
	END AS Per
	
FROM (
    SELECT 
        COUNT(DISTINCT patient_id) AS [Number Of Patients],
        COUNT(documentkey) AS [Number Of Total Interventions],
        COUNT(CASE WHEN response IN ('Accepted', 'Modified Then Accepted') THEN 1 END) AS [Number Of Accepted Interventions],
        COUNT(CASE WHEN response IN ('Rejected', 'Rejected,') THEN 1 END) AS [Number Of Rejected],
        COUNT(CASE WHEN response IN ('Pending', 'Pending,') OR response IS NULL THEN 1 END) AS [Pending]
    FROM clinicalinterventionreport WITH(NOLOCK)
    WHERE [date] BETWEEN @from AND @to
) Aggregated
CROSS APPLY (
    VALUES 
        ('Number Of Patients', [Number Of Patients]),
        ('Number Of Total Interventions', [Number Of Total Interventions]),
        ('Number Of Accepted Interventions', [Number Of Accepted Interventions]),
        ('Number Of Rejected', [Number Of Rejected]),
        ('Pending', [Pending])
) AS Unpivoted(Metric, Value);