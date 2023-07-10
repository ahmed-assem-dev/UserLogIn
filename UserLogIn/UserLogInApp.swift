//
//  UserLogInApp.swift
//  UserLogIn
//
//  Created by Assem on 09/07/2023.
//

import SwiftUI
import GoogleSignIn

@main
struct UserLogInApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
