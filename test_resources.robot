*** Settings ***
Variables   test_config.py
Library  DatabaseLibrary
Library  Collections


*** Keywords ***
Each Suite Setup
    Connect To Database Using Custom Connection String  pyodbc  ${CONN_STR}
    Log To Console  Test Cases:

Each Suite Teardown
    Disconnect From All Databases
    Log To Console  Result: