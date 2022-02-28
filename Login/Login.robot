*** Settings ***
Library     SeleniumLibrary
Resource    ../Resources/resources.robot
Library     DataDriver      ../TestData/LoginTestData.xlsx

Suite Setup     Launch Browser
Suite Teardown      Close Browser

Test Template   Valid Login

*** Test Cases ***
Login using     ${username}     ${password}

*** Keywords ***
Valid Login
    [Arguments]  ${username}    ${password}
    Input Username      ${username}
    Input Password      ${password}
    Click Login Button
    Click Logout Button