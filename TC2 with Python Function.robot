*** Settings ***
Documentation       TC2 - ssh to 10.250.176.6(nthuong2/Huong@123)
...                 - create folder /home/nthuong2/temp
...                 - put the runtest.sh to the folder
...                 - check if it put successfull
...                 - delete the folder

Library             SSHLibrary
Library             RPA.Smartsheet
Library             function.py

Suite Setup         Open Connection And Log In
Suite Teardown      Close Connect


*** Variables ***
${HOST}         10.250.176.6
${USERNAME}     nthuong2
${PASSWORD}     Huong@123


*** Test Cases ***
Create folder /home/nthuong2/temp
    Create Folder    /home/nthuong2/temp
    ${output}    Directory Exists    /home/nthuong2/temp
    Log To Console    ${output}

Put the runtest.sh to the folder
    Put The File    runtest.sh    /home/nthuong2/temp/runtest.sh
    ${output}    File Exists    /home/nthuong2/temp/runtest.sh
    Log To Console    ${output}

Delete the folder
    Exec Cmd    rm -r /home/nthuong2/temp
    ${output}    Directory Exists    /home/nthuong2/temp
    Log To Console    ${output}


*** Keywords ***
Open Connection And Log In
    Init
    Connect    ${HOST}    ${USERNAME}    ${PASSWORD}
