//
//  MainView.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/5/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            FavoritesList()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
            Grid()
                .tabItem {
                    Image(systemName: "square.grid.3x3.fill")
                    Text("Cute Animals")
                }
            CatFactsList()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Cat Facts")
                }
            Setting()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }        }   // End of TabView
        .font(.headline)
        .imageScale(.medium)
        .font(Font.title.weight(.regular))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
