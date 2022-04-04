*** Settings ***
Library           ExtendedSelenium2Library
Library           Collections
Library           BuiltIn
Library           DateTime
Library           String
Resource          LoginKeywords.robot
Resource          SearchandSelectItemKeywords.robot
Variables         ../Data/testData.py
Variables         ../PageObjects/commonPageLocators.py

*** Keywords ***
Open url in browser
    [Arguments]    ${url}    ${browser}=firefox
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

Login App
    Open url in browser    ${url}
    Enter User Name    ${username}
    Enter User Password    ${password}
    Click Login
    Verify successful Login

Close opened browses
    Close All Browsers

Verify Page loading
    Wait Until Page Contains Element    ${ele_pageloaderIdentifer}    ${timeout}
    Wait Until Page Does Not Contain Element    ${ele_pageloaderIdentifer}    ${timeout}

Select window tab
    sleep    1
    ${title_pattern}    Set variable    ${selectedProductTitlePagePartial}
    ${current_title}    Get Title
    ${window_titles}    Get Window Titles
    Select Window    ${window_titles[0]}
    ${match_count}    Get Match Count    ${window_titles}    ${title_pattern}
    Run Keyword If    '${match_count}'=='0'    Fail    No browser tab were opened with the title matching the patter ${title_pattern}
    Run Keyword If    '${match_count}'>'1'    Fail    More than one browser tab were opened for the title matching the patter ${title_pattern}
    ${matches}    Get Matches    ${window_titles}    ${title_pattern}
    Select Window    ${matches}[0]}
    ${current_title}    Get Title
    log    ${current_title}

Refresh Page
    Reload Page
    Wait Until Page Contains Element    ${elm_productPageResults_headersIdentifier}    ${timeout}
