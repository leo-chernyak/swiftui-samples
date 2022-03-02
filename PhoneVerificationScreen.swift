//
//  PhoneVerificationScreen.swift
//  FamilyKeeper Parent SwiftUI
//
//  Created by Leo Chernyak on 09.08.2021.
//

import SwiftUI
import iPhoneNumberField
import iTextField

struct PhoneVerificationScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isLogin: Bool
    @State var placeHolder = "(000) 000-0000"
    @State var phoneText = ""
    @State var isEditing = false
    @State var isVerifying = false
    @State var codeTextField = ""
    @State var phoneIsVerifyed = false
    @State var errorText = ""
    
    
    var body: some View {
        ZStack {
            Color("BlueGradient")
                .ignoresSafeArea()
            
            NavigationLink(destination: isLogin ? AnyView( LoginScreen(phoneNumber: phoneText)) : AnyView(SignUpScreen( phoneNumber: phoneText)), isActive: $phoneIsVerifyed)
                { EmptyView() }
            
            VStack(alignment: .center){
                HStack {
                    Image("backButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    Spacer()
                }
                Image("logoShade")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                if !isVerifying {
                    Text("Hi Parents!")
                        .font(Font.custom("Montserrat-Bold", size: 20))
                        .foregroundColor(Color("White"))
                    Text("Before we get started. Please verify your phone number.")
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .font(Font.custom("Montserrat-Regular", size: 16))
                        .padding()
                        .foregroundColor(Color("White"))
                    if errorText != "" {
                    Text("\(errorText)")
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .font(Font.custom("Montserrat-Regular", size: 16))
                        .padding()
                        .foregroundColor(.red)
                    }
                     iPhoneNumberField(text: $phoneText)
                        .foregroundColor(Color.white)
                        .prefixHidden(false)
                        .autofillPrefix(true)
                        .clearButtonMode(.whileEditing)
                        .onClear { _ in phoneText = "" }
                                .flagHidden(false)
                                .flagSelectable(true)
                                .font(UIFont(size: 30, weight: .bold, design: .rounded))
                            .maximumDigits(10)
                                .padding()
                        .accentColor(Color.orange)
                   
                    Rectangle()
                        .fill(Color.white)
                                .frame(height: 2)
                                .edgesIgnoringSafeArea(.horizontal)
                    Spacer()
                    Button(action: {
                        withAnimation(.default) {
                            NetworkingManager.verificationSms(phone: phoneText) { (answer) in
                                if answer {
                                    if phoneText.count > 6 {
                                        isVerifying.toggle()
                                    } else {
                                        errorText = "Wrong phone number"
                                    }
                                } else {
                                    if phoneText.count > 6 {
                                        phoneIsVerifyed.toggle()
                                    } else {
                                        errorText = "Wrong phone number"
                                    }
                                    
                                }
                            }
                        }
                    }) {
                        ColoredButton(buttonText: "Verify", fontName: "Montserrat-Bold", fontColorName: "BlueGradient", fontSize: 20, buttonColor: "White", strokeColor: "BlueGradient")
                    }
                    
                    
                } else {
                    Text("Hi Parents!")
                        .font(Font.custom("Montserrat-Bold", size: 20))
                        .foregroundColor(Color("White"))
                    Text("We sent you SMS on your phone number: \(phoneText)")
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .font(Font.custom("Montserrat-Regular", size: 16))
                        .padding()
                        .foregroundColor(Color("White"))
                    iTextField("Code", text: $codeTextField)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                                .accentColor(.black)
                                .fontFromUIFont(UIFont(name: "Montserrat-Bold", size: 30))
                        .keyboardType(.numberPad)
                                .returnKeyType(.done)
                                .padding()
                    Rectangle()
                        .fill(Color.white)
                                .frame(height: 2)
                                .edgesIgnoringSafeArea(.horizontal)
                    Spacer()
                    if codeTextField != "" {
                        withAnimation {
                        
                        ColoredButton(buttonText: "Accept", fontName: "Montserrat-Bold", fontColorName: "BlueGradient", fontSize: 20, buttonColor: "White", strokeColor: "BlueGradient")
                         .onTapGesture {
                            if codeTextField.count < 4 {
                                phoneIsVerifyed.toggle()
                            } else {
                                errorText = "Code has to be more then 3 symbols"
                            }
                            
                         }
                        }
                    }
                    
                   
                    
                }
                
                
            } .padding(.all, 20)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
            
        }
//        . onTapGesture {
//            hideKeyboard()
//        }
//        
        
        
        
    }
}




struct PhoneVerificationScreen_Previews: PreviewProvider {
    static var previews: some View {
        PhoneVerificationScreen(isLogin: false)
    }
}
