*** Settings ***
#Suite Setup       Connect To Database Using Custom Params    pyodbc   ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}    Driver=${dbDriver}
Suite Setup       Connect To Database Using Custom Params    pyodbc  Driver='SQL Server', Server='EPPLWARW0047\\SQLEXPRESS', Database='TRN', Trusted_Connection='yes', UID='DQELogin', PWD='DQE2023*'
Suite Teardown    Disconnect From Database
Library           DatabaseLibrary
Library           OperatingSystem
Library           Collections


*** Variables ***
${DBHost}         EPPLWARW0047\\SQLEXPRESS
${DBName}         TRN
${DBPass}         DQE2023*
${DBPort}         1434
${DBUser}         DQELogin
${dbDriver}       SQL Server


*** Test Cases ***


Table Countries. Check sum of region ids in Country table
    [Tags]    test_1.Country
    [Documentation]
    ...   Check region_ids sum in Country table
    ...
    ...    Expected results:
    ...    The result should be ('70')
    ${output} =    Query    select sum(region_id) from [hr].[countries];
    Log    ${output}
    Should Be Equal As Strings    ${output}    [(60, )]

Table Countries. Verify that minimum country_id is 'AR'
    [Tags]    test_2.Country
    [Documentation]
    ...  Check the minimum country_id
    ...
    ...  Expected results:
    ...  AR is a mininum country_id
    ${output} =    Query    select min (country_id) from [hr].[countries];
    Log    ${output}
    Should Be Equal As Strings    ${output}    [('AR', )]


Table Employees. Verify that there is only one employee without manager
    [Tags]    test_3.Employees
    [Documentation]
    ...  Check number of employees without manager
    ...
    ...  Expected results:
    ...  Count of employees without manager is 1
    Row Count Is Equal To X    select count(*) from [hr].[employees] where manager_id is null;    1


Table Employees. Check the average salary for all employees
    [Tags]  test_4.Employees
    [Documentation]
    ...  Execute the sql quiery
    ...
    ...  Expected result:
    ...  Average value of salary for all employees should be 8060
    @{AverageResult}  Query   SELECT avg(salary) as average_salary FROM [hr].[employees];
    Log  @{AverageResult}
    Should Be Equal As Strings  @{AverageResult}    (Decimal('8060.000000'), )


Table Jobs. Find out about the existence of the 'Sales' positions
    [Tags]  test_5.Jobs
    [Documentation]
    ...  Check that the job_title related to 'Sales' exists in the jobs table
    ...
    ...  Expected results:
    ...  Sales jobs exist in the table
    ...  If there are no results, then this will throw an AssertionError.
    Check if exists in Database  select * from hr.jobs where job_title like'%Sales%';


Table Jobs. Find out the position with maximum difference in min and max salary
    [Tags]  test_6.Jobs
    [Documentation]
    ...  Find the position with maximum salary range
    ...
    ...  Expected result:
    ...  The result should be title - 'President', min salary - 20000.00, difference -20000.00
    @{queryResults}=  query  SELECT TOP 1 job_title, min_salary, diff FROM (SELECT job_title, min_salary, (max_salary - min_salary) AS diff FROM [hr].[jobs]) AS job_diffs ORDER BY diff DESC;
    Log    @{queryResults}
    Should Be Equal As Strings  @{queryResults}    ('President', Decimal('20000.00'), Decimal('20000.00'))

Table Departments. Verify if the table exist
    [Tags]    test_7.Departments
    [Documentation]
    ...  Connect to DB
    ...  Check if the table departments exists
    ...
    ...    Expected results:
    ...    Table exists in DB
    Table Must Exist    departments


