//
//  SettingsView.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//


import SwiftUI

struct SettingsView: View {
    @StateObject var settingsViewModel = SettingsViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        NavigationView{
            VStack{
                if let user = settingsViewModel.member.first{
                Form{
                    HStack{
                        Section{
                            Image(systemName: "person.circle.fill").font(.system(size: 50))
                                .foregroundColor(.gray)
                            VStack(alignment: .leading){
                                Text(user.firstName + " " + user.lastName)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    Section(header: Text("Personal Information")){
                        VStack(alignment: .leading){
                            Text("First Name")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Spacer(minLength: 10)
                            Text(user.firstName)
                                .foregroundColor(.gray)
                                .fontWeight(.semibold)
                        }
                        VStack(alignment: .leading){
                            Text("Last Name") .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Spacer(minLength: 10)
                            Text(user.lastName)
                                .foregroundColor(.gray)
                                .fontWeight(.semibold)
                        }
                        VStack(alignment: .leading){
                            Text("NIC")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Spacer(minLength: 10)
                            Text(user.nic)
                                .foregroundColor(.gray)
                                .fontWeight(.semibold)
                        }
                        VStack(alignment: .leading){
                            Text("Registration Number") .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Spacer(minLength: 10)
                            Text(user.id)
                                .foregroundColor(.gray)
                                .fontWeight(.semibold)
                        }
                        VStack(alignment: .leading){
                            Text("Vehicle Number") .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Spacer(minLength: 10)
                            Text(user.vehicleNo)
                                .foregroundColor(.gray)
                                .fontWeight(.semibold)
                        }
                    }
                    Section{
                        HStack{
                            Spacer()
                            Button(action: {authViewModel.HandelSignOut()}, label: {
                                Text("Sign Out")
                                .foregroundColor(Color.red)
                                .fontWeight(.semibold)
                            })
                            Spacer()
                        }
                    }
                }
            }
        }
            .navigationTitle("Settings")
            .onAppear() {
                self.settingsViewModel.GetUserDeatils()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
