//
//  AuthService.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-18.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol{
    func SignIn(email: String, password: String, completion: @escaping (Result<Void, Error>)->  Void )
}

final class AuthService : AuthServiceProtocol{
    let auth = Auth.auth();
    func SignIn(email: String, password: String, completion: @escaping (Result<Void, Error>)->  Void ){
        auth.signIn(withEmail: email, password: password){ (authResult, error) in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                    print("Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.")
                    completion(.failure(error))
                case .userDisabled:
                    print("Error: The user account has been disabled by an administrator.")
                    completion(.failure(error))
                case .wrongPassword:
                    print("Error: The password is invalid or the user does not have a password.")
                    completion(.failure(error))
                case .invalidEmail:
                    print("Error: Indicates the email address is malformed.")
                    completion(.failure(error))
                default:
                    print("Error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            else{
                completion(.success(()))
            }
        }
    }
}
