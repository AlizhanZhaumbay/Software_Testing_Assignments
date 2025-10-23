*** Settings ***
Library  SeleniumLibrary
Variables   ./locators.py
Variables   ./testData.py
*** Keywords ***

Send Message
    Open Browser    ${baseUrl}      Chrome    options=add_argument("--start-maximized")
    wait until page contains element    ${contactButton}    timeout=80      error=contactButtonNotFound
    sleep   1s
    click element   ${contactButton}
    wait until page contains element     ${contactMessageField}    timeout=80      error=contactMessageFieldNotFound
    sleep   1s
    Input text    ${contactEmailField}    ${email}
    Input text    ${contactNameField}    ${name}
    Input text    ${contactMessageField}    ${contactMessage}
    Click button    ${contactSubmitButton}
    Alert Should Be Present    ${contactAcceptedAlertText}    action=ACCEPT
    Close browser

Add Product
    Open Browser    ${baseUrl}      Chrome    options=add_argument("--start-maximized")
    wait until page contains element    ${cartProduct}    timeout=80      error=cartNotFound
    sleep   1s
    click element   ${cartProduct}
    wait until page contains element     ${cartAddingButton}    timeout=80      error=cartNotFound
    sleep   1s
    Click element    ${cartAddingButton}
    Alert Should Be Present    ${cartAddingAcceptedAlertText}    action=ACCEPT
    Close browser

Delete Product
    Open Browser    ${baseUrl}      Chrome    options=add_argument("--start-maximized")
    wait until page contains element    ${cartProduct}    timeout=80      error=cartNotFound
    sleep   1s
    click element   ${cartProduct}
    wait until page contains element     ${cartAddingButton}    timeout=80      error=cartNotFound
    sleep   1s
    Click element    ${cartAddingButton}
    Alert Should Be Present    ${cartAddingAcceptedAlertText}    action=ACCEPT

    wait until page contains element    ${cartButton}    timeout=80      error=cartNotFound
    sleep   1s
    click element   ${cartButton}
    wait until page contains element     ${cartProductDeleteButton}    timeout=80      error=contactMessageFieldNotFound
    Sleep    1s
    Click element    ${cartProductDeleteButton}
    Sleep    2s
    ${text}=    Get Text    ${cartProductsTable}
    Should Be Empty    ${text}
    Close browser

Place Order
    Open Browser    ${baseUrl}      Chrome    options=add_argument("--start-maximized")
    wait until page contains element    ${cartButton}    timeout=80      error=cartNotFound
    sleep   1s
    click element   ${cartButton}
    wait until page contains element     ${placeOrderButton}    timeout=80      error=contactMessageFieldNotFound
    sleep   1s
    Click element    ${placeOrderButton}
    wait until page contains element     ${placeOrderSubmitButton}    timeout=80      error=contactMessageFieldNotFound
    sleep   1s
    Input text    ${placeOrderNameField}    ${name}
    Input text    ${placeOrderCountryField}    ${country}
    Input text    ${placeOrderCityField}    ${city}
    Input text    ${placeOrderCreditCardField}    ${creditCard}
    Input text    ${placeOrderMonthField}    ${month}
    Input text    ${placeOrderYearField}    ${year}
    Sleep    2s
    Click button    ${placeOrderSubmitButton}
    Wait Until Page Contains    ${placeOrderPurchaseAlertText}    timeout=10s
    Close browser




