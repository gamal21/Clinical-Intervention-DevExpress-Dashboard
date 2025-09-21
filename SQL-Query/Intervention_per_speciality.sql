-- Speciality Report 
SELECT 
    speciality,

    COUNT(documentkey) AS total_documents,

    CAST(
        100.0 * COUNT(documentkey) / NULLIF(SUM(COUNT(documentkey)) OVER (), 0)
        AS DECIMAL(10,2)
    ) AS total_documents_percent,

    COUNT(CASE WHEN response IN ('Accepted', 'Modified Then Accepted') THEN 1 END) AS accepted_count,

    CAST(
        100.0 * COUNT(CASE WHEN response IN ('Accepted', 'Modified Then Accepted') THEN 1 END)
        / NULLIF(COUNT(documentkey), 0)
        AS DECIMAL(10,2)
    ) AS accepted_percent,

    COUNT(CASE WHEN response IN ('Rejected', 'Rejected,') THEN 1 END) AS rejected_count,

    CAST(
        100.0 * COUNT(CASE WHEN response IN ('Rejected', 'Rejected,') THEN 1 END)
        / NULLIF(COUNT(documentkey), 0)
        AS DECIMAL(10,2)
    ) AS rejected_percent,

    COUNT(CASE WHEN response IN ('Pending', 'Pending,') OR response IS NULL THEN 1 END) AS pending_count,

    CAST(
        100.0 * COUNT(CASE WHEN response IN ('Pending', 'Pending,') OR response IS NULL THEN 1 END)
        / NULLIF(COUNT(documentkey), 0)
        AS DECIMAL(10,2)
    ) AS pending_percent,

    COUNT(CASE WHEN RIGHT(category, 1) IN ('D', 'E', 'F', 'G', 'H', 'I') THEN 1 END) AS category_count

FROM Clinicalview
WHERE [date] BETWEEN @from AND @to
GROUP BY 
    speciality
ORDER BY 
    total_documents DESC;