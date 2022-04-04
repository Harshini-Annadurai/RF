*** Settings ***
Variables         ../PageObjects/LoginLocators.py
Resource          commonKeywords.robot

*** Keywords ***
Enter User Name
    [Arguments]    ${username}
    Wait Until Page Contains Element    ${txt_usernameIdentifier}    ${timeout}
    Input Text    ${txt_usernameIdentifier}    ${username}

Enter User Password
    [Arguments]    ${password}
    Wait Until Page Contains Element    ${pwd_passwordIdentifier}    ${timeout}
    Input Password    ${pwd_passwordIdentifier}    ${password}

Click Login
    Click Button    ${btn_loginIdentifier}
    Wait Until Page Does Not Contain Element    ${btn_loginIdentifier}    ${timeout}

Verify successful Login
    Wait Until Page Contains Element    ${txt_myAccountProfileIdentifier}    ${timeout}
    Page Should Contain Element    ${txt_myAccountProfileIdentifier}    msg=The user login was not successful
    Wait Until Page Contains Element    ${ele_homePageHeaderIdentifier}    ${timeout}
    Page Should Contain Element    ${ele_homePageHeaderIdentifier}    msg=After successful login the headers in home page are not loaded
