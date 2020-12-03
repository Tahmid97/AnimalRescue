//
//  AnimalStruct.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/2/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI

struct Animal: Hashable, Codable, Identifiable {
  
   var id: UUID        // Storage Type: String, Use Type (format): UUID
    var name: String
   var species: String
   var ageGroup: String
   var breed: String
   var photoUrl: String
   var colors: String
   var organization: String           // In square kilometers
   var longitude: Int
   var latitude: Int

}

