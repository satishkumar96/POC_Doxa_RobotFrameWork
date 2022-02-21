*** Settings ***
Library  SeleniumLibrary
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
Login for Marilyn
    Open Browser and Maximize window
    marilyn login
    Wait Until Page Contains    Dashboard

    Click Element   ${Requisitions_tab}     action_chain=True
    Click Element   ${Pre_Purchase_Requisition_tab}
    Click Element   ${Raise_Pre_Requisition_tab}

#    Type of Requisition
    Select From List By Label   name:requisitionType    Pre Purchase Requisition

#    Nature of Requisition
    Click Element   name:project
    Select From List By Label   name:project    Non-Project

#    Currency
    Click Element   xpath://select[@name='currencyCode']
    Select From List By Label   xpath://select[@name='currencyCode']        Singapore Dollar (+SGD)

#    PPR Title
    Input Text  pprTitle    TEST_20220218   True

#    Procurement Type
    Click Element   xpath://select[@name='procurementType']
    Select From List By Label   xpath://select[@name='procurementType']     Goods

#    Approval Route
    Click Element   xpath://select[@name='approvalRoute']
    Select From List By Label   name:approvalRoute      PPR approver

#    Delivery Date
    Input Text  deliveryDate    21022022

#    Delivery Address
    Click Element   name:deliveryAddress
    Select From List By Label   name:deliveryAddress    Jalan Besar

#    Note
    Input Text  note    This is for Testing Purpose Only

#    Add Catalogue
    Click Button    xpath://span[normalize-space()='Add Catalogue']/..
    Wait Until Page Contains    Catalogue Items
    Click Element   xpath:(//div[@ref="centerContainer"])[5]/div/div/div/div[1]/div/div/div/div[2]/input
    Click Button    xpath://button[text()='Add']

#    Click Element   xpath:(//div[@ref="eContainer"])[2]/div/div[5]
#    Input Text  xpath:(//div[@ref="eContainer"])[2]/div/div[5]     50
#    Click Element   xpath:(//div[@col-id="note"])[2]
#    Input Text  xpath:(//div[@col-id="note"])[2]    Just For testing

#    Internal Conversations comment
    Input Text  xpath://div[@class='mb-2 row']//input[@placeholder='Please enter your comment here...']     Testing
    Click Button    xpath:(//button[text()='Send'])[1]

#    Internal Conversations Attachement
    Click Element   xpath:(//span[text()='Attachment'])[1]
    Click Button    xpath:(//span[text()='Add New'])[1]/..
    Choose File     xpath:(//div[@ref="centerContainer"])[2]/div/div/div/div[3]/div/input   ${CURDIR}\\Data_Files\\doxa.png

#   External Conversation comment
    Input Text  xpath://div[@class='mb-4 row']//input[@placeholder='Please enter your comment here...']     Testing
    Click Button    xpath://div[@class='mb-4 row']//button[@type='button'][normalize-space()='Send']

#    External Conversations Attachement
    Click Element   xpath:(//span[text()='Attachment'])[3]
    Click Button    xpath:(//span[text()='Add New'])[2]/..
    Choose File     xpath:(//div[@ref="centerContainer"])[3]/div/div/div/div[3]/div/input   ${CURDIR}\\Data_Files\\doxa.png



#   Submit Button
#    Click Button    xpath://span[text()='Submit']/..

#Login for Chris
#    chris login
#    Wait Until Page Contains    Dashboard
#    do logout

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

chris login
    Input Text  ${username_field}   ${chris_username}     True
    Input Password       ${password_field}      ${password}     True
    Click Button         ${login_button}

do logout
    Click Element   ${logout_button}