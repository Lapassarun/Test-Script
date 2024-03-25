*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url}                                https://www.lazada.co.th/?spm=a2o42.login_signup.header.dhome.7c596108u2T5n6#?
${browser}                            gc
${locator_switchlanguage}             css=#topActionSwitchLang > span
${locator_thailang}                   css=    
${locator_login}                      css=#anonLogin > a
${locator_loginbtn}                   css=#container > div > div:nth-child(2) > form > div > div > div.mod-login-btn > button
${locator_user}                       css=#container > div > div:nth-child(2) > form > div > div > div:nth-child(2) > div > input[type=text]
${locator_pw}                         css=#container > div > div:nth-child(2) > form > div > div > div:nth-child(3) > div.mod-input.mod-input-password.mod-login-input-password.mod-input-password > input[type=password]
${locator_home}                       css=#topActionHeader > div > div.lzd-logo-bar > div > div.lzd-logo-content > a > img
${locator_basket}                     css=#topActionHeader > div > div.lzd-logo-bar > div > div.lzd-nav-cart > a > span.cart-icon
${locator_product}                    css=#item_i213320cb5 > div > div.cart-item-left > label
${locator_proceed}                    css=#rightContainer_CR > div:nth-child(2) > div.summary-section-content > div > div.checkout-order-total > button
${locator_order}                      css=#rightContainer_10010 > div.undefined.checkout-order-total > div:nth-child(2)
${locator_promptpay}                  css=#rightContainer_10010 > div.payment-card-container > div.card-list-wrapper > div.card-container.selected > div > div.card-main-content


*** Keywords ***
Open Web Browser
    Set Selenium Speed    5s
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Wait Until Page Contains   LOGIN    0.5s
    Click Element    ${locator_login}
    Input Text    ${locator_user}    username
    Input Text    ${locator_pw}    password
    Click Element    ${locator_loginbtn}
    Wait Until Page Contains    Lazada    2s
    Click Element    ${locator_home}

Select Product
    Click Element    ${locator_basket}
    Wait Until Element Contains    ${locator_product}    2s
    Click Element    ${locator_product}
    Click Element    ${locator_proceed}
    Wait Until Element Contains    ${locator_order}    2s

Select Coupon - Positive
    Wait Until Page Does Not Contain    คูปองส่วนลดค่าจัดส่ง    2s

Select Coupon - Negative
    Wait Until Page Contains    คูปองส่วนลดค่าจัดส่ง    2s
    

Payment Through Promptpay
    Click Element    ${locator_promptpay}
    Click Element    ${locator_order}



*** Test Cases ***
TC001-Order with coupon shipping - Positive
    Open Web Browser
    Select Product
    Select Coupon - Positive
    Payment Through Promptpay
    Wait Until Element Does Not Contain    ${locator_order}    1s    
    Close Browser

TC002-Order with coupon shipping - Negative
    Open Browser
    Select Product
    Payment Through Promptpay
    Select Coupon - Negative
    Close Browser
    