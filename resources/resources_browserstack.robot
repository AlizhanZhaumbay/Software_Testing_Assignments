*** Settings ***
Library  SeleniumLibrary
Library  Collections
Variables   ./locators.py
Variables   ./testData.py

*** Variables ***
${BROWSERSTACK_USERNAME}    %{BROWSERSTACK_USERNAME}
${BROWSERSTACK_ACCESS_KEY}    %{BROWSERSTACK_ACCESS_KEY}
${BROWSERSTACK_URL}    https://${BROWSERSTACK_USERNAME}:${BROWSERSTACK_ACCESS_KEY}@hub-cloud.browserstack.com/wd/hub

&{BSTACK_COMMON}    os=Windows    osVersion=11    build=Homework 3+4
&{BSTACK_CHROME}    &{BSTACK_COMMON}    sessionName=Chrome Tests
&{BSTACK_FIREFOX}   &{BSTACK_COMMON}    sessionName=Firefox Tests
&{BSTACK_SAFARI}    os=OS X    osVersion=Ventura    build=Homework 3+4    sessionName=Safari Tests

&{CAPS_CHROME}    browserName=Chrome    browserVersion=latest    bstack:options=${BSTACK_CHROME}
&{CAPS_FIREFOX}   browserName=Firefox   browserVersion=latest    bstack:options=${BSTACK_FIREFOX}
&{CAPS_SAFARI}    browserName=Safari   browserVersion=latest    bstack:options=${BSTACK_SAFARI}

*** Keywords ***
Get Chrome Capabilities
    [Arguments]    ${test_name}
    ${caps}=    Create Dictionary
    ...    browserName=Chrome
    ...    browserVersion=latest
    ${bstack_options}=    Create Dictionary
    ...    os=Windows
    ...    osVersion=11
    ...    projectName=DemoBlaze E2E Tests
    ...    build=Chrome Build
    ...    sessionName=${test_name}
    ...    local=false
    ...    seleniumVersion=4.0.0
    ...    consoleLogs=info
    ...    networkLogs=true
    Set To Dictionary    ${caps}    bstack:options=${bstack_options}
    RETURN    ${caps}

Get Firefox Capabilities
    [Arguments]    ${test_name}
    ${caps}=    Create Dictionary
    ...    browserName=Firefox
    ...    browserVersion=latest
    ${bstack_options}=    Create Dictionary
    ...    os=Windows
    ...    osVersion=11
    ...    projectName=DemoBlaze E2E Tests
    ...    build=Firefox Build
    ...    sessionName=${test_name}
    ...    local=false
    ...    seleniumVersion=4.0.0
    ...    consoleLogs=info
    ...    networkLogs=true
    Set To Dictionary    ${caps}    bstack:options=${bstack_options}
    RETURN    ${caps}

Get Safari Capabilities
    [Arguments]    ${test_name}
    ${caps}=    Create Dictionary
    ...    browserName=Safari
    ...    browserVersion=17.0
    ${bstack_options}=    Create Dictionary
    ...    os=OS X
    ...    osVersion=Sonoma
    ...    projectName=DemoBlaze E2E Tests
    ...    build=Safari Build
    ...    sessionName=${test_name}
    ...    local=false
    ...    seleniumVersion=4.0.0
    ...    consoleLogs=info
    ...    networkLogs=true
    Set To Dictionary    ${caps}    bstack:options=${bstack_options}
    RETURN    ${caps}

Open BrowserStack Browser
    [Arguments]    ${browser_name}    ${test_name}
    IF    '${browser_name}' == 'Chrome'
        ${caps}=    Get Chrome Capabilities    ${test_name}
    ELSE IF    '${browser_name}' == 'Firefox'
        ${caps}=    Get Firefox Capabilities    ${test_name}
    ELSE IF    '${browser_name}' == 'Safari'
        ${caps}=    Get Safari Capabilities    ${test_name}
    ELSE
        Fail    Unsupported browser: ${browser_name}
    END
    Open Browser    ${baseUrl}    remote_url=${BROWSERSTACK_URL}    desired_capabilities=${caps}
    Maximize Browser Window

