import pyodbc


def create_db_connection():
    connection_string = (
        r"Driver={SQL Server};"
        r"Server=.\SQLEXPRESS;"
        r"Database=TRN;"
        r"UID=DQELogin;"
        r"PWD=DQE2023*;"
    )
    conn = pyodbc.connect(connection_string)
    cursor = conn.cursor()
    return cursor
