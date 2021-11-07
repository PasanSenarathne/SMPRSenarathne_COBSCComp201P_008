//
//  SignUpView.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var userModel = UserModel()
    @StateObject var memberModel = MemberModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        VStack{
                Form{
                    Section(header: Text("Personal Information")) {
                        TextField("First Name", text: $memberModel.firstName)
                        TextField("Last Name", text: $memberModel.lastName)
                        TextField("NIC", text: $memberModel.nic)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        TextField("Vehicle No", text: $memberModel.vehicleNo)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    Section(header: Text("User Credentials")){
                        TextField("Email", text: $userModel.email)
                        SecureField("Password", text: $userModel.password)
                        SecureField("Confirm Password", text: $userModel.confirmPass)
                    }
                    Section(){
                        HStack{
                            Spacer()
                        Button(action: {
                         authViewModel.HandleSignUp(member: memberModel, userInfo: userModel)
                        }, label: {
                            Text("Sign Up")
                        })
                            Spacer()
                        }
                    }
               
                }
            }
            .navigationTitle("Sign Up")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
