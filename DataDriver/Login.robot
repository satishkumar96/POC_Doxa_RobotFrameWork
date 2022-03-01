*** Settings ***
Library  SeleniumLibrary
Resource  LoginResources.robot
Library  DataDriver     ../DataDriver/RobotTest.xlsx    Logincredentials
Library  DataDriver     ../DataDriver/RobotTest.xlsx    Locators

Suite Setup     Launch Browser
Suite Teardown      Close Browser

Test Template  Marilyn Valid Login

*** Test Cases ***
Login as ${marilyn_username}
    Click Logout
    Chris Valid Login

*** Keywords ***
Marilyn Valid Login
    [Arguments]  ${marilyn_username}  ${password}  ${username_loc}   ${password_loc}	 ${submit_loc}
    Enter Username  ${username_loc}     ${marilyn_username}
    Enter Password  ${password_loc}     ${password}
    Click Login Button  ${submit_loc}
    Verify HomePage

Chris Valid Login
    [Arguments]  ${chris_username}  ${password}     ${username_loc}   ${password_loc}	 ${submit_loc}
    Enter Username  ${username_loc}     ${marilyn_username}
    Enter Password  ${password_loc}     ${password}
    Click Login Button  ${submit_loc}
    Verify HomePage

Click Logout
    [Arguments]  ${logout_loc}
    Click Logout Button     ${logout_loc}