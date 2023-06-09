*** Settings ***
Documentation       Exercise 1

Library             SSHLibrary
Library             RPA.Smartsheet

Suite Setup         Open Connection And Log In
Suite Teardown      Close All Connections


*** Variables ***
${HOST}         10.250.175.202
${USERNAME}     cmtg
${PASSWORD}     cmtg


*** Test Cases ***
Execute Command And Verify Output 1
    Read Until    cli>
    Write    aim service-unit show DHCP
    ${output}    Read Until    cli>
    Log To Console    ${output}
    Should Contain    ${output}    unlocked
    Should Contain    ${output}    enabled
    Should Contain    ${output}    in-service

Execute Command And Verify Output 2
    Read Until    cli>
    Write    storage file-system show /scratch
    ${output}    Read Until    cli>
    Log To Console    ${output}
    Should Contain    ${output}    avail...

Execute Command And Verify Output 3
    Read Until    cli>
    Write    sosagent vca login VCA
    ${output}    Read Until    cli>
    Log To Console    ${output}
    Should Contain    ${output}    Cannot log in


*** Keywords ***
Open Connection And Log In
    Open Connection    ${HOST}    timeout=30
    Login    ${USERNAME}    ${PASSWORD}
