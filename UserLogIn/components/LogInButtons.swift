//
//  LogInButtons.swift
//  UserLogIn
//
//  Created by Assem on 09/07/2023.
//

import SwiftUI

struct LogInButtons: View {
    var body: some View {
        
       
        
        VStack(spacing: 20){
            CustomButton(title: "Sign In with Google", titleColor: .black, bgColor: Color("gray"), imgS: "ggle", isSys: false, action: {})
            CustomButton(title: "Sign In with Apple", titleColor: .white, bgColor: .black, imgS: "apple.logo", isSys: true, action: {})
            
        }
    }
}

struct LogInButtons_Previews: PreviewProvider {
    static var previews: some View {
        LogInButtons()
    }
}

struct CustomButton: View {
    var title: String
    var titleColor: Color
    var bgColor: Color
    var imgS: String
    var isSys: Bool
    var action: () -> Void
    
    var body: some View {
        Button{
            print("Clicked")
        }label: {
            HStack(spacing: 20){
                
               isSys ? Image(systemName: imgS)
                    .foregroundColor(titleColor)
                : Image(imgS)
                    .foregroundColor(titleColor)
                
                Text(title)
                    .frame(width: 160,alignment: .leading)
                    
                    
            }
            .frame(width: 240,height: 50)
        }
        .background(bgColor)
        .cornerRadius(10)
        .foregroundColor(titleColor)
//        .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(titleColor, lineWidth: 0.5)
//                )
        .fontWeight(.semibold)
    }
}

