*** Settings ***
Resource  ../resources/resources_browserstack.robot
Suite Setup    Log    Starting Cross-Browser Tests
Suite Teardown    Log    Completed Cross-Browser Tests

*** Test Cases ***

# ========== CHROME BROWSER TESTS ==========
Chrome - Contact Test
    [Documentation]    Test contact form functionality on Chrome browser
    [Tags]    chrome    contact
    Send Message    Chrome

Chrome - Add Product Test
    [Documentation]    Test adding product to cart on Chrome browser
    [Tags]    chrome    cart
    Add Product    Chrome

Chrome - Delete Product Test
    [Documentation]    Test deleting product from cart on Chrome browser
    [Tags]    chrome    cart
    Delete Product    Chrome

Chrome - Place Order Test
    [Documentation]    Test placing an order on Chrome browser
    [Tags]    chrome    order
    Place Order    Chrome


# ========== FIREFOX BROWSER TESTS ==========
Firefox - Contact Test
    [Documentation]    Test contact form functionality on Firefox browser
    [Tags]    firefox    contact
    Send Message    Firefox

Firefox - Add Product Test
    [Documentation]    Test adding product to cart on Firefox browser
    [Tags]    firefox    cart
    Add Product    Firefox

Firefox - Delete Product Test
    [Documentation]    Test deleting product from cart on Firefox browser
    [Tags]    firefox    cart
    Delete Product    Firefox

Firefox - Place Order Test
    [Documentation]    Test placing an order on Firefox browser
    [Tags]    firefox    order
    Place Order    Firefox


# ========== SAFARI BROWSER TESTS ==========
Safari - Contact Test
    [Documentation]    Test contact form functionality on Safari browser
    [Tags]    safari    contact
    Send Message    Safari

Safari - Add Product Test
    [Documentation]    Test adding product to cart on Safari browser
    [Tags]    safari    cart
    Add Product    Safari

Safari - Delete Product Test
    [Documentation]    Test deleting product from cart on Safari browser
    [Tags]    safari    cart
    Delete Product    Safari

Safari - Place Order Test
    [Documentation]    Test placing an order on Safari browser
    [Tags]    safari    order
    Place Order    Safari