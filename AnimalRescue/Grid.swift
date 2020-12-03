//
//  FindAnimals.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/1/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI
 
fileprivate var selectedCountry = countryStructList[0]
 
struct FlagsGrid: View {
   
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
   
    @State private var showCountryInfoAlert = false
   
    // Fit as many images per row as possible with minimum image width of 100 points each.
    // spacing defines spacing between columns
    let columns = [ GridItem(.adaptive(minimum: 100), spacing: 3) ]
   
    var body: some View {
        ScrollView {
            // spacing defines spacing between rows
            LazyVGrid(columns: columns, spacing: 3) {
                // 🔴 Specifying id: \.self is critically important to prevent photos being listed as out of order
                ForEach(self.userData.countriesList, id: \.self) { country in
                    // Public function getImageFromUrl is given in UtilityFunctions.swift
                    getImageFromUrl(url: country.flagImageUrl, defaultFilename: "ImageUnavailable")
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            selectedCountry = country
                            self.showCountryInfoAlert = true
                        }
                }
            }   // End of LazyVGrid
                .padding()
           
        }   // End of ScrollView
            .alert(isPresented: $showCountryInfoAlert, content: { self.countryInfoAlert })
    }
   
    var countryInfoAlert: Alert {
        Alert(title: Text(selectedCountry.name),
              message: Text("Capital City: \(selectedCountry.capital)\nPopulation: \(self.countryPopulation(country: selectedCountry))\nLanguages: \(selectedCountry.languages)\nCurrency: \(selectedCountry.currency)"),
              dismissButton: .default(Text("OK")) )
    }
   
}

struct FindAnimals_Previews: PreviewProvider {
    static var previews: some View {
        FindAnimals()
    }
}
