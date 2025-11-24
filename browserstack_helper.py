from browserstack_config import (
    BROWSERSTACK_URL,
    get_capabilities
)

def get_browser_capabilities(browser_name):
    return get_capabilities(browser_name)

def get_browserstack_url():
    return BROWSERSTACK_URL