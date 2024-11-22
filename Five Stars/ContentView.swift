//
//  ContentView.swift
//  Five Stars
//
//  Created by Harsha Varthini Maniraj on 18/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var selectedTab = 0
    var body: some View {
        VStack {
            NavigationStack {
                
            }
            .searchable(text: $searchText, prompt: "Search")
            TabView(selection: $selectedTab) {
                // Home Tab
                HomeScreenView()
                    .tabItem {
                        Image("home")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? .navSelected : .navDefault) // Change color based on selection
                        Text("Home")
                    }
                    .tag(0)
                
                // Wardrobe Tab
                WardrobeView()
                    .tabItem {
                        Image("Wardrobe")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 1 ? .navSelected : .navDefault) // Change color based on selection
                        Text("Wardrobe")
                    }
                    .tag(1)
                
                // Magic Tab
                MagicView()
                    .tabItem {
                        Image("spark")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 2 ? .navSelected : .navDefault) // Change color based on selection
                        Text("Magic")
                    }
                    .tag(2)
            }
            .accentColor(.navSelected)
            .toolbarBackground(.visible, for: .navigationBar)
            .accentColor(.navSelected)
            .accentColor(.green)
            .foregroundColor(.green)
        }
    }
}

struct HomeScreenView: View {
    var body: some View {
        Text("Home")
    }
}
struct WardrobeView: View {
    var body: some View {
        Text("Wardrobe")
    }
}
//struct MagicView: View {
//    var body: some View {
//        Text("Magic")
//    }
//}

#Preview {
    ContentView()
}
