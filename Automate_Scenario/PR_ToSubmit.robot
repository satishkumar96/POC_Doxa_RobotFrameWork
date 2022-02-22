*** Settings ***
Library  SeleniumLibrary

*** Variables ***
#Username and password to be entered
${marilyn_username}     marilyn.f@getnada.com
${chris_username}       chris.p2papp@getnada.com
${password}     P@ss2022

#url and browser value
${url}      https://auth-stag.doxa-holdings.com/login
${browser}   gc

#locators
${username_field}   xpath://input[@id='email']
${password_field}   xpath://input[@id='password']
${login_button}     xpath://button[@type='submit']
${logout_button}    xpath://i[@class='fa fa-power-off']
${Requisitions_tab}     xpath://*[@id="root"]/div/div[2]/div[1]/nav/div/div/ul/div[2]
${Pre_Purchase_Requisition_tab}     xpath://span[text()='Pre Purchase Requisition']
${Raise_Pre_Requisition_tab}        xpath:(//span[text()='Raise Pre-Requisition'])[1]

*** Test Cases ***
lOGIN FOR MARILYN
    open browser and maximize window
    marilyn login
    Press Keys      None    F5
    Wait Until Page Contains    Dashboard
    Click Element   ${Requisitions_tab}
    Click Element   xpath:(//span[text()='Requisitions'])[1]
    Click Element   xpath://span[text()='PRs List']
    Double Click Element    xpath:(//div[@ref="eViewport"])[1]/div/div[1]

    Wait Until Element Is Visible   xpath://button[text()='Submit']     10seconds
    Wait Until Element Is Enabled   xpath://button[text()='Submit']     10seconds

    Click Element   name:approvalRouteUuid      action_chain=True
    Select From List By Label   name:approvalRouteUuid      PR approval

    Click Button    xpath://button[text()='Clear All']
    Click Element   xpath://div[text()='Please select a supplier']
    Wait Until Element Is Visible   xpath://ul[@role="listbox"]
    Click Element   xpath://li[text()='SS0001']     action_chain=True
    Press Keys      None   ESCAPE

    Scroll Element Into View    xpath://h3[text()='Conversations']
#    Close All Browsers

*** Keywords ***
Open Browser and Maximize window
    Open Browser    ${url}  ${browser}
    Maximize Browser Window
    Delete All Cookies
    Set Browser Implicit Wait   10
    Set Selenium Implicit Wait  10

marilyn login
    Input Text  ${username_field}   ${marilyn_username}     True
    Input Password       ${password_field}      ${password}     True
    Click Button        ${login_button}