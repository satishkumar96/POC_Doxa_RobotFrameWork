*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${url}  https://auth-dev.doxa-holdings.com/login
${browser}  gc
${email}    xpath://input[@id='email']
${password}     xpath://input[@id='password']
${first_list_of_entities}   xpath://*[@id="root"]/div/div[2]/div[2]/div/div[2]/div/div/div[2]/div[2]/div[3]/div[2]/div/div/div[1]

*** Test Cases ***
Validate Login Page title
    Open Browser And Maximize
    title should be     Doxa Connex 2.0

Validate Email Field
    element should be visible   ${email}

Validate Password Field
    element should be visible       ${password}

do valid Login
    Clear Element Text  ${email}
    Input Text      ${email}        doxaadmin2@getnada.com
    Clear Element Text  ${password}
    Input Password      ${password}       P@ss1829
    Click Element        xpath://button[@type='submit']

click on Onboard New Entity
    Click Element   xpath://span[normalize-space()='Onboard Entity']

validate Onboard New Entity
    Wait Until Page Contains    Onboard New Entity

validate Entity Roles
    Click Element   xpath://label[@for='buyer']
    Click Element   xpath://label[@for='supplier']

click List Of Entities
    Click Element   xpath://span[normalize-space()='List of Entities']
    Alert Should Be Present

validate List Of Entities
    Wait Until Page Contains Element    ${first_list_of_entities}
    Double Click Element    ${first_list_of_entities}
    Wait Until Page Contains    Entity Details

do Logout
    Wait Until Page Contains    Dashboard
    Click Element       xpath://i[@class='fa fa-power-off']
    Close Browser
*** Keywords ***
Open Browser And Maximize
    open browser    ${url}  ${browser}
    maximize browser window
    Delete All Cookies
    set selenium implicit wait  50 seconds
    Set Browser Implicit Wait   50 seconds

Close Browser
    Close All Browsers
    Log To Console  Test Completed
