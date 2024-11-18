//
//  GridView.swift
//  Five Stars
//
//  Created by Yi Li on 18/11/2024.
//

import SwiftUI

struct GridView: View {
    let title: String
    let items: [ClothingItem]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Section(header: Text("\(title) (\(items.count))")
                    .font(.headline)
                    .padding(.leading)) {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items) { item in
                    NavigationLink(destination: ItemDetail(item: item)) {
                        VStack {
                            Image(item.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Main View
struct HomeView: View {
    
    var categories: [String: [ClothingItem]] = [
        "T-shirts": [
            ClothingItem(name: "Black T-shirt", image: "BlackShirt", description: "A sleek black T-shirt."),
            ClothingItem(name: "White T-shirt", image: "WhiteShirt", description: "A simple white T-shirt."),
            ClothingItem(name: "Black T-shirt", image: "BlackShirt", description: "Another black T-shirt.")
        ],
        "Pants": [
            ClothingItem(name: "Black Pant", image: "BlackPant", description: "A formal black pant."),
            ClothingItem(name: "White pant", image:"WhitePant", description: "A classic white pant.")
        ],
        "Dresses": [
            ClothingItem(name: "Black Dress",image:"BlackDress" , description: "A classic black dress."),
            ClothingItem(name: "White Dress",image:"WhiteDress" , description: "A stylish white dress.")
        ]
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(categories.keys.sorted(), id: \.self) { category in
                        if let items = categories[category] {
                            GridView(title: category, items: items)
                        }
                    }
                }
            }
            .navigationTitle("Clothing Store")
        }
    }
}

// MARK: - Item Detail View
struct ItemDetail: View {
    let item: ClothingItem
    
    var body: some View {
        VStack {
            Image(item.image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding()
            
            Text(item.name)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 10)
            
            Text(item.description)
                .font(.body)
                .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle(item.name)
    }
}

#Preview {
    HomeView()
}
