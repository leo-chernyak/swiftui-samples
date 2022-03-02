//
//  SignUpScreen.swift
//  FamilyKeeper Parent SwiftUI
//
//  Created by Leo Chernyak on 09.08.2021.
//

import SwiftUI
import iTextField
import Combine

struct SignUpScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var agreementScreenIsShown = true
    @State var parentsDetailsScreenIsShown = false
    @State var mainViewisPresented = false
    @State var termsVerifyed = false
    @State var policyVerifyed = false
    @State var sex = ""
    @State var phoneNumber: String
    
    
    
    
    
    var body: some View {
        ZStack {
            Color("BlueGradient")
                .ignoresSafeArea()
            if agreementScreenIsShown {
                VStack(alignment: .center){
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
                    Image("logoShade")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Text("Privacy Policy and terms Conditions!")
                        .padding()
                        .multilineTextAlignment(.center)
                        .font(Font.custom("Montserrat-Bold", size: 20))
                        .foregroundColor(Color("White"))
                    Text("Before we get started. Please verify your phone number.")
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .font(Font.custom("Montserrat-Regular", size: 16))
                        .padding()
                        .foregroundColor(Color("White"))
                    HStack {
                        Image(termsVerifyed ? "verified" : "unverified")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .onTapGesture {
                                withAnimation {
                                    termsVerifyed.toggle()
                                }
                            }
                        
                        Spacer()
                        Text("I have read and agreed with the terms and conditions.")
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .font(Font.custom("Montserrat-Regular", size: 16))
                            .padding()
                            .foregroundColor(Color("White"))
                    } .padding()
                    HStack {
                        Image(policyVerifyed ? "verified" : "unverified")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .onTapGesture {
                                withAnimation {
                                    policyVerifyed.toggle()
                                }
                            }
                        Spacer()
                        Text("I have read and agreed with the privacy policy.")
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .font(Font.custom("Montserrat-Regular", size: 16))
                            .padding()
                            .foregroundColor(Color("White"))
                        
                    } .padding()
                    if policyVerifyed && termsVerifyed {
                        HStack {
                            Text("I`m the Dad")
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .font(Font.custom("Montserrat-Bold", size: 16))
                                .padding()
                                .foregroundColor(Color("DarkGray"))
                            Spacer()
                            Image("dad")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding()
                        }
                        .padding(.leading, 50)
                        .padding(.trailing, 50)
                        .background(Color.white)
                        .cornerRadius(40)
                        .overlay(
                            Capsule(style: .continuous)
                                .stroke(Color.black, lineWidth: 0)
                                .shadow(radius: 10)
                        )
                        .padding()
                        .onTapGesture {
                            sex = "dad"
                            agreementScreenIsShown.toggle()
                        }
                        
                        HStack {
                            
                            Text("I`m the Mom")
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .font(Font.custom("Montserrat-Bold", size: 16))
                                .padding()
                                .foregroundColor(Color("DarkGray"))
                            Spacer()
                            Image("mom")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding()
                            
                        }
                        
                        .padding(.leading, 50)
                        .padding(.trailing, 50)
                        
                        .background(Color.white)
                        .cornerRadius(40)
                        .overlay(
                            Capsule(style: .continuous)
                                .stroke(Color.black, lineWidth: 0)
                                .shadow(radius: 10)
                        )
                        .padding()
                        .onTapGesture {
                            sex = "mom"
                            agreementScreenIsShown.toggle()
                        }
                    }
                    Spacer()
                }
            } else {
                ParentDetails(presentationMode: _presentationMode, sex: $sex, parentPhone: phoneNumber)
            }
            
        }.onTapGesture {
            hideKeyboard()
        }
    }
}


