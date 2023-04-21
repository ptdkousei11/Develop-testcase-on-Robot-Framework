*** Settings ***
Documentation       Exercise 2

Library             RPA.Smartsheet
Library             SSH.py

Suite Setup         Open Connection And Log In
Suite Teardown      Close Connect


*** Variables ***
${HOST}         10.91.0.62
${USERNAME}     root
${PASSWORD}     y6U&i8o9


*** Test Cases ***
Case 2.1
    Write Cmd    telnet localhost 6669
    ${output}    Read Until The Prompt    >
    Log    ${output}

Case 2.2
    Write Cmd    act-user::root:::y6U&i8o9;
    ${output}    Read Until The Prompt    >
    Log    ${output}

Case 2.3
    Write Cmd    ADD-GWST-ALWTT::7-0-0:[CTAG]::EPR=STOP:::NP=0,NAI=0,PC_ROUTING=5.4.5;
    ${output}    Read Until The Prompt    >
    Log    ${output}

Case 2.4
    Write Cmd    VFY-GWST-ALWTT::7-0-0;
    ${output}    Read Until The Prompt    >
    Log    ${output}

Case 2.5
    Write Cmd    DLT-GWST-ALWTT::7-0-0:[CTAG];
    ${output}    Read Until The Prompt    >
    Log    ${output}


*** Keywords ***
Open Connection And Log In
    Connect    ${HOST}    ${USERNAME}    ${PASSWORD}