Send Message
    [Arguments]    ${browser_name}=Chrome
    ${test_name}=    Set Variable    ${browser_name} - Contact Test
    Open BrowserStack Browser    ${browser_name}    ${test_name}
    Wait Until Page Contains Element    ${contactButton}         error=contactButtonNotFound
    Sleep   1s
    Click Element   ${contactButton}
    Wait Until Page Contains Element     ${contactMessageField}         error=contactMessageFieldNotFound
    Sleep   1s
    Input Text    ${contactEmailField}    ${email}
    Input Text    ${contactNameField}    ${name}
    Input Text    ${contactMessageField}    ${contactMessage}
    Click Button    ${contactSubmitButton}
    Alert Should Be Present    ${contactAcceptedAlertText}    action=ACCEPT
    Close Browser

Add Product
    [Arguments]    ${browser_name}=Chrome
    ${test_name}=    Set Variable    ${browser_name} - Add Product Test
    Open BrowserStack Browser    ${browser_name}    ${test_name}
    Wait Until Page Contains Element    ${cartProduct}         error=cartNotFound
    Sleep   1s
    Click Element   ${cartProduct}
    Wait Until Page Contains Element     ${cartAddingButton}         error=cartNotFound
    Sleep   1s
    Click Element    ${cartAddingButton}
    Alert Should Be Present    ${cartAddingAcceptedAlertText}    action=ACCEPT
    Close Browser

Delete Product
    [Arguments]    ${browser_name}=Chrome
    ${test_name}=    Set Variable    ${browser_name} - Delete Product Test
    Open BrowserStack Browser    ${browser_name}    ${test_name}
    Wait Until Page Contains Element    ${cartProduct}         error=cartNotFound
    Sleep   1s
    Click Element   ${cartProduct}
    Wait Until Page Contains Element     ${cartAddingButton}         error=cartNotFound
    Sleep   1s
    Click Element    ${cartAddingButton}
    Alert Should Be Present    ${cartAddingAcceptedAlertText}    action=ACCEPT

    Wait Until Page Contains Element    ${cartButton}         error=cartNotFound
    Sleep   1s
    Click Element   ${cartButton}
    Wait Until Page Contains Element     ${cartProductDeleteButton}         error=contactMessageFieldNotFound
    Sleep    1s
    Click Element    ${cartProductDeleteButton}
    Sleep    2s
    ${text}=    Get Text    ${cartProductsTable}
    Should Be Empty    ${text}
    Close Browser

Place Order
    [Arguments]    ${browser_name}=Chrome
    ${test_name}=    Set Variable    ${browser_name} - Place Order Test
    Open BrowserStack Browser    ${browser_name}    ${test_name}
    Wait Until Page Contains Element    ${cartButton}         error=cartNotFound
    Sleep   1s
    Click Element   ${cartButton}
    Wait Until Page Contains Element     ${placeOrderButton}         error=contactMessageFieldNotFound
    Sleep   1s
    Click Element    ${placeOrderButton}
    Wait Until Page Contains Element     ${placeOrderSubmitButton}         error=contactMessageFieldNotFound
    Sleep   1s
    Input Text    ${placeOrderNameField}    ${name}
    Input Text    ${placeOrderCountryField}    ${country}
    Input Text    ${placeOrderCityField}    ${city}
    Input Text    ${placeOrderCreditCardField}    ${creditCard}
    Input Text    ${placeOrderMonthField}    ${month}
    Input Text    ${placeOrderYearField}    ${year}
    Sleep    2s
    Click Button    ${placeOrderSubmitButton}
    Wait Until Page Contains    ${placeOrderPurchaseAlertText}    timeout=10s
    Close Browser