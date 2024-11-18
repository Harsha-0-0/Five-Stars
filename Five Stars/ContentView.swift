//
//  ContentView.swift
//  Five Stars
//
//  Created by Harsha Varthini Maniraj on 18/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    var body: some View {
        VStack {
            NavigationStack {
                
            }
            .searchable(text: $searchText, prompt: "Search")
            TabView {
                Tab {
                    HomeView()
                } label: {
                    Image("home")
                }
                Tab {
                    WardrobeView()
                } label: {
                    Image("Wardrobe")
                }
                Tab {
                    MagicView()
                } label: {
                    Image("spark")
                }
            }
        }
    }
}

struct HomeView: View {
    var body: some View {
        Text("Home")
    }
}
struct WardrobeView: View {
    var body: some View {
        Text("Wardrobe")
    }
}
struct MagicView: View {
    var body: some View {
        Text("Magic")
    }
}

#Preview {
    ContentView()
}
