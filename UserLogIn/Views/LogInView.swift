//
//  LogInView.swift
//  UserLogIn
//
//  Created by Assem on 09/07/2023.
//

import AuthenticationServices
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct User:Codable {
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
    static var sample: User = User(id: "123", firstName: "Bob", lastName: "Smoke", email: "bob@smoke")!
    
}

struct LogInView: View {
    @Binding var theUser: User
    @Binding var signedIn: Bool
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            SignInWithAppleButton(.signIn ,onRequest: configureAppleLogIn, onCompletion: handleAppleLogIn)
                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                .frame(width:240, height: 45)
                .padding()
            //            LogInButtons()
            GoogleSignInButton(action: handleGoogleSignIn)
                .frame(width: 240,height: 45)
            
            
        }
        .padding()
    }
    
    func configureAppleLogIn(_ request: ASAuthorizationAppleIDRequest){
        request.requestedScopes = [ .fullName, .email]
    }
    func handleAppleLogIn(_ authResult: Result<ASAuthorization,Error>){
        
        switch authResult{
        case .success(let auth):
            print(auth)
            switch auth.credential{
            case let appleIdCredentials as ASAuthorizationAppleIDCredential:
                if let appleUser = User(credentials: appleIdCredentials),
                   let appleUserData = try? JSONEncoder().encode(appleUser){
                    UserDefaults.standard.setValue(appleUserData, forKey: appleUser.userID)
                    print("Saved User Data", appleUser)
                    
                    theUser = appleUser
                    signedIn = true
                    
                    
                }else{
                    print("missing some fields", appleIdCredentials.email ?? "Email Not Found", appleIdCredentials.fullName ?? "Name Not Found", appleIdCredentials.user)
                    
                    guard
                        let appleUserData = UserDefaults.standard.data(forKey: appleIdCredentials.user),
                        let appleUser = try? JSONDecoder().decode(User.self, from: appleUserData)
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
    func handleGoogleSignIn() {
        
        GIDSignIn.sharedInstance.signIn(
            withPresenting: getRootViewController()) { signInResult, error in
                guard let result = signInResult else {
                    // Inspect error
                    return
                }
                guard
                    let userID = result.user.userID,
                    let firstName = result.user.profile?.givenName,
                    let lastName = result.user.profile?.familyName,
                    let email = result.user.profile?.email
                else{
                    print("Error Retrieving Data")
                    return
                }
                print("Signed in successfully")
                let googleUser = User(id: userID, firstName: firstName, lastName: lastName, email: email)
                theUser = googleUser!
                signedIn = true
            }
        
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(theUser: .constant(User.sample), signedIn: .constant(false))
    }
}
