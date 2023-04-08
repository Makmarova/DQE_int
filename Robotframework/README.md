## Project location
The project can be found in repository:

https://github.com/Makmarova/DQE_int/tree/main/Robotframework

## Environment setup
```bash
pip install python-dateutil --upgrade
```

## Create virtual environment for tests execution
```bash
python -m venv .venv
.venv\Scripts\activate.bat



pip install -r requirements.txt
pip install robotframework
pip install robotframework-databaselibrary
pip install pyodbc
pip install robotframework-reportportal -ng

```
```
```
## Deploy and configure Data Quality solution
Follow [instructions] (../README.md)

## Run robot tests
```bash
robot tests\task.robot

```
# Report portal integration with Robot Framework
For the integration library [robotframework-reportportal](https://github.com/reportportal/agent-Python-RobotFramework)
is used. This is an officially supported library for RF from report portal community.

To implement the integration you will need to add `robotframework-reportportal` dependency to your RF project and 
add some commands to the script of starting your test cases.

## Test results on report portal
All results after running the robot tests\task.robot command are in log.html and report.html with detailed results of the test cases.


