*** Settings ***
Documentation       Exercise 2

Library             SSHLibrary
Library             RPA.Smartsheet

Suite Setup         Open Connection And Log In
Suite Teardown      Close All Connections


*** Variables ***
${HOST}         10.91.0.62
${USERNAME}     root
${PASSWORD}     y6U&i8o9


*** Test Cases ***
Test
    Read Until    \#
    Write    telnet localhost 6669
    ${output}    Read Until    PTI_TL1>
    Log To Console    ${output}
    Write    act-user::root:::y6U&i8o9;
    ${output}    Read Until    PTI_TL1>
    Log To Console    ${output}
    Write    ADD-GWST-ALWTT::7-0-0:[CTAG]::EPR=STOP:::NP=0,NAI=0,PC_ROUTING=5.4.5;
    ${output}    Read Until    PTI_TL1>
    Log To Console    ${output}
    Write    VFY-GWST-ALWTT::7-0-0;
    ${output}    Read Until    PTI_TL1>
    Log To Console    ${output}
    Write    DLT-GWST-ALWTT::7-0-0:[CTAG];
    ${output}    Read Until    PTI_TL1>
    Log To Console    ${output}


*** Keywords ***
Open Connection And Log In
    Open Connection    ${HOST}    timeout=30
    Login    ${USERNAME}    ${PASSWORD}
