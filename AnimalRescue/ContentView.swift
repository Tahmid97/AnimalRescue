//
//  ContentView.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/1/20.
//
import SwiftUI
import LocalAuthentication

struct ContentView : View {
    @State private var isUnlocked = false
    
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        if userData.userAuthenticated {
            return AnyView(MainView())
        } else {
            return AnyView(LoginView())
            //                    .onAppear(perform: authenticate)
        }
        
        
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

