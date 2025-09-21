select  distinct LEFT(Medication_Error_Desc, 10) AS Category ,
    SUBSTRING(Medication_Error_Desc, 11, LEN(Medication_Error_Desc)) AS Descrip
from Clinicalview
order by Category asc