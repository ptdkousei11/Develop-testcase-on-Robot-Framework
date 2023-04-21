*** Settings ***
Documentation       Multi Session in SSH

Library             RPA.Smartsheet
Library             SSH.py

Suite Setup         Open Connection And Log In
Suite Teardown      Close Connect


*** Variables ***
${HOST 1}           10.250.175.202
${USERNAME 1}       cmtg
${PASSWORD 1}       cmtg

${HOST 2}           10.250.176.6
${USERNAME 2}       nthuong2
${PASSWORD 2}       Huong@123


*** Test Cases ***
Case 1
    Write Cmd With Prompt    cli>    aim service-unit show DHCP
    ${output}    Read Until The Prompt    cli>
    Log    ${output}
    Should Contain    ${output}    unlocked
    Should Contain    ${output}    enabled
    Should Contain    ${output}    in-service

Case 2
    ${output}    File Exists    /home/nthuong2/runtest.sh
    Log To Console    ${output}


*** Keywords ***
Open Connection And Log In
    ${id}    Connect    ${HOST 1}    ${USERNAME 1}    ${PASSWORD 1}
    ${id}    Connect    ${HOST 2}    ${USERNAME 2}    ${PASSWORD 2}
