//
//  SignInView.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//

import SwiftUI

import SwiftUI

struct SignInView: View {
    @StateObject var userModel = UserModel()
    @EnvironmentObject var authViewModel :AuthViewModel
    @State var isDisplay:Bool = true
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                VStack(spacing:12){
                    TextField("Email", text: $userModel.email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                    SecureField("Password", text: $userModel.password)
                        .padding()
                    NavigationLink("Forgot Password?", destination:ForgotPasswordView())
                    Button(action: {
                        authViewModel.HandleSignIn(user : userModel)
                    }, label: {
                        Text("Sign In")
                        .fontWeight(.bold)
                        .frame(width: 200, height: 45)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .clipShape(Capsule())
                    }).padding(.top,25)
                }
                HStack(){
                    Text("Don't have an account?")
                    NavigationLink("Sign Up", destination:SignUpView())
                }.padding(.top,20)
                Spacer()
                HStack(){
                    NavigationLink("Terms & Conditions", destination:EmptyView()).foregroundColor(.black)
                }.padding(.top,20)
            }
            .navigationTitle("Sign In")
            .navigationBarBackButtonHidden(false)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

