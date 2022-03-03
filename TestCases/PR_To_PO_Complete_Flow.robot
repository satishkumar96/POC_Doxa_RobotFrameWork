*** Settings ***
Library  SeleniumLibrary
Library  ../customLibrary/fetchExcel.py
Library  String
Library     SikuliLibrary

Suite Setup     Login Setup
Suite Teardown      Login Teardown

*** Variables ***
${url}      https://auth-stag.doxa-holdings.com/login
${browser}   gc

*** Test Cases ***

Raise PR
    Enter Marilyn username
    Click Login Button
    Wait Until Page Contains    Dashboard   10

    Click Requisition Tab
    Click Raise Requisition Tab
    Select Type of Requisition
    Select Nature of Requisition
    Select Currency
    Enter PR Title
    Select Procuement Type
    Select Approval Route
    Enter Delivery Date
    Enter Delivery Note
    Enter Delivery Address
    Click Add Manual Button
    Enter Manual Fields
    Validate Internal Conversations
    Validate External Conversations
    Click Submit Button
    Sleep   8
    Click Logout

Approve PR
    Enter Chris username
    Click Login Button
    Wait Until Page Contains    Dashboard   10

    Click Requisition Tab
    Go to PR list
    Select first List by PR Title
    Approve Purchase Request
    Sleep   8

Conversion To PO
    Go to Purchase Requisitions To Be Converted List
    Select first List by PR Title
    Click Convert to PO
    Sleep   8

Purchase Order Details issue
    Select first Purchase Orders List
    Select first List by PR Number
    Issue Purchase Order Details
    Sleep   8

*** Keywords ***
Login Setup
    Open Browser    ${url}  ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait   30
    Set Selenium Implicit Wait  30
    Delete All Cookies

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

Click Raise Requisition Tab
    ${requisition_left_tab} =    fetchExcel.Fetch Login Excel     Locators       ${64}    ${2}
    ${raise_requisition_tab} =  fetchExcel.Fetch Login Excel     Locators       ${65}    ${2}

    Click Element   ${requisition_left_tab}
    Click Element   ${raise_requisition_tab}

Select Type of Requisition
    ${requisition_type} =  fetchExcel.Fetch Login Excel     Locators       ${9}    ${2}
    ${PR_requ_type} =      fetchExcel.Fetch Login Excel     TestData       ${2}    ${11}

    Select From List By Label   ${requisition_type}    ${PR_requ_type}

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

Enter PR Title
    ${pr_title} =  fetchExcel.Fetch Login Excel     Locators       ${66}    ${2}
    ${pr_text} =   Generate Random String      8       [LOWER][NUMBERS][UPPER]

    SeleniumLibrary.Input Text      ${pr_title}    Test${pr_text}   True
    Sleep   2
    ${getPRTitle} =   SeleniumLibrary.Get Text    ${pr_title}
    fetchExcel.Put Title        ${getPRTitle}

Select Procuement Type
    ${procurement} =    fetchExcel.Fetch Login Excel     Locators       ${13}    ${2}
    ${select_procurement} =     fetchExcel.Fetch Login Excel     TestData       ${2}    ${5}

    Click Element   ${procurement}
    Select From List By Label   ${procurement}     ${select_procurement}

Select Approval Route
    ${approval_route} =     fetchExcel.Fetch Login Excel    Locators    ${48}   ${2}
    ${select_approval_route} =  fetchExcel.Fetch Login Excel    TestData    ${2}   ${9}

    Click Element   ${approval_route}      action_chain=True
    Select From List By Label   ${approval_route}      ${select_approval_route}

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
    ${uomCode} =                fetchExcel.Fetch Login Excel    Locators    ${67}   ${2}
    ${note} =                   fetchExcel.Fetch Login Excel    Locators    ${30}   ${2}
    ${quantity} =               fetchExcel.Fetch Login Excel    Locators    ${68}   ${2}
     ${taxCode} =        fetchExcel.Fetch Login Excel    Locators    ${49}   ${2}
     ${currency} =       fetchExcel.Fetch Login Excel    Locators    ${50}   ${2}
    ${currency_opt} =   fetchExcel.Fetch Login Excel    Locators    ${51}   ${2}
    ${supplier_uid} =   fetchExcel.Fetch Login Excel    Locators    ${52}   ${2}
    ${item_unit_price} =    fetchExcel.Fetch Login Excel    Locators    ${69}   ${2}
    ${price_type} =     fetchExcel.Fetch Login Excel    Locators    ${70}   ${2}


    Click Element   ${itemcode}
    Press Keys      None    ${itemCode_text}

    Click Element   ${itemName}
    Click Element   ${itemName}
    Press Keys      None    ${itemName_text}

    Click Element   ${itemMode}
    Click Element   ${itemMode}
    Press Keys      None    ${itemMode_text}

    Click Element   ${itemSize}
    Click Element   ${itemSize}
    Press Keys      None    ${itemSize_text}
