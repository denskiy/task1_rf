*** Settings ***
Documentation     Test suite performs essential data quality checks across various tables
...               in the HR schema of the TRN database. It validates integrity, correctness, 
...               and constraints of the data related to countries, employees, and dependents.
Resource  test_resources.robot
Suite Setup  Each Suite Setup
Suite Teardown  Each Suite Teardown


*** Test Cases ***
Country Row Count
    [Tags]  countries
    ${country_count}=    Query  SELECT COUNT(*) FROM hr.countries
    Should Be Equal As Integers    ${country_count[0][0]}    25    msg=The number of countries should be 25.

Duplicated Country Names
    [Tags]  countries
    ${duplicates}=    Query   SELECT country_name, COUNT(*) AS count FROM hr.countries GROUP BY country_name HAVING COUNT(*) > 1
    Should Be Empty    ${duplicates}    msg=There should be no duplicate country names.

Average Employee Salary
    [Tags]  employees
    ${avg_salary}=    Query   SELECT AVG(salary) FROM hr.employees
    Should Be True    ${avg_salary[0][0]} > 0    msg=Average salary should be greater than zero.

Employee Email Uniqueness
    [Tags]  employees
    ${duplicate_emails}=    Query    SELECT email, COUNT(*) AS count FROM hr.employees GROUP BY email HAVING COUNT(*) > 1
    Should Be Empty    ${duplicate_emails}    msg=Employee emails should be unique.    
   
Non-Null Dependent Names
    [Tags]  dependents
    ${null_names}=    Query   SELECT dependent_id FROM hr.dependents WHERE first_name IS NULL OR last_name IS NULL
    Should Be Empty    ${null_names}   msg=There should be no NULL in first or last names of dependents.

Dependent Relationship Length
    [Tags]  dependents
    ${relationship_length}=    Query   SELECT dependent_id FROM hr.dependents WHERE LEN(relationship) > 25
    Should Be Empty    ${relationship_length}   msg=Lenght of 'relationship' column should not exceed 25 characters.    