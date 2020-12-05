//
//  FavoritesDetails.swift
//  AnimalRescue
//
//  Created by Boshen Zhang on 12/2/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//


import SwiftUI
import MapKit
 
struct FavoriteDetails: View {
   
    // Input Parameter
    let animal: Animal
   
    var body: some View {
        // A Form cannot have more than 10 Sections.
        // Group the Sections if more than 10.
        Form {
            Group {
                Section(header: Text("Animal Name")) {
                    Text(animal.animalType)
                }
//                Section(header: Text("Movie Poster")) {
//                    // Public function getImageFromUrl is given in UtilityFunctions.swift
//                    getImageFromUrl(url:"https://image.tmdb.org/t/p/w500/\(movie.posterFileName)", defaultFilename: "ImageUnavailable")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 350)
//
//                }
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
                Section(header: Text("animal Age")) {
                    Text("\(animal.animalType)")
                }
            }

 
        }   // End of Form
        .navigationBarTitle(Text("\(animal.animalType)"), displayMode: .inline)
            .font(.system(size: 14))
       
    }   // End of body

}
 
struct FavoriteDetails_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteDetails(animal: animalStructList[0])
    }
}
 
