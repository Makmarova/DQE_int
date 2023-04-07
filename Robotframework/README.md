## Project location
The project can be found in repository:

git clone: https://git.epam.com/natallia_semianiuk/robottest.git
## Create virtual environment for tests execution
```bash
pip install -r requirements.txt
```
## Deploy and configure Data Quality solution
Follow [instructions](../README.md)

## Run robot tests
```bash
robot  Home_task.robot
```
# Report portal integration with Robot Framework
For the integration library [robotframework-reportportal](https://github.com/reportportal/agent-Python-RobotFramework)
is used. This is an officially supported library for RF from report portal community.

To implement the integration you will need to add `robotframework-reportportal` dependency to your RF project and 
add some commands to the script of starting your test cases.

# Report portal

All the results after execution using command from 'Run robot tests' - log.html and report.html with detailed results of test cases.


