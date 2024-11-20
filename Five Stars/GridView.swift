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
            ClothingItem(
                name: "Black T-shirt",
                image: "BlackShirt",
                description: "A sleek black T-shirt.",
                category: "T-Shirt")
            
        ],
        "Pants": [
            ClothingItem(
                name: "Black Pant",
                image: "BlackPant",
                description: "A formal black pant.",
                category: "Pants"),
            
            ClothingItem(
                name: "White pant",
                image:"WhitePant",
                description: "A classic white pant.",
                category: "Pants"),
            
            ClothingItem(
                name: "White pant",
                image:"WhitePant",
                description: "A classic white pant.",
                category: "Pants")
        ],
        "Dresses": [
            ClothingItem(
                name: "Black Dress",
                image:"BlackDress" ,
                description: "A classic black dress.",
                category: "Dresses"),
            
            ClothingItem(
                name: "White Dress",
                image:"WhiteDress" ,
                description: "A stylish white dress.",
                category: "Dresses")
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
    @State private var selectedColor: String = "Black"
    @State private var selectedSeason: String = "Spring"
    @State private var selectedOccasion: String = "Daily"
    
    var body: some View {
       ScrollView{
                   VStack(alignment: .leading, spacing: 20) {
                       // Image Section
                       Image(item.image)
                           .resizable()
                           .scaledToFit()
                           .frame(height: 200)
                           .background(Color.gray.opacity(0.2))
                           .cornerRadius(8)
                           .padding()

                       // Name Section
                       Text(item.name)
                           .font(.largeTitle)
                           .bold()
                           .padding(.leading, 15)

                       // Description Section
                       Text(item.description)
                           .font(.body)
                           .padding(.horizontal)

                       Divider()
                       
                       // Category Section
                       VStack(alignment: .leading) {
                           Text("Category")
                               .font(.headline)
                           Text(item.category)
                               .foregroundColor(.blue)
                       }
                       .padding(.horizontal)
                       
                       // Color Section
                       VStack(alignment: .leading) {
                           Text("Color")
                               .font(.headline)
                           ScrollView(.horizontal, showsIndicators: false) {
                               HStack(spacing: 10) {
                                   ForEach(item.colors, id: \.self) { color in
                                       Text(color)
                                           .padding()
                                           .background(selectedColor == color ? Color.gray.opacity(0.2) : Color.clear)
                                           .cornerRadius(8)
                                           .onTapGesture {
                                               selectedColor = color
                                           }
                                   }
                               }
                           }
                       }
                       .padding(.horizontal)
                       
                       // Season Section
                       VStack(alignment: .leading) {
                           Text("Season")
                               .font(.headline)
                           ScrollView(.horizontal, showsIndicators: false) {
                               HStack(spacing: 10) {
                                   ForEach(item.seasonOptions, id: \.self) { season in
                                       Text(season)
                                           .padding()
                                           .background(selectedSeason == season ? Color.gray.opacity(0.2) : Color.clear)
                                           .cornerRadius(8)
                                           .onTapGesture {
                                               selectedSeason = season
                                           }
                                   }
                               }
                           }
                       }
                       .padding(.horizontal)
                       
                       // Occasion Section
                       VStack(alignment: .leading) {
                           Text("Occasions")
                               .font(.headline)
                           ScrollView(.horizontal, showsIndicators: false) {
                               HStack(spacing: 10) {
                                   ForEach(item.occasionOptions, id: \.self) { occasion in
                                       Text(occasion)
                                           .padding()
                                           .background(selectedOccasion == occasion ? Color.gray.opacity(0.2) : Color.clear)
                                           .cornerRadius(8)
                                           .onTapGesture {
                                               selectedOccasion = occasion
                                           }
                                   }
                               }
                           }
                       }
                       .padding(.horizontal)
                   }
                   .padding(.bottom, 20)
                   .navigationTitle("Clothes Details")
               }
    }
}

#Preview {
    HomeView()
}
