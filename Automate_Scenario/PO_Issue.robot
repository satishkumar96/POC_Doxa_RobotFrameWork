*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${chris_username}   chris.p2papp@getnada.com
${password}         P@ss2022

#url and browser value
${url}          https://auth-stag.doxa-holdings.com/login
${browser}      gc

#locators
${username_field}   xpath://input[@id='email']
${password_field}   xpath://input[@id='password']
${login_button}     xpath://button[@type='submit']

*** Test Cases ***
Login for Chris
    Open Browser and Maximize window
    chris login
    Wait Until Page Contains    Dashboard   10 seconds

    Click Element   xpath://*[@id="root"]/div/div[2]/div[1]/nav/div/div/ul/div[4]
    Click Element   xpath://*[@id="root"]/div/div[1]/div/div[2]/div[2]/ul/li[1]/a/span
    Click Element   xpath://*[@id="root"]/div/div[1]/div/div[2]/div[2]/ul/li[1]/ul/li/a/span
    Double Click Element    xpath://*[@id="agGridReact"]/div/div/div[2]/div[2]/div[3]/div[2]/div/div/div[1]

    Wait Until Element Is Visible   xpath://*[@id="root"]/div/div[2]/div[2]/div/form/footer/div/div/div/button[3]
    Wait Until Page Contains Element    xpath://*[@id="root"]/div/div[2]/div[2]/div/form/footer/div/div/div/button[3]

#    Approval Route
    Click Element   xpath://select[@name='approvalRouteUuid']
    Select From List By Label   name:approvalRouteUuid      PO approver

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