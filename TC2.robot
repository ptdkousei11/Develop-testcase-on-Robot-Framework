*** Settings ***
Documentation       TC2 - ssh to 10.250.176.6(nthuong2/Huong@123)
...                 - create folder /home/nthuong2/temp
...                 - put the runtest.sh to the folder
...                 - check if it put successfull
...                 - delete the folder

Library             SSHLibrary
Library             RPA.Smartsheet

Suite Setup         Open Connection And Log In
Suite Teardown      Close All Connections


*** Variables ***
${HOST}         10.250.176.6
${USERNAME}     nthuong2
${PASSWORD}     Huong@123


*** Test Cases ***
Create folder /home/nthuong2/temp
    Execute Command    mkdir /home/nthuong2/temp
    Directory Should Exist    /home/nthuong2/temp

Put the runtest.sh to the folder
    Put File    runtest.sh    /home/nthuong2/temp
    File Should Exist    /home/nthuong2/temp/runtest.sh

Delete the folder
    Execute Command    rm -r /home/nthuong2/temp
    Directory Should Not Exist    /home/nthuong2/temp


*** Keywords ***
Open Connection And Log In
    Open Connection    ${HOST}    timeout=30
    Login    ${USERNAME}    ${PASSWORD}
