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
Raise PPR
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
    Validate Internal Conversations
    Validate External Conversations
    Click PPR Raise Submit Button
    Verify PPR
    Sleep   5
    Click Logout


Approve PPR
    Enter Chris username
    Click Login Button
    Wait Until Page Contains    Dashboard   10

    Click Requisition Tab
    Click Pre Purchase Requisition Tab
    Click Purchase Pre-Requisitions List
    Select first List
    Scroll down to Audit Trail
    Click Approve Button
    Sleep   5
    Click Logout

Convert to PR
    Enter Marilyn username
    Click Login Button
    Wait Until Page Contains    Dashboard   10

    Click Requisition Tab
    Click Pre Purchase Requisition Tab
    Click Purchase Pre-Requisitions List
    Select first List
    Scroll down to Audit Trail
    Click Convert to Request
    Sleep   5
    Select first List
    Submit Purchase Request Details
    Click Logout

Approve PR
    Enter Chris username
    Click Login Button
    Wait Until Page Contains    Dashboard   10

    Click Requisition Tab
    Go to PR list
    Select first List
    Approve Purchase Request
    Sleep   5

Conversion To PO
    Go to Purchase Requisitions To Be Converted List
    Select first List
    Click Convert to PO
    Sleep   5

Purchase Order Details issue
    Select first Purchase Orders List
    Select first List
    Issue Purchase Order Details
    Sleep   5


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

    Wait Until Page Contains Element    ${submit_loc}      10
    Click Button    ${submit_loc}

Click Logout
    ${logout_btn} =    fetchExcel.Fetch Login Excel     Locators       ${5}    ${2}
    Wait Until Page Contains Element    ${logout_btn}      10

    Click Element   ${logout_btn}

Enter Marilyn username
    ${username_loc} =       fetchExcel.Fetch Login Excel     Locators       ${2}    ${2}
    ${marilyn_username} =   fetchExcel.Fetch Login Excel     TestData       ${2}    ${1}
    ${password_loc} =       fetchExcel.Fetch Login Excel     Locators       ${3}    ${2}
    ${password} =           fetchExcel.Fetch Login Excel     TestData       ${2}    ${2}

    SeleniumLibrary.Input Text  ${username_loc}     ${marilyn_username}     True
    SeleniumLibrary.Input Text  ${password_loc}     ${password}     True

Enter Chris username
    ${username_loc} =       fetchExcel.Fetch Login Excel     Locators       ${2}    ${2}
    ${chris_username} =     fetchExcel.Fetch Login Excel     TestData       ${3}    ${1}
    ${password_loc} =       fetchExcel.Fetch Login Excel     Locators       ${3}    ${2}
    ${password} =           fetchExcel.Fetch Login Excel     TestData       ${3}    ${2}

    SeleniumLibrary.Input Text  ${username_loc}     ${chris_username}     True
    SeleniumLibrary.Input Text  ${password_loc}     ${password}     True

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
    ${select_requistion} =   fetchExcel.Fetch Login Excel     TestData       ${2}    ${3}

    Click Element   ${requisition_nature}
    Select From List By Label   ${requisition_nature}    ${select_requistion}

Select Currency
    ${curr} =  fetchExcel.Fetch Login Excel     Locators       ${11}    ${2}
    ${select_curr} =    fetchExcel.Fetch Login Excel     TestData       ${2}    ${4}

    Click Element   ${curr}
    Select From List By Label   ${curr}        ${select_curr}

Enter PPR Title
    ${ppr_title} =  fetchExcel.Fetch Login Excel     Locators       ${12}    ${2}
    ${ppr_text} =   Generate Random String      8       [LOWER][NUMBERS][UPPER]

    SeleniumLibrary.Input Text      ${ppr_title}    Test${ppr_text}   True

Select Procuement Type
    ${procurement} =    fetchExcel.Fetch Login Excel     Locators       ${13}    ${2}
    ${select_procurement} =     fetchExcel.Fetch Login Excel     TestData       ${2}    ${5}

    Click Element   ${procurement}
    Select From List By Label   ${procurement}     ${select_procurement}

Select Approval Route
    ${approval_route} =     fetchExcel.Fetch Login Excel     Locators       ${14}    ${2}
    ${select_approve_route} =   fetchExcel.Fetch Login Excel     TestData       ${2}    ${6}

    Click Element   ${approval_route}
    Select From List By Label   ${approval_route}      ${select_approve_route}

