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
    
    @AppStorage("animal", store: UserDefaults(suiteName: "group.com.TahmidMuttaki.AnimalRescue.AnimalWidget"))
    var widgetData: Data = Data()
    
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        initSave()
        if userData.userAuthenticated || isUnlocked {
            return AnyView(MainView())
                .onAppear(perform: authenticate)
            
        } else {
            return AnyView(LoginView())
                .onAppear(perform: authenticate)
        }
        
    }
    
    func save(_ animal: [AnimalStruct]) {
        guard let widgetData = try? JSONEncoder().encode(animal) else { return }
        self.widgetData = widgetData
        print("save \(animal)")
    }
    
    func initSave() {
        save(animalStructList)
    }
    
    //this Function implement the face id authentification. change state variable isUnblocked is successfully matched the face
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
                        //problem
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

