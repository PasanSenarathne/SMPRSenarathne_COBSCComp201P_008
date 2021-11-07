//
//  SMPRSenarathne_COBSCComp201P_008App.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//

import SwiftUI

import Firebase

@main
struct SMPRSenarathne_COBSCComp201P_008App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
       
       var body: some Scene {
           WindowGroup {
               let authViewModel = AuthViewModel()
               ContentView()
                   .environmentObject(authViewModel)
           }
       }
   }

   class AppDelegate:NSObject,UIApplicationDelegate{
       func application(_ application:UIApplication,didFinishLaunchingWithOptions launchOptions:
                        [UIApplication.LaunchOptionsKey:Any]?=nil)->Bool{
           FirebaseApp.configure()
           return true
       }
}