Enter Delivery Date
    ${delivery_date} =  fetchExcel.Fetch Login Excel     Locators       ${15}    ${2}

    SeleniumLibrary.Input Text  ${delivery_date}    21022022

Enter Delivery Note
    ${delivery_note} =  fetchExcel.Fetch Login Excel     Locators       ${16}    ${2}
    ${note_text} =   Generate Random String      8       [LOWER][NUMBERS][UPPER]

    SeleniumLibrary.Input Text      ${delivery_note}    ${note_text}

Enter Delivery Address
    ${deliveri_address} =   fetchExcel.Fetch Login Excel     Locators       ${17}    ${2}
    ${select_delivery_address} =    fetchExcel.Fetch Login Excel     TestData       ${2}    ${7}

    Click Element   ${deliveri_address}
    Select From List By Label   ${deliveri_address}    ${select_delivery_address}

Click Add Manual Button
    ${add_manual} =     fetchExcel.Fetch Login Excel        Locators        ${18}   ${2}
    ${conversation} =   fetchExcel.Fetch Login Excel    Locators    ${19}   ${2}

    Scroll Element Into View    ${conversation}
    Wait Until Element Is Enabled   ${add_manual}
    Wait Until Element Is Visible   ${add_manual}
    Wait Until Page Contains Element    ${add_manual}
    Click Button    ${add_manual}

Enter Manual Fields
    ${itemCode_text} =	    Generate Random String  12   [LOWER][NUMBERS][UPPER]
    ${itemName_text} =	    Generate Random String  12   [LOWER][NUMBERS][UPPER]
    ${itemDesc_text} =	    Generate Random String  12   [LOWER][NUMBERS][UPPER]
    ${itemMode_text} =	    Generate Random String  12   [LOWER][NUMBERS][UPPER]
    ${itemBrand_text} =	    Generate Random String  12   [LOWER][NUMBERS][UPPER]
    ${itemSize_text} =	    Generate Random String  12   [LOWER][NUMBERS][UPPER]
    ${note_text} =	        Generate Random String  12   [LOWER][NUMBERS][UPPER]
    ${quantity_value} =     Generate Random String  2   [NUMBERS]

    ${itemcode} =               fetchExcel.Fetch Login Excel    Locators    ${20}   ${2}
    ${itemName} =               fetchExcel.Fetch Login Excel    Locators    ${21}   ${2}
    ${itemCategory} =           fetchExcel.Fetch Login Excel    Locators    ${22}   ${2}
    ${dropdown_list} =          fetchExcel.Fetch Login Excel    Locators    ${23}   ${2}
    ${itemDescription} =        fetchExcel.Fetch Login Excel    Locators    ${24}   ${2}
    ${add_item_white_space} =   fetchExcel.Fetch Login Excel    Locators    ${25}   ${2}
    ${itemMode} =               fetchExcel.Fetch Login Excel    Locators    ${26}   ${2}
    ${itemSize} =               fetchExcel.Fetch Login Excel    Locators    ${27}   ${2}
    ${itemBrand} =              fetchExcel.Fetch Login Excel    Locators    ${28}   ${2}
    ${uomCode} =                fetchExcel.Fetch Login Excel    Locators    ${29}   ${2}
    ${note} =                   fetchExcel.Fetch Login Excel    Locators    ${30}   ${2}
    ${quantity} =               fetchExcel.Fetch Login Excel    Locators    ${36}   ${2}


    Click Element   ${itemcode}
    Press Keys      None    ${itemCode_text}

    Click Element   ${itemName}
    Press Keys      None    ${itemName_text}

    Click Element   ${itemCategory}
    Click Element   ${dropdown_list}
    ${category} =  Create List  ${834}  ${499}  ${151}  ${20}
    Click On Region   ${category}

    Click Element   ${itemDescription}
    Press Keys      None    ${itemDesc_text}

    Click Element   ${add_item_white_space}  action_chain=True
    FOR    ${i}    IN RANGE    10
            Press Keys  None    ARROW_RIGHT
    END

    Click Element   ${itemMode}
    Press Keys      None    ${itemMode_text}


    Click Element   ${itemSize}
    Press Keys      None    ${itemSize_text}


    Click Element   ${itemBrand}
    Press Keys      None    ${itemBrand_text}

    Double Click Element   ${uomCode}
    Click Element   ${dropdown_list}
    ${uomCode_region} =  Create List  ${1284}  ${498}  ${110}  ${24}
    Click On Region   ${uomCode_region}

    Click Element   ${add_item_white_space}  action_chain=True
    FOR    ${i}    IN RANGE    10
            Press Keys  None    ARROW_RIGHT
    END

    Click Element   ${note}
    Press Keys      None    ${note_text}

    Click Element   ${quantity}
    Press Keys      None    ${quantity_value}

