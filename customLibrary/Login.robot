*** Settings ***
Library  SeleniumLibrary
Library  ../customLibrary/fetchExcel.py

Suite Setup     Login Setup
Suite Teardown      Login Teardown

*** Variables ***
${url}  https://auth-stag.doxa-holdings.com/login
${browser}  gc

*** Test Cases ***
Marilyn Login
    Common Login Scenario
    Enter Marilyn username
    Click Login Button
    Wait Until Page Contains    Dashboard   10
    Click Logout

Chris Login
    Common Login Scenario
    Enter Chris username
    Click Login Button
    Wait Until Page Contains    Dashboard   10
    Click Logout

*** Keywords ***
Login Setup
    Open Browser    ${url}  ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait   30
    Set Selenium Implicit Wait  30

Login Teardown
    Close Browser

Common Login Scenario
    ${password_loc} =  fetchExcel.Fetch Login Excel     Locators       ${3}    ${2}
    ${password} =  fetchExcel.Fetch Login Excel     LoginUsername       ${2}    ${2}

    Input Text  ${password_loc}     ${password}     True

Enter Marilyn username
    ${username_loc} =  fetchExcel.Fetch Login Excel     Locators       ${2}    ${2}
    ${marilyn_username} =  fetchExcel.Fetch Login Excel     LoginUsername       ${2}    ${1}

    Input Text  ${username_loc}     ${marilyn_username}     True

Enter Chris username
    ${username_loc} =  fetchExcel.Fetch Login Excel     Locators       ${2}    ${2}
    ${chris_username} =  fetchExcel.Fetch Login Excel     LoginUsername       ${3}    ${1}

    Input Text  ${username_loc}     ${chris_username}     True

Click Login Button
    ${submit_loc} =  fetchExcel.Fetch Login Excel     Locators       ${4}    ${2}

    Click Button    ${submit_loc}

Click Logout
    ${logout_btn} =  fetchExcel.Fetch Login Excel     Locators       ${5}    ${2}

    Click Element   ${logout_btn}