struct ParentDetails: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var keyboardHeight: CGFloat = 0
    @Binding var sex: String
    @State var parentName: String = ""
    @State var parentEmail: String = ""
    @State var parentPassword: String = ""
    @State var checkPassword: String = ""
    @State var isSecureEntry: Bool = true
    @State var parentPhone: String
    @State var goToKidsScreen: Bool = false
    @State var userForTransfer: User = User.loadObject()
    @State var errorText: String = ""
    @State var isEditing2 = false
    @State var isEditing3 = false
    @State var isEditing4 = false
    
    @EnvironmentObject var network: NetworkingManager
    var body: some View {
        VStack(alignment: .center){
            
            NavigationLink(destination: NavigationScreen(user: userForTransfer), isActive: $goToKidsScreen)
                { EmptyView() }
            
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
            Image("\(sex)")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Group {
                Text("Hi \(sex.capitalized)!")
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .font(Font.custom("Montserrat-Bold", size: 20))
                    .foregroundColor(Color("White"))
                
                Text("Welcome to FamilyKeeper!\nCreate your account")
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .font(Font.custom("Montserrat-Regular", size: 16))
                    .foregroundColor(Color("White"))
                
                if errorText != "" {
                    Text("\(errorText)")
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .font(Font.custom("Montserrat-Regular", size: 16))
                        .foregroundColor(.red)
                }
                Text("Your phone number is: \(parentPhone)")
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .font(Font.custom("Montserrat-Bold", size: 16))
                    .foregroundColor(Color("White"))
                
            } .padding()
            
            
            Group {
                iTextField("Name", text: $parentName)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .accentColor(.white)
                    .fontFromUIFont(UIFont(name: "Montserrat-Bold", size: 15))
                    .keyboardType(.default)
                    .returnKeyType(.done)
                    .onReturn {isEditing2 = true}
                    .minimumScaleFactor(0.5)
                    .padding()
                    .overlay(Capsule(style: .continuous)
                                .stroke(Color.white))
                
                iTextField("Email", text: $parentEmail, isEditing: $isEditing2)
                    
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .accentColor(.white)
                    .fontFromUIFont(UIFont(name: "Montserrat-Bold", size: 15))
                    .keyboardType(.emailAddress)
                    .returnKeyType(.done)
                    .onReturn {isEditing3 = true}
                    .minimumScaleFactor(0.5)
                    .padding()
                    .overlay(Capsule(style: .continuous)
                                .stroke(Color.white))
            } .padding()
            
            Group {
                HStack {
                    iTextField("Password", text: $parentPassword, isEditing: $isEditing3)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .accentColor(.white)
                        .fontFromUIFont(UIFont(name: "Montserrat-Bold", size: 15))
                        .keyboardType(.default)
                        .isSecure(isSecureEntry)
                        .returnKeyType(.done)
                        .onReturn{isEditing4 = true}
                        .minimumScaleFactor(0.5)
                        .padding()
                    
                    
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
                
                iTextField("Repeat Password", text:
                            $checkPassword, isEditing: $isEditing4)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .accentColor(.white)
                    .fontFromUIFont(UIFont(name: "Montserrat-Bold", size: 15))
                    .keyboardType(.default)
                    .isSecure(isSecureEntry)
                    .returnKeyType(.done)
                    .padding()
                    .minimumScaleFactor(0.5)
                    .overlay(Capsule(style: .continuous)
                                .stroke(Color.white))
                
            }
            .padding()
            
            if (parentName != "") && (parentEmail != "") && (parentPassword != "") && ((checkPassword != "") )  {
                withAnimation {
                    Button(action: {
                        withAnimation(.default) {
                            hideKeyboard()
                            if parentEmail.contains("@") {
                                if parentPassword == checkPassword  {
                                    NetworkingManager.parentRegistration(phone: parentPhone, password: parentPassword, name: parentName, email: parentEmail, sex: sex) { (answer, text, user) in
                                        if answer {
                                            userForTransfer = user!
                                            goToKidsScreen.toggle()
                                        } else {
                                            withAnimation{
                                            errorText = text
                                            }
                                        }
                                    }
                                } else {
                                    withAnimation{
                                    checkPassword = ""
                                    errorText = "Passwords are not the same"
                                    }
                                }
                            } else {
                                withAnimation{
                                    parentEmail = ""
                                    errorText = "Email doesn`t conform the type"
                            }
                            
                            
                                
                            }
                        }
                    }) {
                        ColoredButton(buttonText: "Verify", fontName: "Montserrat-Bold", fontColorName: "BlueGradient", fontSize: 20, buttonColor: "White", strokeColor: "BlueGradient")
                    }
                    
                }
            }
            Spacer()
        }
        .ignoresSafeArea(.keyboard)
        .keyboardAdaptive()
    }
    
}





struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen(phoneNumber: "972587985267")
    }
}
