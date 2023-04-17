*** Settings ***
Documentation       TC1
...                 - ssh to 10.250.176.6(nthuong2/Huong@123)
...                 - check if /home/nthuong2/runtest.sh exist
...                 - cat /home/nthuong2/runtest.sh and check if it has line "password=$2"
...                 - download the file to your local PC

Library             SSHLibrary
Library             RPA.Smartsheet

Suite Setup         Open Connection And Log In
Suite Teardown      Close All Connections


*** Variables ***
${HOST}         10.250.176.6
${USERNAME}     nthuong2
${PASSWORD}     Huong@123


*** Test Cases ***
Check if /home/nthuong2/runtest.sh exist
    File Should Exist    /home/nthuong2/runtest.sh

Cat /home/nthuong2/runtest.sh and check if it has line "password=$2"
    ${output}    Execute Command    cat /home/nthuong2/runtest.sh
    Should Contain    ${output}    password=$2

Download the file to your local PC
    Get File    /home/nthuong2/runtest.sh


*** Keywords ***
Open Connection And Log In
    Open Connection    ${HOST}    timeout=30
    Login    ${USERNAME}    ${PASSWORD}
