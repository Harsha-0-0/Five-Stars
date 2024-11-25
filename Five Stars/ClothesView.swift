//
//  ClothesView.swift
//  Five Stars
//
//  Created by Yi Li on 18/11/2024.
//

//import SwiftUI
//
//struct ClothingItem: Identifiable {
//    let id = UUID()
//    let name: String
//    let image: String
//    let description: String
//    let category: String
//    let colors: [String] = ["White", "Blue", "Black", "Green", "Red"]
//    let seasonOptions: [String] = ["Spring", "Summer", "Autumn", "Winter"]
//    let occasionOptions: [String] = ["Casual", "Formal", "Party", "Work", "Party", "Travel"]
//}
//



//
//  Untitled.swift
//  Five Stars
//
//  Created by Yi Li on 21/11/2024.
//

import Foundation

struct Clothing: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let description: String
    let category: String
    let quality: String
    let color: [String]
    let seasonOptions: [String] = ["Spring", "Summer", "Autumn", "Winter"]
    let occasionOptions: [String] = ["Casual", "Formal", "Party", "Work", "Party", "Travel"]
    
}

@Observable
class ClothingViewModel {
    private let clothingItems: [String: [Clothing]] = [
        "Pants":[
            Clothing(name: "Black Pant",
                     image: "pants_01",
                     description: "It's a black colored pant",
                     category: "Pants",
                     quality: "Good",
                     color: ["Black"]),
            Clothing(name: "Blue Jean",
                     image: "pants_02",
                     description: "It's a blue jean",
                     category: "Pants",
                     quality: "Good",
                     color: ["Blue"])],
        "Shirts":[
            Clothing(name: "Blue Shirt",
                     image: "shirt_02",
                     description: "It's a blue shirt",
                     category: "Shirts",
                     quality: "Good",
                     color: ["Blue"]),
            Clothing(name: "Blue Shirt",
                     image: "shirt_01",
                     description: "It's a blue shirt",
                     category: "Shirts",
                     quality: "Good",
                     color: ["Blue"]),
            Clothing(name: "White Shirt",
                     image: "shirt_03",
                     description: "It's a white shirt",
                     category: "Shirts",
                     quality: "Good",
                     color: ["White"])]
        
    ]
    
    var getAllClothes: [Clothing] {
        return clothingItems.flatMap { $0.value }
    }
    
    
    func getFilteredOutfits(category: String, quality: String, color: String, searchText: String) -> [Clothing] {
        let filteredItems = clothingItems.flatMap { $0.value }.filter { item in
            // Check if category matches
            let matchesCategory = category == "All" || item.category == category
            
            // Check if color matches (loop through the color array to see if any color matches)
            let matchesColor = color == "All" || item.color.contains(where: { $0.lowercased() == color.lowercased() })
            
            // Check if quality matches
            let matchesQuality = quality == "All" || item.quality == quality
            
            // Check if search text matches any of the item properties (name, category, color, or quality)
            let matchesSearch = searchText.isEmpty || item.name.lowercased().contains(searchText.lowercased()) ||
                                item.category.lowercased().contains(searchText.lowercased()) ||
                                item.color.contains(where: { $0.lowercased().contains(searchText.lowercased()) }) ||
                                item.quality.lowercased().contains(searchText.lowercased())
            
            // Return true if all conditions match
            return matchesCategory && matchesColor && matchesQuality && matchesSearch
        }
        
        return filteredItems
    }


    
}
    
//func getFilteredOutfits(category: String, quality: String, color: String, searchText: String) -> [Clothing] {
//    // Filter through the clothingItems based on the passed parameters
//    let filteredItems = clothingItems.flatMap { $0.value }.filter { item in
//        let matchesCategory = category == "All" || item.category == category
//        let matchesColor = color == "All" || item.color.contains(color)
//        let matchesQuality = quality == "All" || item.quality == quality
//        let matchesSearch = searchText.isEmpty || item.name.lowercased().contains(searchText.lowercased())
//
//        // Combine the conditions - make sure all conditions are properly evaluated and combined.
//        return matchesCategory && matchesColor && matchesQuality && matchesSearch
//    }
//    
//    return filteredItems
//}

