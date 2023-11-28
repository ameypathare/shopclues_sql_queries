## Shopclues_SQL_Queries_Overview
$${\color{lightgreen}Overview \space Of \space Code:}$$

<li>Converted JSON file to CSV in SSMS</li> 
<br>

<li> Cleaned the CSV file using these functions:
    <ul type = "circle">
         <li>Checked duplicates using ROW_NUMBER().</li>
         <li>Added the column minutes as datatype varchar and Time_format as time</li>
         <li>Used cast function to convert column datatype to time using TRY_CONVERT()</li>
         <li>Utilized TRIM() to clean spaces.</li>
         <li>Made use of DDL and DML commands</li>
   </ul>
</li> 
<br>

<li>Adjusted the table Customer_JSON byvexporting to csv</li> 
<br>

<li>Answered the sql queries to get meaningful insights in POWER BI</li> 
    <ul type = "circle">
    ${\color{red}Window \space function \space used:}$
     <li>CTE()</li>
     <li>ROW_NUMBER()</li>
     <li>DENSE_RANK()</li>
     <li>RANK()</li>
    </ul>
  <br>
  
   <ul type = "circle">
 ${\color{red}Aggregrate \space function \space used}$
   <li>SUM()</li>
   <li>AVG()</li>
   <li>COUNT()</li>
   </ul>
<br>

   <ul type = "circle">
  ${\color{red}Conditional \space Expression \space used}$
   <li>CASE WHEN</li>
   </ul>
  <br>
  
  <ul type = "circle">
  ${\color{red}To \space filter \space conditions}$
   <li>WHERE</li>
  </ul>
