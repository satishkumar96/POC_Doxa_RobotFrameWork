*** Settings ***
Library  SeleniumLibrary

*** Variables ***
#Username and password to be entered
${marilyn_username}     marilyn.f@getnada.com
${chris_username}       chris.p2papp@getnada.com
${password}     P@ss2022

#url and browser value
${url}      https://auth-stag.doxa-holdings.com/login
${browser}   chrome

#locators
${username_field}   xpath://input[@id='email']
${password_field}   xpath://input[@id='password']
${login_button}     xpath://button[@type='submit']
${logout_button}    xpath://i[@class='fa fa-power-off']
${Requisitions_tab}     xpath://b[normalize-space()='Requisitions']
${Pre_Purchase_Requisition_tab}     xpath://span[normalize-space()='Pre Purchase Requisition']
${Raise_Pre_Requisition_tab}        xpath://span[normalize-space()='Raise Pre-Requisition']

*** Test Cases ***
Login for Marilyn
    Open Browser and Maximize window
    marilyn login
    Wait Until Page Contains    Dashboard


#Login for Chris
#    chris login
#    Wait Until Page Contains    Dashboard

*** Keywords ***
Open Browser and Maximize window
    Open Browser    ${url}  ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait   30
    Set Selenium Implicit Wait  30

marilyn login
    Input Text  ${username_field}   ${marilyn_username}     True
    Input Password       ${password_field}      ${password}     True
    Click Button        ${login_button}

chris login
    Input Text  ${username_field}   ${chris_username}     True
    Input Password       ${password_field}      ${password}     True
    Click Button         ${login_button}

do logout
    Click Element   ${logout_button}