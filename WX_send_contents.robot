*** Settings ***
Library           Selenium2Library    run_on_failure=Nothing
Test Teardown    Close All Browsers

*** Variable ***
${trigger}    开始
${content}    xxxxx报名
${remote_url}    http://<ip_address>:4444/wd/hub

*** Test Cases ***
Run Case
    Open WX With Chrome
    :FOR  ${index}  IN RANGE  100000
    \    Prepare Env
    \    Wait Until Keyword Succeeds    3000000000    0.1    Send Content
    
*** Keywords ***
Open WX With Chrome
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    start-maximized
    Open Browser    https://wx.qq.com    chrome    remote_url=${remote_url}    desired_capabilities=${chrome_options.to_capabilities()}
    Sleep    5

Prepare Env
    Reload Page
    Run Keyword And Continue On Failure    Dismiss Alert
    Run Keyword And Continue On Failure    Click Element    //*[@id="J_NavChatScrollBody"]/div/div[2]/div
    Run Keyword And Continue On Failure    Input Text    //*[@id="editArea"]    ${content}
    
    
Send Content
    Set Selenium Speed    0
    Wait Until Page Contains    ${trigger} 
    Click Element    //*[@id="chatArea"]/div[3]/div[3]/a
    Set Selenium Speed    0.5

