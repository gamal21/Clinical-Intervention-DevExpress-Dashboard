SELECT 
    Metric,
    Value,
    CASE 
        WHEN Metric = 'Total number of medication errors' THEN NULL
        ELSE Value * 1.0 / NULLIF(MAX(Value) OVER(), 0)
    END AS Per
FROM (
    SELECT 
        COUNT(CASE WHEN Category IN ('Category A', 'Category B') THEN 1 END) AS [Number of medication errors didn’t reach patients],
        COUNT(CASE WHEN Category IN ('Category C', 'Category D', 'Category E', 'Category F', 'Category G', 'Category H', 'Category I') THEN 1 END) AS [Number of medication errors reached patients],
        COUNT(Documentkey) AS [Total number of medication errors],
       COUNT(CASE WHEN Category IN ('Category C', 'Category D', 'Category E', 'Category F', 'Category G', 'Category H', 'Category I') THEN 1 END) * 1.0 / NULLIF(COUNT(Documentkey), 0) AS [Percentage of errors reached patients]
    FROM clinicalinterventionreport 
    WHERE Date BETWEEN @from AND @to
) Aggregated
CROSS APPLY (
    VALUES 
        ('Number of medication errors didn’t reach patients', [Number of medication errors didn’t reach patients]),
        ('Number of medication errors reached patients', [Number of medication errors reached patients]),
        ('Total number of medication errors', [Total number of medication errors])
) AS Unpivoted(Metric, Value);