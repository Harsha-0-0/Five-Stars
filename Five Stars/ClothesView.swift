//
//  ClothesView.swift
//  Five Stars
//
//  Created by Yi Li on 18/11/2024.
//

import SwiftUI

struct ClothingItem: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let description: String
    let category: String
    let colors: [String] = ["White", "Blue", "Black", "Green", "Red"]
    let seasonOptions: [String] = ["Spring", "Summer", "Autumn", "Winter"]
    let occasionOptions: [String] = ["Casual", "Formal", "Party", "Work", "Party", "Travel"]
}

