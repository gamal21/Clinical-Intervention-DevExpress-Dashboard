SELECT 
    StaffName, 

    -- Total interventions by staff
    COUNT(Documentkey) AS [Total Interventions per Staff],

    -- % of staff interventions vs all interventions
    COUNT(Documentkey) * 1.0 / NULLIF(
        (SELECT COUNT(Documentkey) FROM clinicalinterventionreport WITH (NOLOCK)), 0
    ) AS [% of Staff Interventions vs All],

    -- Accepted Interventions and %
    COUNT(CASE WHEN response IN ('Accepted', 'Modified Then Accepted') THEN 1 END) AS [Accepted Interventions],
    COUNT(CASE WHEN response IN ('Accepted', 'Modified Then Accepted') THEN 1 END) * 1.0 / NULLIF(COUNT(DocumentKey), 0) AS [% of Accepted],

    -- Rejected Interventions and %
    COUNT(CASE WHEN response IN ('Rejected', 'Rejected,') THEN 1 END) AS [Rejected Interventions],
    COUNT(CASE WHEN response IN ('Rejected', 'Rejected,') THEN 1 END) * 1.0 / NULLIF(COUNT(DocumentKey), 0) AS [% of Rejected],

    -- Pending Interventions and %
    COUNT(CASE WHEN response IN ('Pending', 'Pending,') OR response IS NULL THEN 1 END) AS [Pending Interventions],
    COUNT(CASE WHEN response IN ('Pending', 'Pending,') OR response IS NULL THEN 1 END) * 1.0 / NULLIF(COUNT(DocumentKey), 0) AS [% of Pending],
           COUNT(CASE WHEN Category IN ('Category D', 'Category E', 'Category F', 'Category G', 'Category H', 'Category I') THEN 1 END) as [Category D,E,F,G,H,I]


FROM Clinicalview WITH (NOLOCK)
WHERE StaffName NOT IN ('ADMIN', 'Admin') and
date between @from and @to
GROUP BY StaffName
ORDER BY [Total Interventions per Staff] DESC;