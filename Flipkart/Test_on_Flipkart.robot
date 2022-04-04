*** Settings ***
Suite Teardown    Close All Browsers
Resource          Resources/commonKeywords.robot

*** Test Cases ***
Search and add an item to the cart
    [Documentation]    * To search and add an item to the cart
    ...    \ *Steps followed* :
    ...    * Open the Firefox browser.
    ...    * Maximize the browser window
    ...    * Go to Flipkart.com
    ...    * Login
    ...    * Search for "red shoes"
    ...    * Write a method to print PASS if the title of the page matches with “Red Shoes- Buy Products Online at Best Price in India - All \ Categories | Flipkart.com” else FAIL.
    ...    Reload the page.
    ...    * Sort by Price low to high
    ...    * Apply price filter between 1000 to 2000
    ...    * Add 3rd search result in cart
    ...    * Update the quantity to 2
    ...    * Close the Browser
    [Tags]    Functional    FlipKart    Add_To_Cart
    [Setup]    Login App
    Search for an Product    ${productName}
    Verify succssful product search
    Refresh Page
    Sort product list
    FilterProduct By Price Range    ${minPriceRange}    ${maxPriceRange}
    Select a Product and verify it
    Add an item to Cart
    Update Quantity of a product    ${noOfQuantity}
    [Teardown]    Run Keyword If Test Passed    Remove item from cart
