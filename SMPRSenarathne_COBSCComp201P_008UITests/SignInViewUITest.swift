//
//  SignInViewUITest.swift
//  SMPRSenarathne_COBSCComp201P_008UITests
//
//  Created by Dewmina Jayasinghe on 2021-11-24.
//

import XCTest

class SignInViewUITest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testSignInSuccess() throws {
        
        let email = "pasan@gmail.com"
        let password = "123456789"
        
        let app = XCUIApplication()
        app.launch()
        
        let bookingButton = app.tabBars["Tab Bar"].buttons["Booking"]
        bookingButton.tap()
        let emailTextField = app.textFields["Email"]
        XCTAssert(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText(email)
        
        let passTextField = app.secureTextFields["Password"]
        XCTAssert(passTextField.exists)
        passTextField.tap()
        passTextField.typeText(password)
        
        let signInButton = app.buttons["Sign In"]
        XCTAssert(signInButton.exists)
        signInButton.tap()
    }
    
    func testSignInFail() throws {
        
        let email = "pasan@gmail.com"
        let password = "123456784"
        
        let app = XCUIApplication()
        app.launch()
        
        let bookingButton = app.tabBars["Tab Bar"].buttons["Booking"]
        bookingButton.tap()
        let emailTextField = app.textFields["Email"]
        XCTAssert(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText(email)
        
        let passTextField = app.secureTextFields["Password"]
        XCTAssert(passTextField.exists)
        passTextField.tap()
        passTextField.typeText(password)
        
        let signInButton = app.buttons["Sign In"]
        XCTAssert(signInButton.exists)
        signInButton.tap()
        
        app.alerts["Error"].scrollViews.otherElements.buttons["OK"].tap()
    }
    
    func testForgotPasswordButton() throws {
        
                let app = XCUIApplication()
        app.launch()
        
        let bookingButton = app.tabBars["Tab Bar"].buttons["Booking"]
        bookingButton.tap()
        
        app.buttons["Forgot Password?"].tap()
        
        app.navigationBars["Forgot Password?"].buttons["Sign In"].tap()
                
    }
    
    func testSignUpButton() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let bookingButton = app.tabBars["Tab Bar"].buttons["Booking"]
        bookingButton.tap()
        
        app.buttons["Sign Up"].tap()
        app.navigationBars["Sign Up"].buttons["Sign In"].tap()
                
    }
    
    func testTermsAndConditionsButton() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let bookingButton = app.tabBars["Tab Bar"].buttons["Booking"]
        bookingButton.tap()
        
        app.buttons["Terms & Conditions"].tap()
        app.navigationBars["Terms & Conditions"].buttons["Sign In"].tap()
    }
}
