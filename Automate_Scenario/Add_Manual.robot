*** Settings ***
Library  SeleniumLibrary
Library     String
Library     SikuliLibrary

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
Login for Marilyn
    Open Browser and Maximize window
    marilyn login
    Wait Until Page Contains    Dashboard   10

    Click Element   ${Requisitions_tab}     action_chain=True
    Click Element   ${Pre_Purchase_Requisition_tab}
    Click Element   ${Raise_Pre_Requisition_tab}

    Scroll Element Into View    xpath://*[@id="addingOfItemsComponent"]/div/div/div/div[2]/div[2]/div[3]/div[2]/div
    Wait Until Element Is Enabled   xpath://span[text()='Add Manual']/..
    Wait Until Element Is Visible   xpath://span[text()='Add Manual']/..
    Wait Until Page Contains Element    xpath://span[text()='Add Manual']/..
    Click Button    xpath://span[text()='Add Manual']/..

    ${itemCode} =	Generate Random String  12   [LOWER][NUMBERS][UPPER]
    Click Element   xpath:(//div[@class="ag-center-cols-viewport"])[1]
    Click Element   xpath:(//div[@col-id="itemCode"])[2]
    Press Keys      None    ${itemCode}

    ${itemName} =	Generate Random String  12   [LOWER][NUMBERS][UPPER]
    Click Element   xpath:(//div[@col-id="itemName"])[2]
    Press Keys      None    ${itemName}

    Click Element   xpath:(//div[@col-id="itemCategory"])[2]
    Click Element   xpath://*[name()='path' and contains(@d,'M4.516 7.5')]/..
    ${category} =  Create List  ${822}  ${582}  ${165}  ${29}
    Click On Region   ${category}

    ${itemDesc} =	Generate Random String  12   [LOWER][NUMBERS][UPPER]
    Click Element   xpath:(//div[@col-id="itemDescription"])[2]
    Press Keys      None    ${itemDesc}

    Click Element   xpath:(//div[@class="ag-center-cols-viewport"])[1]  action_chain=True
    FOR    ${i}    IN RANGE    10
            Press Keys  None    ARROW_RIGHT
    END

    ${itemMode} =	Generate Random String  12   [LOWER][NUMBERS][UPPER]
    Click Element   xpath:(//div[@col-id="itemModel"])[2]
    Press Keys      None    ${itemMode}

    ${itemSize} =	Generate Random String  12   [LOWER][NUMBERS][UPPER]
    Click Element   xpath:(//div[@col-id="itemSize"])[2]
    Press Keys      None    ${itemSize}

    ${itemBrand} =	Generate Random String  12   [LOWER][NUMBERS][UPPER]
    Click Element   xpath:(//div[@col-id="itemBrand"])[2]
    Press Keys      None    ${itemBrand}

    Double Click Element   xpath:(//div[@col-id="uomCode"])[2]
    Click Element   xpath://*[name()='path' and contains(@d,'M4.516 7.5')]/..
    ${uomCode} =  Create List  ${1270}  ${583}  ${165}  ${23}
    Click On Region   ${uomCode}

    Click Element   xpath:(//div[@col-id="quantity"])[2]

    Click Element   xpath:(//div[@class="ag-center-cols-viewport"])[1]  action_chain=True
    FOR    ${i}    IN RANGE    10
            Press Keys  None    ARROW_RIGHT
    END

    ${note} =	Generate Random String  12   [LOWER][NUMBERS][UPPER]
    Click Element   xpath:(//div[@col-id="note"])[2]
    Press Keys      None    ${note}

#    Close Browser
*** Keywords ***
Open Browser and Maximize window
    Open Browser    ${url}  ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait   30
    Set Selenium Implicit Wait  30
#    Set Selenium Speed  0.5

marilyn login
    SeleniumLibrary.Input Text  ${username_field}   ${marilyn_username}     True
    SeleniumLibrary.Input Password       ${password_field}      ${password}     True
    SeleniumLibrary.Click Button        ${login_button}