//
//  FavoritesItem.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/2/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI

struct FavoriteItem: View {
    
    // Input Parameter
    let animal: Animal
    
    var body: some View {
        HStack {            
            VStack(alignment: .leading) {
                Text(animal.animalType)
                HStack {
                    
                    Text("\(animal.animalType)")
                }
                Text("\(animal.animalType)")
                
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))
            
        }   // End of HStack
    }
    
}

struct FavoriteItem_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteItem(animal: animalStructList[0])
    }
}

