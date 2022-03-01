*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${url}  https://auth-stag.doxa-holdings.com/login
${browser}  gc

*** Keywords ***
Launch Browser
    Open Browser    ${url}  ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait   30
    Set Selenium Implicit Wait  30

Close Browser
    Close All Browsers

Enter Username
    [Arguments]     ${username_loc}     ${username}
    Input Text  ${username_loc}     ${username}     True

Enter Password
    [Arguments]     ${password_loc}     ${password}
    Input Text  ${password_loc}     ${password}     True

Click Login Button
    [Arguments]     ${submit_loc}
    Click Button    ${submit_loc}

Click Logout Button
    [Arguments]     ${logout_loc}
    Click Element   ${logout_loc}

Verify HomePage
    Wait Until Page Contains    Dashboard