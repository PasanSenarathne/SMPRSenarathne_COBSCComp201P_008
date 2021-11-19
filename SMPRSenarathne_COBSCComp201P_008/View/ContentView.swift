//
//  ContentView.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            
            if authViewModel.signedIn{
                BookingView()
                    .onAppear{
                        authViewModel.signedIn = authViewModel.isSignedIn
                    }
                    .tabItem{
                        Image(systemName: "calendar.badge.plus")
                        Text("Booking")
                    }
            }
            
            else{
                SignInView()
                    .onAppear{
                        authViewModel.signedIn = authViewModel.isSignedIn
                    }
                    .tabItem{
                        Image(systemName: "calendar.badge.plus")
                        Text("Booking")
                    }
            }
            if authViewModel.signedIn{
                SettingsView()
                    .onAppear{
                        authViewModel.signedIn = authViewModel.isSignedIn
                    }
                    .tabItem{
                        Image(systemName: "gear")
                        Text("Settigs")
                    }
            }
            else{
                SignInView()
                    .onAppear{
                        authViewModel.signedIn = authViewModel.isSignedIn
                    }
                    .tabItem{
                        Image(systemName: "gear")
                        Text("Settigs")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
