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
    Click Element   xpath://*[@id="root"]/div/div[1]/div/div[2]/div[2]/ul/li[2]/a/span
    Click Element   xpath://*[@id="root"]/div/div[1]/div/div[2]/div[2]/ul/li[2]/ul/li[1]/a/span
    Double Click Element    xpath://*[@id="agGridReact"]/div/div/div[2]/div[2]/div[3]/div[2]/div/div/div[1]
    Scroll Element Into View    xpath://*[@id="root"]/div/div[2]/div[2]/div/form/div[4]/h3
    Wait Until Element Is Visible   xpath://*[@id="agGridReact"]/div/div/div[2]/div[2]/div[3]/div[2]/div/div/div/div[2]/div/button
    Element Should Be Visible   xpath://*[@id="agGridReact"]/div/div/div[2]/div[2]/div[3]/div[2]/div/div/div/div[2]/div/button
    Click Button    xpath://*[@id="agGridReact"]/div/div/div[2]/div[2]/div[3]/div[2]/div/div/div/div[2]/div/button

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