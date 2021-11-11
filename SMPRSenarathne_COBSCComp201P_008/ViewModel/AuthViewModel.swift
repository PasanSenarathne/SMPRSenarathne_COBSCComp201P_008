//
//  AuthViewModel.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel : ObservableObject{
    
    let auth = Auth.auth()
    var db = Firestore.firestore()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool{
           return auth.currentUser != nil
       }
    
    func HandleSignIn(user : UserModel){
        auth.signIn(withEmail: user.email, password: user.password){ (authResult, error) in
            if let error = error as NSError? {
              switch AuthErrorCode(rawValue: error.code) {
                  case .operationNotAllowed:
                    print("Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.")
                  case .userDisabled:
                    print("Error: The user account has been disabled by an administrator.")
                  case .wrongPassword:
                    print("Error: The password is invalid or the user does not have a password.")
                  case .invalidEmail:
                    print("Error: Indicates the email address is malformed.")
                  default:
                      print("Error: \(error.localizedDescription)")
                  }
            }
            else {
                DispatchQueue.main.async {
                    print("User signs in successfully")
                    self.signedIn = true
                }
            }
        }
    }
    
    func HandleSignUp(member: MemberModel, userInfo:UserModel){
    Auth.auth().createUser(withEmail: userInfo.email, password: userInfo.password){ (authResult, error) in
            if let error = error as NSError? {
              switch AuthErrorCode(rawValue: error.code) {
                  case .operationNotAllowed:
                    print("Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.")
                  case .emailAlreadyInUse:
                    print("Error: Email Address already used.")
                  case .weakPassword:
                    print("Error: The password is week.")
                  default:
                      print("Error: \(error.localizedDescription)")
                  }
            } else {
                let user = Auth.auth().currentUser
                if let user = user {
                    member.userID = user.uid
                    let object :[String: Any] = [
                        "UserID" : member.userID,
                        "FirstName" : member.firstName,
                        "LastName" : member.lastName,
                        "NIC" : member.nic,
                        "VehicleNo" : member.vehicleNo ]
                    var ref: DocumentReference? = nil
                    ref = self.db.collection("Members").addDocument(data: object){ err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                            DispatchQueue.main.async {
                                print("User signs up successfully")
                                self.signedIn = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    func HandelSignOut(){
        try? auth.signOut()
        self.signedIn = false
    }
    
    func HandleForgotPassword(userInfo: UserModel){
        auth.sendPasswordReset(withEmail: userInfo.email){(error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                }
                else{
                    print("Password reset link successfully sent ")
                    self.signedIn = false
                }
            }
            
        }
    }
}

