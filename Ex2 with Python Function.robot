*** Settings ***
Documentation       Exercise 2

Library             SSHLibrary
Library             RPA.Smartsheet
Library             function.py

Suite Setup         Open Connection And Log In
Suite Teardown      Close Connect


*** Variables ***
${HOST}         10.91.0.62
${USERNAME}     root
${PASSWORD}     y6U&i8o9


*** Test Cases ***
Case 1
    ${output}    Read Until The Prompt    \#
    Log    ${output}
    ${output}    Write Cmd With Prompt    >    telnet localhost 6669\n
    Log    ${output}
    ${output}    Exec Cmd    pwd
    Log    ${output}


*** Keywords ***
Open Connection And Log In
    Init
    Connect    ${HOST}    ${USERNAME}    ${PASSWORD}
