import SwiftUI

// MARK: - Clothing Model
struct Clothing: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let description: String
    let category: String
    let quality: String
    let color: String
    let seasonOptions: [String] = ["Spring", "Summer", "Autumn", "Winter"]
    let occasionOptions: [String] = ["Casual", "Daily", "Formal", "Party", "Work", "Travel"]
}

// MARK: - Clothing ViewModel
@Observable
class ClothingViewModel {
    private let clothingItems: [String: [Clothing]] = [
        "Pants": [
            Clothing(name: "Black Pant",
                     image: "pants_01",
                     description: "It's a black colored pant",
                     category: "Pants",
                     quality: "High",
                     color: "Black"),
            Clothing(name: "Blue Jean",
                     image: "pants_02",
                     description: "It's a blue jean",
                     category: "Pants",
                     quality: "Medium",
                     color: "Blue")
        ],
        "Shirts": [
            Clothing(name: "Blue Shirt",
                     image: "shirt_02",
                     description: "It's a blue shirt",
                     category: "Shirts",
                     quality: "High",
                     color: "Blue"),
            Clothing(name: "White Shirt",
                     image: "shirt_03",
                     description: "It's a white shirt",
                     category: "Shirts",
                     quality: "Low",
                     color: "White")
        ]
    ]
    
    var getAllClothes: [Clothing] {
        return clothingItems.flatMap { $0.value }
    }
    
    func getFilteredOutfits(category: String, quality: String, color: String, searchText: String) -> [Clothing] {
        clothingItems.flatMap { $0.value }.filter { item in
            let matchesCategory = category == "All" || item.category == category
            let matchesColor = color == "All" || item.color.lowercased() == color.lowercased()
            let matchesQuality = quality == "All" || item.quality.lowercased() == quality.lowercased()
            let matchesSearch = searchText.isEmpty ||
                item.name.lowercased().contains(searchText.lowercased()) ||
                item.description.lowercased().contains(searchText.lowercased()) ||
                item.category.lowercased().contains(searchText.lowercased()) // Added category to search

            return matchesCategory && matchesColor && matchesQuality && matchesSearch
        }
    }

}
