//
//  UserLogInApp.swift
//  UserLogIn
//
//  Created by Assem on 09/07/2023.
//

import SwiftUI
import GoogleSignIn
import FacebookLogin

@main
struct UserLogInApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear(){
                    ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                }
            
        }
    }
}