Validate Internal Conversations
    ${comment_box} =    fetchExcel.Fetch Login Excel    Locators    ${31}   ${2}
    ${send_button} =    fetchExcel.Fetch Login Excel    Locators    ${32}   ${2}
    ${comment_text} =   fetchExcel.Fetch Login Excel     TestData       ${2}    ${8}

    SeleniumLibrary.Input Text      ${comment_box}    ${comment_text}
    Click Button  ${send_button}

Validate External Conversations
    ${comment_box} =    fetchExcel.Fetch Login Excel    Locators    ${33}   ${2}
    ${send_button} =    fetchExcel.Fetch Login Excel    Locators    ${34}   ${2}
    ${comment_text} =   fetchExcel.Fetch Login Excel     TestData       ${2}    ${8}

    SeleniumLibrary.Input Text      ${comment_box}    ${comment_text}
    Click Button  ${send_button}

Click PPR Raise Submit Button
    ${submit_button} =  fetchExcel.Fetch Login Excel    Locators    ${35}   ${2}

    Click Button    ${submit_button}

Verify PPR
    ${Purchase_Pre_Requisitions_List_Header} =  fetchExcel.Fetch Login Excel    Locators    ${37}   ${2}

    Wait Until Page Contains Element    ${Purchase_Pre_Requisitions_List_Header}      10

Click Purchase Pre-Requisitions List
    ${Purchase_Pre_Requisitions_List} =     fetchExcel.Fetch Login Excel    Locators    ${38}   ${2}

    Click Element   ${Purchase_Pre_Requisitions_List}

Select first List
    ${Pre_Requisitions_first_List} =    fetchExcel.Fetch Login Excel    Locators    ${39}   ${2}

    Double Click Element        ${Pre_Requisitions_first_List}

Scroll down to Audit Trail
    ${Audit_trail} =    fetchExcel.Fetch Login Excel    Locators    ${40}   ${2}

    Scroll Element Into View    ${Audit_trail}

Click Approve Button
    ${Approve_button} =     fetchExcel.Fetch Login Excel    Locators    ${41}   ${2}

    Element Should Be Visible   ${Approve_button}
    Click Button    ${Approve_button}


Click Convert to Request
    ${convert_to_request_button} =     fetchExcel.Fetch Login Excel    Locators    ${42}   ${2}

    Element Should Be Visible   ${convert_to_request_button}
    Click Button    ${convert_to_request_button}

Submit Purchase Request Details
    ${clear_all} =  fetchExcel.Fetch Login Excel    Locators    ${43}   ${2}
    ${supplier_code} =  fetchExcel.Fetch Login Excel    Locators    ${44}   ${2}
    ${supplier_code_list_box} =     fetchExcel.Fetch Login Excel    Locators    ${45}   ${2}
    ${ss0001} =      fetchExcel.Fetch Login Excel    Locators    ${46}   ${2}
    ${submit_Btn} =     fetchExcel.Fetch Login Excel    Locators    ${47}   ${2}
    ${approval_route} =     fetchExcel.Fetch Login Excel    Locators    ${48}   ${2}
    ${select_approval_route} =  fetchExcel.Fetch Login Excel    TestData    ${2}   ${9}
    ${conversation} =   fetchExcel.Fetch Login Excel    Locators    ${19}   ${2}
    ${add_item_white_space} =   fetchExcel.Fetch Login Excel    Locators    ${25}   ${2}
    ${taxCode} =        fetchExcel.Fetch Login Excel    Locators    ${49}   ${2}
    ${dropdown_list} =          fetchExcel.Fetch Login Excel    Locators    ${23}   ${2}
    ${currency} =       fetchExcel.Fetch Login Excel    Locators    ${50}   ${2}
    ${currency_opt} =   fetchExcel.Fetch Login Excel    Locators    ${51}   ${2}
    ${supplier_uid} =   fetchExcel.Fetch Login Excel    Locators    ${52}   ${2}
    ${submit_button} =  fetchExcel.Fetch Login Excel    Locators    ${53}   ${2}

    Wait Until Element Is Visible       ${submit_Btn}       10
    Wait Until Element Is Enabled       ${submit_Btn}       10

    Click Element   ${approval_route}      action_chain=True
    Select From List By Label   ${approval_route}      ${select_approval_route}

    Click Button    ${clear_all}
    Click Element   ${supplier_code}
    Wait Until Element Is Visible   ${supplier_code_list_box}
    Click Element   ${ss0001}     action_chain=True
    Press Keys      None   ESCAPE

    Scroll Element Into View    ${conversation}
    Double Click Element        ${add_item_white_space}

    FOR    ${i}    IN RANGE    50
            Press Keys  None    ARROW_RIGHT
    END

    Click Element   ${taxCode}
    Click Element   ${dropdown_list}
    ${taxCode_Opt} =  Create List  ${1032}  ${445}  ${183}  ${21}
    SikuliLibrary.Click On Region   ${taxCode_Opt}

    Click Element   ${currency}     action_chain=True
    Click Element   ${currency}     action_chain=True
    Click Element   ${currency_opt}     action_chain=True

    ${curr_Opt} =  Create List  ${438}  ${449}  ${168}  ${26}
    SikuliLibrary.Click On Region   ${curr_Opt}

    Double Click Element        ${add_item_white_space}
    FOR    ${i}    IN RANGE    20
            Press Keys  None    ARROW_LEFT
    END

    Click Element   ${supplier_uid}

    ${supply_code} =  Create List  ${638}  ${405}  ${139}  ${33}
    Click On Region   ${supply_code}
    Press Keys  None    ARROW_DOWN
    Press Keys  None    ENTER

    Click Button     ${submit_button}
    Handle Alert
    Sleep   5

