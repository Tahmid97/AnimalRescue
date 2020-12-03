//
//  FindAnimals.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/1/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI
 
fileprivate var selectedAnimal = animalStructList[0]
 
struct Grid: View {
   
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
   
    @State private var showAnimalInfoAlert = false
   
    // Fit as many images per row as possible with minimum image width of 100 points each.
    // spacing defines spacing between columns
    let columns = [ GridItem(.adaptive(minimum: 100), spacing: 3) ]
   
    var body: some View {
        ScrollView {
            // spacing defines spacing between rows
            LazyVGrid(columns: columns, spacing: 3) {
                // 🔴 Specifying id: \.self is critically important to prevent photos being listed as out of order
                ForEach(self.userData.animalsList, id: \.self) { animal in
                    // Public function getImageFromUrl is given in UtilityFunctions.swift
                    getImageFromUrl(url: animal.photoUrl, defaultFilename: "ImageUnavailable")
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            selectedAnimal = animal
                            self.showAnimalInfoAlert = true
                        }
                }
            }   // End of LazyVGrid
                .padding()
           
        }   // End of ScrollView
            .alert(isPresented: $showAnimalInfoAlert, content: { self.animalInfoAlert })
    }
   
    var animalInfoAlert: Alert {
        Alert(title: Text("Type of animal: " + selectedAnimal.animalType),
              dismissButton: .default(Text("OK")))
    }
   
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
       Grid()
    }
}
