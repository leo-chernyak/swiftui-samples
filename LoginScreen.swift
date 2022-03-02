//
//  LoginScreen.swift
//  FamilyKeeper Parent SwiftUI
//
//  Created by Leo Chernyak on 09.08.2021.
//

import SwiftUI
import iTextField

struct LoginScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var mainViewisPresented = false
    @State var phoneNumber: String
    @State var password: String = ""
    @State var isSecureEntry: Bool = true
    @State var errorText: String = ""
    @State var goToKidsScreen: Bool = false
    @State var userForTransfer: User = User.loadObject()
    
    
    @EnvironmentObject var network: NetworkingManager
    var body: some View {
        ZStack {
            NavigationLink(destination: NavigationScreen(user: userForTransfer), isActive: $goToKidsScreen)
                { EmptyView() }
            Color("BlueGradient")
                .ignoresSafeArea()
            VStack(alignment: .center) {
                HStack {
                    Image("backButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding()
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    Spacer()
                }
                HStack {
                    Spacer()
                    Image("dad")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image("mom")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                } .padding()
                Text("Hi Parents!")
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(Font.custom("Montserrat-Bold", size: 20))
                    .foregroundColor(Color("White"))
                Text("\(errorText)")
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(Font.custom("Montserrat-Regular", size: 15))
                    .foregroundColor(.red)
                    .lineLimit(nil)
                    .minimumScaleFactor(0.5)
                
                iTextField("Phone", text: $phoneNumber)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .accentColor(.white)
                    .fontFromUIFont(UIFont(name: "Montserrat-Bold", size: 20))
                    .keyboardType(.default)
                    .returnKeyType(.done)
                    .disabled(true)
                    .padding()
                    .minimumScaleFactor(0.5)
                    .overlay(Capsule(style: .continuous)
                                .stroke(Color.white)
                    )
//                Rectangle()
//                    .fill(Color.white)
//                    .frame(height: 1)
//                    .edgesIgnoringSafeArea(.horizontal)
                HStack {
                    iTextField("Password", text: $password)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .accentColor(.white)
                        .fontFromUIFont(UIFont(name: "Montserrat-Bold", size: 20))
                        .keyboardType(.default)
                        .isSecure(isSecureEntry)
                        .returnKeyType(.done)
                        .padding()
                        .minimumScaleFactor(0.5)
                        
                    Image("seePassword")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding()
                        .onTapGesture {
                            isSecureEntry.toggle()
                        }
                }
                .overlay(Capsule(style: .continuous)
                            .stroke(Color.white))
               
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 1)
                    .edgesIgnoringSafeArea(.horizontal)
                Spacer()
                Button(action: {
                    withAnimation(.default) {
                        if password != "" && phoneNumber != "" {
                           
                            NetworkingManager.parentLogin(phone: phoneNumber, password: password) { (answer, text, user) in
                                if answer {
                                    userForTransfer = user!
                                    goToKidsScreen.toggle()
                                    print("Login")
                                } else {
                                    errorText = text
                                }
                            }
                            
                        } else {
                            errorText = "Please fill the password field"
                            password = ""
                        }
                    }
                }) {
                    ColoredButton(buttonText: "Login", fontName: "Montserrat-Bold", fontColorName: "BlueGradient", fontSize: 20, buttonColor: "White", strokeColor: "BlueGradient")
                }
                
                Button(action: {
                    withAnimation(.default) {
                        print("Forgot Password")
                    }
                }) {
                    Text("Forgot password")
                        .padding()
                        .multilineTextAlignment(.center)
                        .font(Font.custom("Montserrat-Bold", size: 20))
                        .foregroundColor(Color("White"))
                }
            }
            .padding()
        } .onTapGesture {
            hideKeyboard()
        }
        
       
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen( phoneNumber: "929 633 98 65")
    }
}
