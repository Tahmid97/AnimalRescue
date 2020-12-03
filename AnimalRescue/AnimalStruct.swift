//
//  AnimalStruct.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/2/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI

public struct Animal: Hashable, Codable, Identifiable {
    public var id: UUID        // Storage Type: String, Use Type (format): UUID
    var animalType: String
    var photoUrl: String
}