#
    Click Element   ${itemBrand}
    Click Element   ${itemBrand}
    Press Keys      None    ${itemBrand_text}

    Click Element   ${add_item_white_space}  action_chain=True
    FOR    ${i}    IN RANGE    25
            Press Keys  None    ARROW_RIGHT
    END
#
    Click Element   ${itemCategory}
    Click Element   ${dropdown_list}
    ${category} =  Create List  ${501}  ${449}  ${142}  ${18}
    Click On Region   ${category}

    Click Element   ${supplier_uid}
    ${supply_code} =  Create List  ${638}  ${405}  ${139}  ${33}
    Click On Region   ${supply_code}
    Press Keys  None    ARROW_DOWN
    Press Keys  None    ENTER

    ${uomcode} =    Create List     ${826}  ${404}  ${133}  ${35}
    Click On Region   ${uomcode}
    Sleep   2
    Click Element   ${dropdown_list}    action_chain=True
    ${uomCode_region} =  Create List  ${820}  ${454}  ${155}  ${23}
    Click On Region   ${uomCode_region}

    Click Element   ${quantity}
    Click Element   ${quantity}
    Press Keys      None    ${quantity_value}

    Click Element   ${currency}
    Click Element   ${currency}
    Click Element   ${dropdown_list}
    ${category} =  Create List  ${1222}  ${454}  ${160}  ${19}
    Click On Region   ${category}

    Click Element   ${add_item_white_space}  action_chain=True
    FOR    ${i}    IN RANGE    25
            Press Keys  None    ARROW_RIGHT
    END

    Click Element   ${item_unit_price}
    Click Element   ${item_unit_price}
    Press Keys      None    ${quantity_value}

   Click Element   ${taxCode}
   Click Element   ${taxCode}
   Click Element   ${dropdown_list}
   ${taxcode_opt} =  Create List  ${813}  ${450}  ${170}  ${28}
   Click On Region   ${taxcode_opt}

   Click Element   ${add_item_white_space}  action_chain=True
    FOR    ${i}    IN RANGE    50
            Press Keys  None    ARROW_RIGHT
    END

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

Click Submit Button
    ${submit_button} =  fetchExcel.Fetch Login Excel    Locators    ${53}   ${2}

    Click Button     ${submit_button}
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

Select first List by PR Title
    ${Requisitions_first_List} =    fetchExcel.Fetch Login Excel    Locators    ${39}   ${2}

    ${getTitle} =    fetchExcel.Get Title
    SeleniumLibrary.Input Text      xpath://input[@aria-label="Purchase Request Title Filter Input"]        ${getTitle}
    Sleep   2
    ${getPR_Number} =    SeleniumLibrary.Get Text    xpath:(//div[@col-id="prNumber"])[2]
    fetchExcel.Put Pr Number    ${getPR_Number}
    Double Click Element        ${Requisitions_first_List}

Select first List by PR Number
    ${Requisitions_first_List} =    fetchExcel.Fetch Login Excel    Locators    ${39}   ${2}

    ${get_pr_number} =  fetchExcel.Get Pr Number
    SeleniumLibrary.Input Text      xpath://input[@aria-label="Purchase Requisition No. Filter Input"]        ${get_pr_number}
    Sleep   2
    Double Click Element        ${Requisitions_first_List}
