//
//  ContentView.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/1/20.
//

import SwiftUI

struct ContentView: View {
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
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Find Animals")
                }
            Shelters()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Shelters")
                }
        }   // End of TabView
        .font(.headline)
        .imageScale(.medium)
        .font(Font.title.weight(.regular))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
