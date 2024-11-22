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
        VStack {
            
            
            TabView(selection: $selectedTab) {
                // Home Tab
                HomeScreen()
                    .tabItem {
                        Image("home")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? .navSelected : .navDefault) // Change color based on selection
                        Text("Home")
                    }
                    .tag(0)
                
                // Wardrobe Tab
                FilterView()
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
        }
        
        
    }
}




#Preview {
    ContentView()
}
