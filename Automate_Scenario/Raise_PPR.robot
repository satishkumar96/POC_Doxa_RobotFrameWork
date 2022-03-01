*** Settings ***
Library  SeleniumLibrary
Library  ../customLibrary/fetchExcel.py
Library  String
Library     SikuliLibrary

Suite Setup     Login Setup
#Suite Teardown      Login Teardown

*** Variables ***
${url}      https://auth-stag.doxa-holdings.com/login
${browser}   gc

*** Test Cases ***
Marilyn Login
    Common Login Scenario
    Enter Marilyn username
    Click Login Button
    Wait Until Page Contains    Dashboard   10

    Click Requisition Tab
    Click Pre Purchase Requisition Tab
    Click Raise Pre-Requisition Tab

    Select Type of Requisition
    Select Nature of Requisition
    Select Currency
    Enter PPR Title
    Select Procuement Type
    Select Approval Route
    Enter Delivery Date
    Enter Delivery Note
    Enter Delivery Address
    Click Add Manual Button
    Enter Manual Fields


#    Add Catalogue
#    Click Button    xpath://span[normalize-space()='Add Catalogue']/..
#    Wait Until Page Contains    Catalogue Items
#    Click Element   xpath:(//div[@ref="centerContainer"])[5]/div/div/div/div[1]/div/div/div/div[2]/input
#    Click Button    xpath://button[text()='Add']
#
##    Click Element   xpath:(//div[@ref="eContainer"])[2]/div/div[5]
##    Input Text  xpath:(//div[@ref="eContainer"])[2]/div/div[5]     50
##    Click Element   xpath:(//div[@col-id="note"])[2]
##    Input Text  xpath:(//div[@col-id="note"])[2]    Just For testing
#
##    Internal Conversations comment
#    Input Text  xpath://div[@class='mb-2 row']//input[@placeholder='Please enter your comment here...']     Testing
#    Click Button    xpath:(//button[text()='Send'])[1]
#
##    Internal Conversations Attachement
#    Click Element   xpath:(//span[text()='Attachment'])[1]
#    Click Button    xpath:(//span[text()='Add New'])[1]/..
##    Choose File     xpath:(//div[@ref="centerContainer"])[2]/div/div/div/div[3]/div/input   ${CURDIR}\\Data_Files\\doxa.png
#
##   External Conversation comment
#    Input Text  xpath://div[@class='mb-4 row']//input[@placeholder='Please enter your comment here...']     Testing
#    Click Button    xpath://div[@class='mb-4 row']//button[@type='button'][normalize-space()='Send']
#
##    External Conversations Attachement
#    Click Element   xpath:(//span[text()='Attachment'])[3]
#    Click Button    xpath:(//span[text()='Add New'])[2]/..
#    Choose File     xpath:(//div[@ref="centerContainer"])[3]/div/div/div/div[3]/div/input   ${CURDIR}\\Data_Files\\doxa.png

#   Submit Button
#    Click Button    xpath://span[text()='Submit']/..

#Login for Chris
#    chris login
#    Wait Until Page Contains    Dashboard
#    do logout

*** Keywords ***
Login Setup
    Open Browser    ${url}  ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait   30
    Set Selenium Implicit Wait  30

Login Teardown
    Close Browser

Click Login Button
    ${submit_loc} =  fetchExcel.Fetch Login Excel     Locators       ${4}    ${2}

    Click Button    ${submit_loc}

Common Login Scenario
    ${password_loc} =  fetchExcel.Fetch Login Excel     Locators       ${3}    ${2}
    ${password} =  fetchExcel.Fetch Login Excel     TestData       ${2}    ${2}

    SeleniumLibrary.Input Text  ${password_loc}     ${password}     True

Enter Marilyn username
    ${username_loc} =  fetchExcel.Fetch Login Excel     Locators       ${2}    ${2}
    ${marilyn_username} =  fetchExcel.Fetch Login Excel     TestData       ${2}    ${1}

    SeleniumLibrary.Input Text  ${username_loc}     ${marilyn_username}     True

Click Requisition Tab
    ${requisition_tab} =  fetchExcel.Fetch Login Excel     Locators       ${6}    ${2}

    Click Element   ${requisition_tab}

Click Pre Purchase Requisition Tab
    ${requisition_tab} =  fetchExcel.Fetch Login Excel     Locators       ${7}    ${2}

    Click Element   ${requisition_tab}

