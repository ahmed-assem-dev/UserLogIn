//
//  ContentView.swift
//  UserLogIn
//
//  Created by Assem on 09/07/2023.
//

import SwiftUI



struct ContentView: View {
    @State var signedIn: Bool = false
    @State var theUser: User = User.sample
    
    var body: some View {

        if(signedIn){
            Text(theUser.firstName)
            Text(theUser.lastName)
            Text(theUser.email)
            Button{
                withAnimation {
                    signedIn = false
                    theUser = User.sample
                }
                
            }label: {
                Text("Sign Out")
            }
        }else{
            LogInView(theUser: $theUser, signedIn: $signedIn)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
