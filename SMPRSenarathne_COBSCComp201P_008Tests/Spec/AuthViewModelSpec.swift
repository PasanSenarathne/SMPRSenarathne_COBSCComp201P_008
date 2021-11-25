//
//  AuthViewModelSpec.swift
//  SMPRSenarathne_COBSCComp201P_008Tests
//
//  Created by Dewmina Jayasinghe on 2021-11-18.
//

import XCTest
@testable import SMPRSenarathne_COBSCComp201P_008

class AuthViewModelSpec: XCTestCase {
    
    var viewModel : AuthViewModel!
    var mockAuthService : MockAuthService!
    
    override func setUp() {
        mockAuthService = MockAuthService()
        viewModel = .init(authSerive: mockAuthService)
    }
    
    func testSignInWithCorrectDetails(){
        mockAuthService.signInResult = .success(())
        let user = UserModel()
        viewModel.HandleSignIn(user: user)
        XCTAssertTrue(viewModel.isSignedIn)
    }
    
    func testSignInWithInCorrectDetails(){
        mockAuthService.signInResult = .failure(NSError(domain: "", code: -1, userInfo: nil))
        let user = UserModel()
        viewModel.HandleSignIn(user: user)
        XCTAssertFalse(viewModel.isSignedIn)
    }
}
