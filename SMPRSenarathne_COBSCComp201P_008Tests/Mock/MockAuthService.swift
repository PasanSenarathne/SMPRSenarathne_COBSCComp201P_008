//
//  MockAuthService.swift
//  SMPRSenarathne_COBSCComp201P_008Tests
//
//  Created by Dewmina Jayasinghe on 2021-11-18.
//

import Foundation
@testable import SMPRSenarathne_COBSCComp201P_008

final class MockAuthService : AuthServiceProtocol{
    
    var signInResult: Result<Void, Error> = .success(())
    func SignIn(email: String, password: String, completion: @escaping (Result<Void, Error>)->  Void ){
        completion(signInResult)
    }
}
