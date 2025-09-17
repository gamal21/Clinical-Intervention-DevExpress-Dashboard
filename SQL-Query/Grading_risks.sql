SELECT 
    RIGHT(category, 1) AS Category,
    COUNT(documentkey) AS category_count,
    ROUND(
        100.0 * COUNT(documentkey) / SUM(COUNT(documentkey)) OVER (),
        2
    ) AS percentage_of_total
FROM clinicalinterventionreport
where date between @from and @to
GROUP BY RIGHT(category, 1)
ORDER BY Category Asc;