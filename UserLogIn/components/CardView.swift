//
//  CardView.swift
//  UserLogIn
//
//  Created by Assem on 10/07/2023.
//

import SwiftUI

struct CardView: View {
    var body: some View {
       
            HStack{
                MyIcon()
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .foregroundColor(.purple)
                    .opacity(0.8)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(Color("gray"))
            .cornerRadius(25)
            .padding(10)
        
    }
}
struct MyIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0.5*width, y: 0))
        path.addCurve(to: CGPoint(x: width, y: 0.5*height), control1: CGPoint(x: 0.77614*width, y: 0), control2: CGPoint(x: width, y: 0.22386*height))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0.5*width, y: height))
        path.addCurve(to: CGPoint(x: 0, y: 0.5*height), control1: CGPoint(x: 0.22386*width, y: height), control2: CGPoint(x: 0, y: 0.77614*height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        return path
    }
    
    struct CardView_Previews: PreviewProvider {
        static var previews: some View {
            CardView()
        }
    }
}
