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
        if userData.userAuthenticated || isUnlocked {
            return AnyView(MainView())
                .onAppear(perform: authenticate)
            
        } else {
            return AnyView(LoginView())
                .onAppear(perform: authenticate)
            
            //                    .onAppear(perform: authenticate)
        }
        
    }
     func authenticate(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, authenticationError in
                DispatchQueue.main.async{
                    if success{
                        self.isUnlocked = true
                    }
                    else{
//                        let ac = UIAlertController(title: "Authentication failed", message: "you could not be verified; please try again.", preferredStyle: .alert)
//                        ac.addAction(UIAlertAction(title: "OK", style: .default))
//                        self?.present(ac,animated:true)
                        print("not match")
                        
                    }
                }
            }
        }
        else{
            //no biometric
            print("no biometric")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

