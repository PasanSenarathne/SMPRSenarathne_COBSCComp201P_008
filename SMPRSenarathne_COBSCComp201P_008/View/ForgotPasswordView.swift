//
//  ForgotPasswordView.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-10.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject var userModel = UserModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        VStack{
            Form{
                Section(header: Text("Please provide your email here.")){
                    TextField("Email", text: $userModel.email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                Section(){
                    HStack{
                        Spacer()
                        Button(action: {
                            authViewModel.HandleForgotPassword(userInfo: userModel)
                        }, label: {
                            Text("Submit")
                        })
                        Spacer()
                    }
                }
                
            }
        }
        .navigationTitle("Forgot Password?")
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
