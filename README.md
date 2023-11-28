## shopclues_sql_queries
<h3 style="color:blue;">Overview of code:</h3>
- Converted JSON file to CSV in SSMS
  
- Cleaned the CSV file using these functions:
   Checked duplicates using ROW_NUMBER().
   Added the column minutes as datatype varchar and Time_format as time
   Used cast function to convert column datatype to time using TRY_CONVERT()
   Utilized TRIM() to clean spaces.
   Made use of DDL and DML commands

- Adjusted the table Customer_JSON byvexporting to csv

- Answered the sql queries to get meaningful insights in POWER BI
  <h5 style="color:red;">Window function used</h5>
  CTE()
  ROW_NUMBER()
  DENSE_RANK()
  RANK()
  <h5 style="color:red;">Aggregrate function used</h5>
  SUM()
  AVG()
  COUNT()
  <h5 style="color:red;">Conditional Expression used</h5>
  CASE WHEN
  <h5 style="color:red;">To filter conditions</h5>
  WHERE
