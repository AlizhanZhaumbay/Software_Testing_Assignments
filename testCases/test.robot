*** Settings ***
Resource  ../resources/resources.robot

*** Test Cases ***
CONTACT_TEST
    Send Message

CART_TEST
    Add Product
    Delete Product
    Place Order