Go to PR list
    ${Requisition_left_tab} =  fetchExcel.Fetch Login Excel    Locators    ${54}   ${2}
    ${PR_list_left_tab} =      fetchExcel.Fetch Login Excel    Locators    ${55}   ${2}

    Click Element   ${Requisition_left_tab}
    Click Element   ${PR_list_left_tab}

Approve Purchase Request
    ${approve_button} =   fetchExcel.Fetch Login Excel    Locators    ${56}   ${2}

    Wait Until Element Is Visible       ${approve_button}       10
    Wait Until Element Is Enabled       ${approve_button}       10
    Click Button        ${approve_button}

Go to Purchase Requisitions To Be Converted List
    ${order_tab} =      fetchExcel.Fetch Login Excel    Locators    ${57}   ${2}
    ${Requests_Pending_Conversion} =      fetchExcel.Fetch Login Excel    Locators    ${58}   ${2}
    ${PR_to_be_Converted} =      fetchExcel.Fetch Login Excel    Locators    ${59}   ${2}

    Click Element       ${order_tab}
    Click Element       ${Requests_Pending_Conversion}
    Click Element       ${PR_to_be_Converted}

Click Convert to PO
    ${convert_to_PO_button} =   fetchExcel.Fetch Login Excel    Locators    ${60}   ${2}
    ${add_item_white_space} =   fetchExcel.Fetch Login Excel    Locators    ${25}   ${2}

    Scroll Element Into View         ${add_item_white_space}
    Double Click Element        ${add_item_white_space}
    Wait Until Element Is Visible   ${convert_to_PO_button}     10
    Element Should Be Visible       ${convert_to_PO_button}
    Click Button        ${convert_to_PO_button}

Select first Purchase Orders List
    ${order_tab} =   fetchExcel.Fetch Login Excel    Locators    ${57}   ${2}
    ${Order_List} =  fetchExcel.Fetch Login Excel    Locators    ${61}   ${2}
    ${PO_List} =   fetchExcel.Fetch Login Excel    Locators    ${62}   ${2}

    Click Element       ${order_tab}
    Click Element       ${Order_List}
    Click Element       ${PO_List}

Issue Purchase Order Details
    ${issue_button} =   fetchExcel.Fetch Login Excel    Locators    ${63}   ${2}
    ${approval_route} =     fetchExcel.Fetch Login Excel    Locators    ${48}   ${2}
    ${select_approval_route} =  fetchExcel.Fetch Login Excel    TestData    ${2}   ${10}

    Wait Until Element Is Enabled       ${issue_button}     10
    Wait Until Element Is Visible       ${issue_button}     10
    Wait Until Page Contains Element        ${issue_button}     10
    Click Element   ${approval_route}      action_chain=True
    Select From List By Label   ${approval_route}      ${select_approval_route}
    Validate Internal Conversations
    Validate External Conversations

    Click Button    ${issue_button}