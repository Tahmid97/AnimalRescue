//
//  SearchResultDetails.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/7/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI
import MapKit
 
struct SearchResultDetails: View {
    @EnvironmentObject var userData: UserData
    @State private var showAnimalAddedAlert = false

    // Input Parameter
    let animal: AnimalStruct
   
    var body: some View {
        // A Form cannot have more than 10 Sections.
        // Group the Sections if more than 10.
        Form {
            Section(header: Text("Animal Name")) {
                    Text(animal.name)
                }
                Section(header: Text("Species")) {
                    Text(animal.species)
                }
                Section(header: Text("Breed")) {
                    Text(animal.breedString)
                }
            Group {

                Section(header: Text("Animal looks")) {
                    // Public function getImageFromUrl is given in UtilityFunctions.swift
                    getImageFromUrl(url:animal.photoUrl, defaultFilename: "ImageUnavailable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350)
                }
//                Section(header: Text("Play movie trailer")) {
//                    NavigationLink(destination:
//                                    WebView(url: "http://www.youtube.com/embed/\(movie.youTubeTrailerId)")
//                                    .navigationBarTitle(Text("Play Movie Trailer"), displayMode: .inline)
//                    ){
//                        HStack {
//                            Image(systemName: "play.rectangle.fill")
//                                .imageScale(.medium)
//                                .font(Font.title.weight(.regular))
//                                .foregroundColor(.red)
//                            Text("Play YouTube Movie Trailer")
//                                .font(.system(size: 16))
//                        }
//                        .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
//                    }
//                }
                
                Section(header: Text("Animal Age")) {
                    Text("\(animal.ageString)")
                }
                Section(header: Text("Animal Sex")) {
                    Text("\(animal.sex)")
                }

                Section(header: Text("Animal Age group")) {
                    Text("\(animal.ageGroup), \(animal.ageString)")
                }
              
                Section(header: Text("Color Details")) {
                    Text("\(animal.colorDetails)")
                }
                Section(header: Text("Birth Date")) {
                    Text("\(animal.birthDate)")
                }

                Section(header: Text("Adoption fees")) {
                    Text("\(animal.adoptionFeeString) Dollars")
                }
                
                Section(header: Text("Add To favorite")) {
                    Button(action: {
                        // Append the country found to userData.countriesList
                        self.userData.animalsList.append(animal)
 
                        // Set the global variable point to the changed list
                        animalStructList = self.userData.animalsList
                       
                        let selectedAnimalAttributesForSearch = "\(animal.id)|\(animal.ageGroup)|\(animal.name)|\(animal.breedString)|\(animal.colorDetails)|\(animal.indoorOutdoor)|\(animal.sex)|\(animal.species)|\(animal.ageString)"
                       
                        self.userData.searchableOrderedAnimalsList.append(selectedAnimalAttributesForSearch)
                       
                        // Set the global variable point to the changed list
                        orderedSearchableAnimalsList = self.userData.searchableOrderedAnimalsList
                        self.showAnimalAddedAlert = true

                    }) {
                        HStack {
                            Image(systemName: "plus")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                                .foregroundColor(.blue)
                            Text("Add Animal to Favorites")
                                .font(.system(size: 16))
                        }
                    }
                }

                
            }

 
        }   // End of Form
        .navigationBarTitle(Text("\(animal.name)"), displayMode: .inline)
            .font(.system(size: 14))
        .alert(isPresented: $showAnimalAddedAlert, content: { self.animalAddedAlert })

       
    }   // End of body
    var animalAddedAlert: Alert {
        Alert(title: Text("Pet Added!"),
              message: Text("This Pet is added to your favorites list!"),
              dismissButton: .default(Text("OK")) )
    }


}
