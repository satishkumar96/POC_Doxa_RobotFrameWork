*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${chris_username}       chris.p2papp@getnada.com
${password}     P@ss2022

#url and browser value
${url}      https://auth-stag.doxa-holdings.com/login
${browser}   gc

#locators
${username_field}   xpath://input[@id='email']
${password_field}   xpath://input[@id='password']
${login_button}     xpath://button[@type='submit']
${Requisition_tab}  xpath://*[@id="root"]/div/div[2]/div[1]/nav/div/div/ul/div[3]
${Requisition_List}     xpath://span[text()='Requisitions']
${PR_List}  xpath://span[text()='PRs List']

*** Test Cases ***
Login for Chris
    Open Browser and Maximize window
    chris login
    Wait Until Page Contains    Dashboard   10 seconds
    Click Element   ${Requisition_tab}
    Click Element   ${Requisition_List}
    Click Element   ${PR_List}
    Double Click Element    xpath://*[@id="agGridReact"]/div/div/div[2]/div[2]/div[3]/div[2]/div/div/div[1]
    Wait Until Element Is Visible   xpath://*[@id="root"]/div/div[2]/div[2]/div/form/footer/div/div/div/button[3]
    Wait Until Element Is Enabled   xpath://*[@id="root"]/div/div[2]/div[2]/div/form/footer/div/div/div/button[3]
    Click Button    xpath://*[@id="root"]/div/div[2]/div[2]/div/form/footer/div/div/div/button[3]

*** Keywords ***
Open Browser and Maximize window
    Open Browser    ${url}  ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait   30
    Set Selenium Implicit Wait  30

chris login
    Input Text  ${username_field}   ${chris_username}     True
    Input Password       ${password_field}      ${password}     True
    Click Button         ${login_button}