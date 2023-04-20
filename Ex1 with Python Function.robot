*** Settings ***
Documentation       Exercise 1

Library             SSHLibrary
Library             RPA.Smartsheet
Library             function.py

Suite Setup         Open Connection And Log In
Suite Teardown      Close Connect


*** Variables ***
${HOST}         10.250.175.202
${USERNAME}     cmtg
${PASSWORD}     cmtg


*** Test Cases ***
Execute Command And Verify Output 1
    ${output}    Exec Cmd With Prompt    cli>    aim service-unit show DHCP\n
    Log    ${output}
    Should Contain    ${output}    unlocked
    Should Contain    ${output}    enabled
    Should Contain    ${output}    in-service

Execute Command And Verify Output 2
    ${output}    Exec Cmd With Prompt    cli>    storage file-system show /scratch\n
    Should Contain    ${output}    avail...

Execute Command And Verify Output 3
    ${output}    Exec Cmd With Prompt    cli>    sosagent vca login VCA\n
    Should Contain    ${output}    Cannot log in


*** Keywords ***
Open Connection And Log In
    Init
    Connect    ${HOST}    ${USERNAME}    ${PASSWORD}
