*** Settings ***
Variables         ../PageObjects/HomePageLocators.py
Variables         ../PageObjects/ProductPageLocators.py
Variables         ../PageObjects/searchResultsPageLocators.py
Variables         ../PageObjects/cartPageLocators.py
Resource          commonKeywords.robot

*** Keywords ***
Search for an Product
    [Arguments]    ${productName}
    Wait Until Page Contains Element    ${txt_searchIdentifier}    ${timeout}
    Input Text    ${txt_searchIdentifier}    ${productName}
    Click Element    ${btn_searchIconIdentifier}
    Wait Until Page Contains Element    ${txt_filtersPanelIdentifier}    ${timeout}
    Wait Until Element Is Visible    ${txt_filtersPanelIdentifier}    ${timeout}
    Wait Until Page Contains Element    ${elm_productPageResults_headersIdentifier}    ${timeout}

Verify succssful product search
    Wait Until Page Contains Element    ${txt_lowtohighSortIdentifier}    ${timeout}
    ${status}    Run Keyword And Return Status    Title Should Be    ${pageTitle}
    Runkeyword If    ${status}==1    log    PASS
    ...    ELSE    FAIL

Sort product list
    Wait Until Page Contains Element    ${txt_lowtohighSortIdentifier}    ${timeout}
    Click Element    ${txt_lowtohighSortIdentifier}
    Wait Until Page Contains Element    ${txt_lowtohighSortHighlightedIdentifier}    ${timeout}

FilterProduct By Price Range
    [Arguments]    ${minAmount}    ${maxAmount}
    Apply Filter    ${drp_startRangeIdentifier}    ${txt_startRangeIdentifier}    ${minAmount}    #Apply min range
    Apply Filter    ${drp_endRangeIdentifier}    ${txt_endRangeIdentifier}    ${maxAmount}    #Apply max range

Select a Product and verify it
    Wait Until Page Contains Element    ${elm_productSelectionIdentifier}    ${timeout}
    Wait Until Element Is Visible    ${elm_productSelectionIdentifier}    ${timeout}
    Mouse Over    ${elm_productSelectionIdentifier}
    Click Element    ${elm_productSelectionIdentifier}
    Select window tab
    Wait Until Page Contains Element    ${elm_productPageResults_headersIdentifier}    ${timeout}
    Wait Until Page Contains Element    ${btn_addToCartIdentifier}    ${timeout}
    Comment    Title Should Be    ${selectedProductTitlePage}

Add an item to Cart
    Wait Until Page Contains Element    ${btn_addToCartIdentifier}    ${timeout}
    Wait Until Element Is Visible    ${list_zeroSizeIdentifier}
    #Selects the shoe size
    Mouse Over    ${list_zeroSizeIdentifier}
    Mouse Down    ${list_zeroSizeIdentifier}
    Mouse Up    ${list_zeroSizeIdentifier}
    Wait Until Page Contains Element    ${ele_zeroSizeSelectedIdentifier}    ${timeout}
    Wait Until Element Is Visible    ${btn_addToCartIdentifier}    ${timeout}
    #Adding the item to cart
    Click Button    ${btn_addToCartIdentifier}
    Wait Until Page Contains Element    ${txt_mycartpageIdentifier}    ${timeout}

Update Quantity of a product
    [Arguments]    ${quantity}
    Wait Until Page Contains Element    ${txt_placeOrderIdentifier}    ${timeout}
    Wait Until Page Contains Element    ${txt_productQuantityIdentifier}    ${quantity}
    Capture Page Screenshot
    Click Button    ${btn_increaseOrderQuantity}
    Capture Page Screenshot
    Wait Until Page Contains Element    ${txt_quantityUpdateIdentifier}    ${timeout}

Remove item from Cart
    Wait Until Page Contains Element    ${txt_removeOrderIdentifier}    ${timeout}
    Click Element    ${txt_removeOrderIdentifier}
    Capture Page Screenshot
    Wait Until Page Contains Element    ${txt_removeOrderConfirmationIdentifier}    ${timeout}
    Wait Until Element Is Visible    ${txt_removeOrderConfirmationIdentifier}    ${timeout}
    Click Element    ${txt_removeOrderConfirmationIdentifier}
    Wait Until Page Contains Element    ${txt_removeOrderUpdateIdentifier}    ${timeout}
    Page Should Contain Element    ${txt_emptyCartIdentifier}

Apply Filter
    [Arguments]    ${dropDownIdentifier}    ${rangeIdentifier}    ${amount}    ${productName}=${productName}
    ${dropDownIdentifier}    Replace Variables    ${dropDownIdentifier}
    ${rangeIdentifier}    Replace Variables    ${rangeIdentifier}
    Wait Until Page Contains Element    ${dropDownIdentifier}    ${timeout}
    Click Element    ${dropDownIdentifier}
    Wait Until Element Is Visible    ${rangeIdentifier}    ${timeout}
    Wait Until Page Contains Element    ${txt_clearAllFiltersIdentifier}    ${timeout}
    ${searchFieldIdentifier}    Replace Variables    ${txt_searchValueIdentifier}
    Wait Until Page Contains Element    ${searchFieldIdentifier}    ${timeout}
