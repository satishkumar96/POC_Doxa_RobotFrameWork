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
${Requisitions_tab}     xpath://*[@id="root"]/div/div[2]/div[1]/nav/div/div/ul/div[2]
${Pre_Purchase_Requisition_tab}     xpath://span[text()='Pre Purchase Requisition']
${Raise_Pre_Requisition_tab}        xpath:(//span[text()='Raise Pre-Requisition'])[1]

*** Test Cases ***
lOGIN FOR MARILYN
    open browser and maximize window
    marilyn login
    Wait Until Page Contains    Dashboard

    Click Element   ${Requisitions_tab}
    Click Element   ${Pre_Purchase_Requisition_tab}
    Click Element   xpath://span[text()='Purchase Pre-Requisitions List']
    Double Click Element    xpath:(//div[@ref="eViewport"])[1]/div/div[1]
    Scroll Element Into View    xpath://p[text()='Audit Trail']
    Element Should Be Visible   xpath://button[@label="Approve"]        Approve button visible

*** Keywords ***
Open Browser and Maximize window
    Open Browser    ${url}  ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait   30
    Set Selenium Implicit Wait  30
    Set Selenium Speed	0.5 seconds

marilyn login
    Input Text  ${username_field}   ${marilyn_username}     True
    Input Password       ${password_field}      ${password}     True
    Click Button        ${login_button}