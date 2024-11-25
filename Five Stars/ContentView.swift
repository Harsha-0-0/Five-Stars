//
//  ContentView.swift
//  Five Stars
//
//  Created by Harsha Varthini Maniraj on 18/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            HomeScreen(selectedTab: $selectedTab) // Pass the binding
                .tabItem {
                    Image("home")
                        .renderingMode(.template)
                    Text("Home")
                }
                .tag(0)
            
            // Wardrobe Tab
            FilterView(selectedTab: $selectedTab)
                .tabItem {
                    Image("Wardrobe")
                        .renderingMode(.template)
                    Text("Wardrobe")
                }
                .tag(1)
            
            // Magic Tab
            Outfit_Generate()
                .tabItem {
                    Image("spark")
                        .renderingMode(.template)
                    Text("Magic")
                }
                .tag(2)
        }
        
        .accentColor(.accentColor)
    }
}


#Preview {
    ContentView()
}



