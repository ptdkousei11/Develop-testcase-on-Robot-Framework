*** Settings ***
Documentation       TC1
...                 - ssh to 10.250.176.6(nthuong2/Huong@123)
...                 - check if /home/nthuong2/runtest.sh exist
...                 - cat /home/nthuong2/runtest.sh and check if it has line "password=$2"
...                 - download the file to your local PC

Library             RPA.Smartsheet
Library             SSH.py

Suite Setup         Open Connection And Log In
Suite Teardown      Close Connect


*** Variables ***
${HOST}         10.250.176.6
${USERNAME}     nthuong2
${PASSWORD}     Huong@123
${PATH}         D:\\ptdat-batch40\\Develop-testcase-on-Robot-Framework\\runtest.sh


*** Test Cases ***
Check if /home/nthuong2/runtest.sh exist
    ${output}    File Exists    /home/nthuong2/runtest.sh
    Log To Console    ${output}

Cat /home/nthuong2/runtest.sh and check if it has line "password=$2"
    ${output}    Exec Cmd    cat /home/nthuong2/runtest.sh
    Should Contain    ${output}    password=$2

Download the file to your local PC
    Download The File    /home/nthuong2/runtest.sh    ${PATH}


*** Keywords ***
Open Connection And Log In
    Connect    ${HOST}    ${USERNAME}    ${PASSWORD}
