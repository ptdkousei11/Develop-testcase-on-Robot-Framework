*** Settings ***
Documentation       Exercise 1

Library             RPA.Smartsheet
Library             SSH.py

Suite Setup         Open Connection And Log In
Suite Teardown      Close Connect


*** Variables ***
${HOST}         10.250.175.202
${USERNAME}     cmtg
${PASSWORD}     cmtg


*** Test Cases ***
Case 1.1
    Write Cmd With Prompt    cli>    aim service-unit show DHCP
    ${output}    Read Until The Prompt    cli>
    Log    ${output}
    Should Contain    ${output}    unlocked
    Should Contain    ${output}    enabled
    Should Contain    ${output}    in-service

Case 1.2
    Write Cmd With Prompt    cli>    storage file-system show /scratch
    ${output}    Read Until The Prompt    cli>
    Log    ${output}
    Should Contain    ${output}    avail...

Case 1.3
    Write Cmd With Prompt    cli>    sosagent vca login VCA
    ${output}    Read Until The Prompt    cli>
    Log    ${output}
    Should Contain    ${output}    Cannot log in


*** Keywords ***
Open Connection And Log In
    Connect    ${HOST}    ${USERNAME}    ${PASSWORD}
