*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url}                                https://shopee.co.th/flash_sale?utm_campaign=-&utm_content=Vsale----&utm_medium=affiliates&utm_source=an_15244020000&utm_term=av8kzafabqhy
${browser}                            gc
${locator_thai}                       css=#modal > div.dTUwDo > div.EmoSUD > div > div.language-selection__list > div:nth-child(1) > button
${locator_user}                       name=loginKey
${locator_pw}                         name=password
${locator_login}                      css=#main > div > div.uqT7Nz > div > div > div > div:nth-child(2) > div > div.p7oxk2 > form > button
${locator_serch}                      css=#main > div > div:nth-child(3) > div:nth-child(1) > header > div.container-wrapper.header-with-search-wrapper > div > div.header-with-search__search-section > form > div > div > input
${locator_serchbtn}                   css=#main > div > div:nth-child(3) > header > div.container-wrapper.header-with-search-wrapper > div > div.header-with-search__search-section > form > button
${locator_product}                    css=#main > div > div:nth-child(3) > div > div > div > div.SEduGk > section > ul > li:nth-child(6) > a > div > div > div.xmmk\+l > div.-n8vmz > div > div
${locator_order}                      css=#main > div > div:nth-child(3) > div:nth-child(1) > div.KrtGbA > div > div.container > section.product-briefing.flex.card.vX9SYw > section.flex.flex-auto.i9t0tr > div > div:nth-child(5) > div > div > button.btn.btn-solid-primary.btn--l.YuENex
${locator_lastorderbtn}               css=#main > div > div:nth-child(3) > div > div.HYmUPs > div.N02iLl > div.yHG0SE > div.s7CqeD > button
${locator_coupon}                     css=#main > div > div:nth-child(3) > div > div > div.container > section > div.CzLyKQ.lRHCcS
${locator_couponok}                   css=#modal > div:nth-child(3) > div > div.shopee-popup__container > div > div:nth-child(1) > div > div.shopee-popup-form__footer > button.btn.btn-solid-primary.btn--s.btn--inline.tDxbKE
${locator_freeshipping}               css=#modal > div:nth-child(3) > div > div.shopee-popup__container > div > div:nth-child(1) > div > div.shopee-popup-form__main > div > div.lqe2oF.hYSKGf > div:nth-child(2) > div > div.vc_VoucherSeaTwStandardTemplate_template > div.vc_VoucherSeaTwStandardTemplate_right > div > div
${locator_usecode}                    css=#main > div > div:nth-child(3) > div > div > div.hgs7f3 > button > a
${locator_basket}                     css=#cart_drawer_target_id > svg
${locator_orderbtn}                   css=#main > div > div:nth-child(3) > div.YCrm1Y > div > div.container > section > div.WhvsrO.Kk1Mak > button.shopee-button-solid.shopee-button-solid--primary > span
${locator_changepayment}              css=#main > div > div:nth-child(3) > div > div.HYmUPs > div.N02iLl > div.aSiS8B > div > button
${locator_qrprompt}                   css=#main > div > div:nth-child(3) > div > div.HYmUPs > div.N02iLl > div.aSiS8B > div > div > div.checkout-payment-method-view__current.checkout-payment-setting > div.checkout-payment-setting__payment-methods-tab > div:nth-child(1) > span:nth-child(1) > button
                   


*** Keywords ***
Open Web Browser
    Set Selenium Speed    5s
    Open Browser    ${url}    ${browser}
    Click Element    ${locator_thai}
    Maximize Browser Window
    Wait Until Page Contains    เข้าสู่ระบบ    1s
    Input Text    ${locator_user}    username
    Input Text    ${locator_pw}    password
    Click Element    ${locator_login}

Select Product
    Wait Until Element Contains    ${locator_serch}    5s
    Input Text      ${locator_serch}    โดฟ อินเทนซ์รีแพร์ แชมพูและคอนดิชั่นเนอร์ 410 มล.
    Click Element    ${locator_serchbtn}
    Wait Until Element Contains    ${locator_product}    3s
    Click Element    ${locator_product}

Order Product
    Wait Until Page Contains    ซื้อสินค้า    3s
    Click Element    ${locator_order}      

Select a Free Delivery Coupon
    Wait Until Element Contains    ${locator_coupon}    2s
    Click Element    ${locator_coupon}
    Wait Until Page Contains    ${locator_couponok}    1s    

Checkbox Coupon
    Click Element    ${locator_freeshipping}
    Wait Until Element Contains    ${locator_usecode}    2s
    Click Element    ${locator_usecode}
    Wait Until Element Contains    ${locator_basket}    2s

No Checkbox Coupon
    Wait Until Page Does Not Contain    กรุณาใช้โค้ดผ่านแอปพลิเคชันเท่านั้น    2s

Payment-Positive
    Click Element    ${locator_basket}
    Wait Until Element Contains    ${locator_orderbtn}    2s
    Click Element    ${locator_orderbtn}
    Wait Until Element Contains    ${locator_changepayment}    2s
    Click Element    ${locator_changepayment}
    Wait Until Element Contains    ${locator_qrprompt}    2s
    Click Element    ${locator_qrprompt}   
    Click Element    ${locator_lastorderbtn}
    Wait Until Page Contains    ไม่สามารถใช้โค้ดนี้ได้    2s

  


    
    

*** Test Cases ***
TC001-Order with coupon free shipping - Positive
    Open Web Browser
    Select Product
    Order Product
    Select a Free Delivery Coupon
    Checkbox Coupon
    Payment-Positive
    Close Browser

TC002-Order with coupon free shipping - Negative
    Open Web Browser
    Select Product
    Order Product
    Select a Free Delivery Coupon
    No Checkbox Coupon
    Close Browser



