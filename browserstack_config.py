import os

BROWSERSTACK_USERNAME = os.getenv("BROWSERSTACK_USERNAME")
BROWSERSTACK_ACCESS_KEY = os.getenv("BROWSERSTACK_ACCESS_KEY")

BROWSERSTACK_URL = f'https://{BROWSERSTACK_USERNAME}:{BROWSERSTACK_ACCESS_KEY}@hub-cloud.browserstack.com/wd/hub'

# Browser capabilities for different browsers
def get_chrome_caps(test_name="Chrome Test"):
    return {
        'browserName': 'Chrome',
        'browserVersion': 'latest',
        'bstack:options': {
            'os': 'Windows',
            'osVersion': '11',
            'projectName': 'DemoBlaze Tests',
            'buildName': 'Chrome Build',
            'sessionName': test_name,
            'local': 'false',
            'seleniumVersion': '6.1.3',
            'consoleLogs': 'info',
            'networkLogs': 'true'
        }
    }

def get_firefox_caps(test_name="Firefox Test"):
    return {
        'browserName': 'Firefox',
        'browserVersion': 'latest',
        'bstack:options': {
            'os': 'Windows',
            'osVersion': '11',
            'projectName': 'DemoBlaze Tests',
            'buildName': 'Firefox Build',
            'sessionName': test_name,
            'local': 'false',
            'seleniumVersion': '6.1.3',
            'consoleLogs': 'info',
            'networkLogs': 'true'
        }
    }

def get_safari_caps(test_name="Safari Test"):
    return {
        'browserName': 'Safari',
        'browserVersion': '17.0',
        'bstack:options': {
            'os': 'OS X',
            'osVersion': 'Sonoma',
            'projectName': 'DemoBlaze Tests',
            'buildName': 'Safari Build',
            'sessionName': test_name,
            'local': 'false',
            'seleniumVersion': '6.1.3',
            'consoleLogs': 'info',
            'networkLogs': 'true'
        }
    }

def get_capabilities(browser, test_name="Automated Test"):
    browser = browser.lower()
    if browser == 'chrome':
        return get_chrome_caps(test_name)
    elif browser == 'firefox':
        return get_firefox_caps(test_name)
    elif browser == 'safari':
        return get_safari_caps(test_name)