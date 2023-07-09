//
//  LogInView.swift
//  UserLogIn
//
//  Created by Assem on 09/07/2023.
//

import AuthenticationServices
import SwiftUI

struct AppleUser:Codable {
    let userID: String
    let firstName: String
    let lastName: String
    let email: String
    
    init?(credentials: ASAuthorizationAppleIDCredential){
        guard
            let firstName = credentials.fullName?.givenName,
            let lastName = credentials.fullName?.familyName,
            let email = credentials.email
        else{return nil}
        
        self.userID = credentials.user
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
                
    }
    init?(id:String, firstName:String,lastName:String,email:String){
        self.userID = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    static var sample: AppleUser = AppleUser(id: "123", firstName: "Bob", lastName: "Smoke", email: "bob@smoke")!
    
}

struct LogInView: View {
    @Binding var theUser: AppleUser
    @Binding var signedIn: Bool
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            SignInWithAppleButton(.signIn ,onRequest: configure, onCompletion: handle)
                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                .frame(height: 45)
                .padding()
//            LogInButtons()
        }
        .padding()
    }
    func configure(_ request: ASAuthorizationAppleIDRequest){
        request.requestedScopes = [ .fullName, .email]
    }
    func handle(_ authResult: Result<ASAuthorization,Error>){
        
        switch authResult{
        case .success(let auth):
            print(auth)
            switch auth.credential{
            case let appleIdCredentials as ASAuthorizationAppleIDCredential:
                if let appleUser = AppleUser(credentials: appleIdCredentials),
                   let appleUserData = try? JSONEncoder().encode(appleUser){
                    UserDefaults.standard.setValue(appleUserData, forKey: appleUser.userID)
                    print("Saved User Data", appleUser)
                    
                    theUser = appleUser
                    signedIn = true
                    
                
                }else{
                    print("missing some fields", appleIdCredentials.email, appleIdCredentials.fullName, appleIdCredentials.user)
                    
                    guard
                        let appleUserData = UserDefaults.standard.data(forKey: appleIdCredentials.user),
                        let appleUser = try? JSONDecoder().decode(AppleUser.self, from: appleUserData)
                    else{return}
                    print(appleUser)
                    theUser = appleUser
                    signedIn = true
                    
                    
                }
            default:
                print(auth.credential)
            }
        case .failure(let error):
            print(error)
        }
        
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(theUser: .constant(AppleUser.sample), signedIn: .constant(false))
    }
}
