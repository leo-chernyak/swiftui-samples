//
//  MenuScreen.swift
//  FamilyKeeper Parent SwiftUI
//
//  Created by Leo Chernyak on 11.08.2021.
//

import SwiftUI
import StoreKit


enum MenuItem {
    case kidsList
    case settings
    case support
    case faq
    case share
    case subscription
}


struct MenuScreen: View {
    @Binding var kidsList: [Child]
    @Binding var show: Bool
    @Binding var viewPresented: MenuItem
    @State var goToSubscriptions: Bool = false
    @StateObject var storeManager = StoreManager()
    
    var productsId = [
    "family.keeper.Parnet_App.yearlySubscription",
    "family.keeper.Parnet_App.monthlySubscription",
    "family.keeper.Parnet_App.quarterSubscription"
    ]
    
    
    
    var body: some View {
        
            VStack {
                HStack {
                    Button(action: {
                        withAnimation(.default) {
                            self.show.toggle()
                        }
                        
                    }) {
                        Image("backButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding()
                        Spacer()
                        
                    }
                }
                .padding(.top, 30)
                .padding(.bottom,25)
                HStack {
                    Image("mom")
                        .resizable()
                        .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .scaledToFit()
                        .clipShape(Circle())
                    
                    Text("Hi, \(User.loadObject().name)")
                        .multilineTextAlignment(.center)
                        .font(Font.custom("Montserrat-Bold", size: 15))
                        .foregroundColor(Color("White"))
                    Spacer()
                }
                Divider()
                    .background(Color.white)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                ScrollView {
                Group {
                    Button(action: {
                        withAnimation(.default) {
                            viewPresented = MenuItem.kidsList
                            self.show.toggle()
//                            NetworkingManager.getKidsList(user: User.loadObject()) { (list) in
//                                self.kidsList = list
//                            }
                        }
                    }) {
                        HStack{
                            Image("family-menu")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40, alignment: .center)
                                .padding()
                           
                            Text("My Kids")
                                .font(Font.custom("Montserrat-Bold", size: 15))
                                .foregroundColor(Color("White"))
                            Spacer()
                        }
                    }
                    Divider()
                        .background(Color.white)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    Button(action: {
                        withAnimation(.default) {
                            viewPresented = MenuItem.settings
                            self.show.toggle()
                        }
                    }) {
                        HStack{
                            Image("settings-menu")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding()
                            
                            Text("Settings")
                                .font(Font.custom("Montserrat-Bold", size: 15))
                                .foregroundColor(Color("White"))
                            Spacer()
                        } .padding(.top , 25)
                    }
                    Divider()
                        .background(Color.white)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    Button(action: {
                        withAnimation(.default) {
                            viewPresented = MenuItem.support
                            self.show.toggle()
                        }
                    }) {
                        HStack{
                            Image("support-menu")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding()
                            
                            Text("Support")
                                .font(Font.custom("Montserrat-Bold", size: 15))
                                .foregroundColor(Color("White"))
                            Spacer()
                        } .padding(.top , 25)
                    }
                    Divider()
                        .background(Color.white)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    Button(action: {
                        withAnimation(.default) {
                            viewPresented = MenuItem.faq
                            self.show.toggle()
                        }
                    }) {
                        HStack{
                            Image("faq-menu")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding()
                            
                            Text("FAQ")
                                .font(Font.custom("Montserrat-Bold", size: 15))
                                .foregroundColor(Color("White"))
                            Spacer()
                        } .padding(.top , 25)
                        
                    }
                    Divider()
                        .background(Color.white)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                    NavigationLink(destination: SubscriptionView( storeManager: storeManager).onAppear(perform: {
                        storeManager.getProducts(productIDs: productsId)
                        SKPaymentQueue.default().add(storeManager)
                    }), isActive: $goToSubscriptions)
                        { EmptyView() }
                    Button(action: {
                        withAnimation(.default) {
                            goToSubscriptions.toggle()
                            self.show.toggle()
                        }
                    }) {
                        
                        HStack{
                            
                            Image("subscriptions-menu")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding()

                            Text("Subscriptions")
                                .font(Font.custom("Montserrat-Bold", size: 15))
                                .foregroundColor(Color("White"))
                            Spacer()

                        } .padding(.top , 25)
                    }
                    
                    
                }
                    
                }
                
                Spacer()
            }
            .foregroundColor(.primary)
            .padding(.horizontal,20)
            .frame(width: UIScreen.main.bounds.width / 1.5)
            .background(Color("BlueGradient").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
            .overlay(Rectangle().stroke(Color.primary.opacity(0.2) , lineWidth: 2).shadow(radius: 3).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
            
            
        
         
    }
}

//struct MenuScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuScreen(show: <#Binding<Bool>#>)
//    }
//}
