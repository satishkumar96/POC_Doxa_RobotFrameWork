*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}      https://demo.actitime.com/login.do
${BROWSER}      gc

*** Keywords ***
Launch Browser
    Open Browser    ${URL}  ${BROWSER}
    Maximize Browser Window
    Set Browser Implicit Wait   30
    Set Selenium Implicit Wait  30

Close Browser
    Close All Browsers

Input Username
    [Arguments]     ${username}
    Input Text      id:username     ${username}     True

Input Password
    [Arguments]     ${password}
    Input Text      name:pwd     ${password}        True

Click Login Button
    Click Link      id:loginButton

Click Logout Button
    Click Link      id:logoutLink