//
//  KidsScreen.swift
//  FamilyKeeper Parent SwiftUI
//
//  Created by Leo Chernyak on 11.08.2021.
//

import SwiftUI
import StoreKit


struct NavigationScreen: View {
    @State var user: User
    @State var show = false
    @State var viewPresented: MenuItem = .kidsList
    @State var kidsList: [Child] = [Child]()
    @State private var showPopUp: Bool = false
    @State private var showPopUpUnconnectedChild: Bool = false
    @State var progressIndicatorRun: Bool = false
    
    @StateObject var storeManager = StoreManager()
    
    var productsId = [
    "family.keeper.Parnet_App.yearlySubscription",
    "family.keeper.Parnet_App.monthlySubscription",
    "family.keeper.Parnet_App.quarterSubscription"
    ]
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            GeometryReader {_ in
                VStack{
                    
                    ZStack {
                        HStack {
                            Button(action: {
                                withAnimation(.default) {
                                    self.show.toggle()
                                }
                            }) {
                                Image("menu")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 20, alignment:  .center)
                                    .padding()
                            }
                            Spacer()
                            Text("FamilyKeeper")
                                .font(Font.custom("Montserrat-Bold", size: 20))
                                .foregroundColor(Color("White"))
                            Spacer()
                            
                            Button(action: {
                                withAnimation(.default) {
                                    print("Notification Bell")
                                }
                                
                            }) {
                                Image("notificationBell")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20, alignment:  .center)
                                    .padding()
                                
                                
                            }
                            
                            
                        } .background(Color("BlueGradient").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
                        
                    }
                    Spacer()
                    switch viewPresented {
                    case .kidsList:
                        KidsListView(kidsList: $kidsList, showPopUp: $showPopUp, showPopUpUnconnectedChild: $showPopUpUnconnectedChild)
                            .disabled(show)
                            .onTapGesture {
                                withAnimation(.default) {
                                    show.toggle()
                                }
                            }
                            .onAppear() {
//                                kidsList = []

                                NetworkingManager.getKidsList(user: User.loadObject()) { (list) in
                                    self.kidsList = list
                                }
                            }
                            .frame(
                                  minWidth: 0,
                                  maxWidth: .infinity,
                                  minHeight: 0,
                                  maxHeight: .infinity,
                                  alignment: .topLeading
                            )
                            .padding()
                            
                    case .settings:
                        SettingsView()
                            .disabled(show)
                            .onTapGesture {
                                withAnimation(.default) {
                                    if show {
                                        show.toggle()
                                    }
                                }
                            }
                            .frame(
                                  minWidth: 0,
                                  maxWidth: .infinity,
                                  minHeight: 0,
                                  maxHeight: .infinity,
                                  alignment: .topLeading
                            )
                        
                            
                    case .support:
                        SupportView()
                            .disabled(show)
                            .onTapGesture {
                                withAnimation(.default) {
                                    if show {
                                        show.toggle()
                                    }
                                }
                            }
                            .frame(
                                  minWidth: 0,
                                  maxWidth: .infinity,
                                  minHeight: 0,
                                  maxHeight: .infinity,
                                  alignment: .topLeading
                            )
                            .padding()
                    case .faq:
                        FaqView()
                            .disabled(show)
                            .onTapGesture {
                                withAnimation(.default) {
                                    if show {
                                        show.toggle()
                                    }
                                    
                                }
                            }
                            .frame(
                                  minWidth: 0,
                                  maxWidth: .infinity,
                                  minHeight: 0,
                                  maxHeight: .infinity,
                                  alignment: .topLeading
                            )
                            .padding()
                    case .share:
                        ShareView()
                            .disabled(show)
                            .onTapGesture {
                                withAnimation(.default) {
                                    if show {
                                        show.toggle()
                                    }
                                }
                            }
                            .frame(
                                  minWidth: 0,
                                  maxWidth: .infinity,
                                  minHeight: 0,
                                  maxHeight: .infinity,
                                  alignment: .topLeading
                            )
                            .padding()
                    case .subscription:
                        SubscriptionView(storeManager: storeManager)
                            .onAppear(perform: {
                                SKPaymentQueue.default().add(storeManager)
                                storeManager.getProducts(productIDs: productsId)
                            })
                            .disabled(show)
                            .onTapGesture {
                                withAnimation(.default) {
                                    if show {
                                        show.toggle()
                                    }
                                }
                            }
                            .frame(
                                  minWidth: 0,
                                  maxWidth: .infinity,
                                  minHeight: 0,
                                  maxHeight: .infinity,
                                  alignment: .topLeading
                            )
                            .padding()
                        
                    }
                }
                
            }
            
            HStack {
                MenuScreen(kidsList: $kidsList, show: self.$show, viewPresented: $viewPresented)
                    .offset(x: self.show ? 0 : -UIScreen.main.bounds.width / 1.5)
            }
            AddChildPopUpView(show: $showPopUp, kidsList: $kidsList)
            UnconnectedChildPopUpView(show: $showPopUpUnconnectedChild)
            if progressIndicatorRun {
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                ProgressView()
            }
            
        }
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .edgesIgnoringSafeArea([ .bottom])
        
        
    }
}

struct KidsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationScreen(user: User(name: "nooneeeeeeee", password: "nooneeeeeeee", email: "nooneeeeeeee", pID: "nooneeeeeeee", phone: "nooneeeeeeee", countryCode: "nooneeeeeeee", sex: "nooneeeeeeee"), kidsList: [])
           
    }
}