Click Raise Pre-Requisition Tab
    ${requisition_tab} =  fetchExcel.Fetch Login Excel     Locators       ${8}    ${2}

    Click Element   ${requisition_tab}

Select Type of Requisition
    ${requisition_type} =  fetchExcel.Fetch Login Excel     Locators       ${9}    ${2}

    Select From List By Label   ${requisition_type}    Pre Purchase Requisition

Select Nature of Requisition
    ${requisition_nature} =  fetchExcel.Fetch Login Excel     Locators       ${10}    ${2}

    Click Element   ${requisition_nature}
    Select From List By Label   ${requisition_nature}    Non-Project

Select Currency
    ${curr} =  fetchExcel.Fetch Login Excel     Locators       ${11}    ${2}

    Click Element   ${curr}
    Select From List By Label   ${curr}        Singapore Dollar (+SGD)

Enter PPR Title
    ${ppr_title} =  fetchExcel.Fetch Login Excel     Locators       ${12}    ${2}
    ${ppr_text} =   Generate Random String      8       [LOWER][NUMBERS][UPPER]

    SeleniumLibrary.Input Text      ${ppr_title}    Test${ppr_text}   True

Select Procuement Type
    ${procurement} =    fetchExcel.Fetch Login Excel     Locators       ${13}    ${2}

    Click Element   ${procurement}
    Select From List By Label   ${procurement}     Goods

Select Approval Route
    ${approval_route} =     fetchExcel.Fetch Login Excel     Locators       ${14}    ${2}

    Click Element   ${approval_route}
    Select From List By Label   ${approval_route}      PPR approver

Enter Delivery Date
    ${delivery_date} =  fetchExcel.Fetch Login Excel     Locators       ${15}    ${2}

    SeleniumLibrary.Input Text  ${delivery_date}    21022022

Enter Delivery Note
    ${delivery_note} =  fetchExcel.Fetch Login Excel     Locators       ${16}    ${2}
    ${note_text} =   Generate Random String      8       [LOWER][NUMBERS][UPPER]

    SeleniumLibrary.Input Text      ${delivery_note}    ${note_text}

Enter Delivery Address
    ${deliveri_address} =   fetchExcel.Fetch Login Excel     Locators       ${17}    ${2}

    Click Element   ${deliveri_address}
    Select From List By Label   ${deliveri_address}    Jalan Besar

Click Add Manual Button
    ${add_manual} =     fetchExcel.Fetch Login Excel        Locators        ${18}   ${2}
    ${conversation} =   fetchExcel.Fetch Login Excel    Locators    ${19}   ${2}

    Scroll Element Into View    ${conversation}
    Wait Until Element Is Enabled   ${add_manual}
    Wait Until Element Is Visible   ${add_manual}
    Wait Until Page Contains Element    ${add_manual}
    Click Button    ${add_manual}

Enter Manual Fields
    ${itemCode_text} =	Generate Random String  12   [LOWER][NUMBERS][UPPER]
    ${itemName_text} =	Generate Random String  12   [LOWER][NUMBERS][UPPER]
    ${itemDesc_text} =	Generate Random String  12   [LOWER][NUMBERS][UPPER]

    ${itemcode} =       fetchExcel.Fetch Login Excel    Locators    ${20}   ${2}
    ${itemName} =       fetchExcel.Fetch Login Excel    Locators    ${21}   ${2}
    ${itemCategory} =   fetchExcel.Fetch Login Excel    Locators    ${22}   ${2}
    ${itemCategory_dropdown} =  fetchExcel.Fetch Login Excel    Locators    ${23}   ${2}
    ${itemDescription} =     fetchExcel.Fetch Login Excel    Locators    ${24}   ${2}
    ${add_item_white_space} =   fetchExcel.Fetch Login Excel    Locators    ${25}   ${2}

    Click Element   ${itemcode}
    Press Keys      None    ${itemCode_text}

    Click Element   ${itemName}
    Press Keys      None    ${itemName_text}

    Click Element   ${itemCategory}
    Click Element   ${itemCategory_dropdown}
    ${category} =  Create List  ${834}  ${499}  ${151}  ${20}
    Click On Region   ${category}


    Click Element   ${itemDescription}
    Press Keys      None    ${itemDesc_text}

    Click Element   ${add_item_white_space}  action_chain=True
    FOR    ${i}    IN RANGE    10
            Press Keys  None    ARROW_RIGHT
    END



