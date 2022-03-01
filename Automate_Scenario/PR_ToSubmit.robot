*** Settings ***
Library  SeleniumLibrary
Library  SikuliLibrary
Library     OperatingSystem

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
    SeleniumLibrary.Press Keys      None    F5
    SeleniumLibrary.Wait Until Page Contains    Dashboard
    SeleniumLibrary.Click Element   ${Requisitions_tab}
    SeleniumLibrary.Click Element   xpath:(//span[text()='Requisitions'])[1]
    SeleniumLibrary.Click Element   xpath://span[text()='PRs List']
    SeleniumLibrary.Double Click Element    xpath:(//div[@ref="eViewport"])[1]/div/div[1]

    SeleniumLibrary.Wait Until Element Is Visible   xpath://button[text()='Submit']     10seconds
    SeleniumLibrary.Wait Until Element Is Enabled   xpath://button[text()='Submit']     10seconds

    SeleniumLibrary.Click Element   name:approvalRouteUuid      action_chain=True
    SeleniumLibrary.Select From List By Label   name:approvalRouteUuid      PR approval

    SeleniumLibrary.Click Button    xpath://button[text()='Clear All']
    SeleniumLibrary.Click Element   xpath://div[text()='Please select a supplier']
    SeleniumLibrary.Wait Until Element Is Visible   xpath://ul[@role="listbox"]
    SeleniumLibrary.Click Element   xpath://li[text()='SS0001']     action_chain=True
    SeleniumLibrary.Press Keys      None   ESCAPE

    SeleniumLibrary.Scroll Element Into View    xpath://h3[text()='Conversations']
    SeleniumLibrary.Double Click Element   xpath:(//div[@class="ag-center-cols-viewport"])[1]

    FOR    ${i}    IN RANGE    50
            Press Keys  None    ARROW_RIGHT
    END

    SeleniumLibrary.Click Element    xpath:(//div[@col-id="taxCode"])[2]
    SeleniumLibrary.Click Element    xpath://*[name()='path' and contains(@d,'M4.516 7.5')]/..

    ${taxCode_Opt} =  Create List  ${1032}  ${445}  ${183}  ${21}
    SikuliLibrary.Click On Region   ${taxCode_Opt}

    SeleniumLibrary.Click Element    xpath:(//div[@class="ag-center-cols-clipper"])[1]/div/div/div/div[@col-id="sourceCurrency"]   action_chain=True
    SeleniumLibrary.Click Element    xpath:(//div[@class="ag-center-cols-clipper"])[1]/div/div/div/div[@col-id="sourceCurrency"]   action_chain=True
    SeleniumLibrary.Click Element    xpath://div[@class=" css-g1d714-ValueContainer"]   action_chain=True

    ${curr_Opt} =  Create List  ${438}  ${449}  ${168}  ${26}
    SikuliLibrary.Click On Region   ${curr_Opt}

    SeleniumLibrary.Double Click Element   xpath:(//div[@class="ag-center-cols-viewport"])[1]
    FOR    ${i}    IN RANGE    20
            Press Keys  None    ARROW_LEFT
    END

    Click Element   xpath:(//div[@col-id="supplierUuid"])[2]

    ${supply_code} =  Create List  ${638}  ${405}  ${139}  ${33}
    Click On Region   ${supply_code}
    Press Keys  None    ARROW_DOWN
    Press Keys  None    ENTER

#    Click Button    xpath://button[text()='Submit']
#    Handle Alert
#    Sleep   5
#    Click Element   xpath://li[@class='ml-2 nav-item']//a[@class='nav-link']
#    Close All Browsers

*** Keywords ***

Open Browser and Maximize window
    SeleniumLibrary.Open Browser    ${url}  ${browser}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Delete All Cookies
    SeleniumLibrary.Set Browser Implicit Wait   10
    SeleniumLibrary.Set Selenium Implicit Wait  10

marilyn login
    SeleniumLibrary.Input Text  ${username_field}   ${marilyn_username}     True
    SeleniumLibrary.Input Password       ${password_field}      ${password}     True
    SeleniumLibrary.Click Button        ${login_button}