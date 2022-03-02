//
//  FirstScreen.swift
//  FamilyKeeper Parent SwiftUI
//
//  Created by Leo Chernyak on 09.08.2021.
//

import SwiftUI

struct FirstScreen: View {
    @State var goToVerification =  false
    @State var isLogin = false
    
    init() {
        UserDefaults.standard.setValue(0, forKey: "Subscription")
    }
    
    var body: some View {
        NavigationView{
        VStack {
            
            NavigationLink(destination: PhoneVerificationScreen(isLogin: isLogin), isActive: $goToVerification)
                { EmptyView() }
            
            Spacer()
            Image("logoShade")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.leading, 30)
                .padding(.trailing,30)
            Text("FamilyKeeper")
                .font(Font.custom("MontserratAlternates-Medium", size: 30))
                .foregroundColor(Color("DarkGray"))
            Text("I am my child`s keeper")
                .font(Font.custom("Montserrat-Regular", size: 17))
                .foregroundColor(Color("DarkGray"))
            Spacer()
            Text("Welcome to the FamilyKeeper Parents App")
                .font(Font.custom("Montserrat-Bold", size: 12))
                .foregroundColor(Color("DarkGray"))
            Button(action: {
                withAnimation(.default) {
                    isLogin = false
                    goToVerification.toggle()
                }
            }) {
                ColoredButton(buttonText: "Sign Up", fontName: "Montserrat-Bold", fontColorName: "White", fontSize: 15, buttonColor: "BlueGradient", strokeColor: "BlueGradient")
            }
            
            Button(action: {
                withAnimation(.default) {
                    isLogin = true
                    goToVerification.toggle()
                }
            }) {
                ColoredButton(buttonText: "Login", fontName: "Montserrat-Bold", fontColorName: "BlueGradient", fontSize: 15,buttonColor: "White", strokeColor: "BlueGradient")
            }
                
                
            
            Spacer()
                
        }
        }.navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
