import pytest
from connection import create_db_connection


# Table Countries: Check sum of region ids in Country table = 60
def test_sum_region_id():
    cursor = create_db_connection()
    cursor.execute('Select sum(region_id) from hr.countries')
    query_result = cursor.fetchall()

    assert query_result[0][0] == 60, "Failed: Sum of region_ids is not 60"

    cursor.close()


# Table Countries: Verify that minimum country_id is 'AR'
def test_min_country_id():
    cursor = create_db_connection()
    cursor.execute('select min (country_id) from [hr].[countries]')
    query_result = cursor.fetchall()

    assert query_result[0][0] == 'AR', "Failed: Minimum country_id is not 'AR'"

    cursor.close()


# Table Employees: Verify that there is only one employee without a manager
def test_employees_without_manager():
    cursor = create_db_connection()
    cursor.execute('select count(*) from [hr].[employees] where manager_id is null')
    query_result = cursor.fetchall()

    assert query_result[0][0] == 1, "Failed: Number of employee without a manager is not 1"

    cursor.close()


# Table Employees: Check the average salary for all employees = 8060
def test_avg_salary():
    cursor = create_db_connection()
    cursor.execute('SELECT avg(salary) as average_salary FROM hr.employees')
    query_result = cursor.fetchall()

    assert query_result[0][0] == 8060, "Failed: Average salary is not 8060"

    cursor.close()


# Table Jobs: Find out about the existence of the 'Sales' positions
def test_sales_jobs():
    cursor = create_db_connection()
    cursor.execute("SELECT * FROM hr.jobs WHERE job_title LIKE '%Sales%'")
    query_result = cursor.fetchall()

    assert query_result, "Failed: No sales jobs found"

    cursor.close()


# Table Jobs: Find out the position with maximum difference in min and max salary
def test_salary_difference():
    cursor = create_db_connection()
    cursor.execute(
        "SELECT TOP 1 job_title, min_salary, diff FROM (SELECT job_title, min_salary, "
        "(max_salary - min_salary) AS diff FROM [hr].[jobs]) AS job_diffs ORDER BY diff DESC")
    query_result = cursor.fetchone()

    job_title, min_salary, diff = query_result

    assert job_title == 'President', f"Failed: The job title with the highest salary difference is not 'President', " \
                                     f"but {job_title}"
    assert min_salary == 20000, f"Failed: The minimum salary for the job with the highest salary difference is " \
                                f"not 20000, but {min_salary}"
    assert diff == 20000, f"Failed: The salary difference for the job with the highest salary difference is " \
                          f"not 20000, but {diff}"

    cursor.close()
