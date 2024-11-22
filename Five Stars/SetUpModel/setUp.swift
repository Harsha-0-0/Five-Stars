//
//  setUp.swift
//  Five Stars
//
//  Created by Hazel Chen on 21/11/2024.
//

import Foundation
import SwiftUI

func GetStepSubtitle(_ step: Int) -> String {
    if step == 1 {
        return "Create a Look with What’s Already in Your Closet"
    } else if step == 2 {
        return "Choose an occasion if you want!"
    } else if step == 3 {
        return "You Are Almost Done!"
    } else {
        return ""
    }
}

func GetStepColor(_ step: Int, _ currentStep: Int) -> Color {
    let selectedColor: Color = Color("Secondary")
    let defaultColor: Color = Color("Gray_Bg").opacity(0.9)
    
    return step == currentStep ? selectedColor : defaultColor
}

func AddClothesArray(_ categoryName: String) -> [Image] {
    var clothesArray: [Image] = []
    
    if let categoryArray = getCategoryArr(categoryName) {
        for itemName in categoryArray {
            if let uiImage = UIImage(named: itemName) {
                if let croppedUIImage = cropImage(uiImage) {
                    let croppedImage = croppedUIImage
                    clothesArray.append(croppedImage)
                } else {
                    print("Failed to crop image: \(itemName)")
                }
            } else {
                print("Unable to load image: \(itemName)")
            }
        }
    } else {
        print("No items found in category \(categoryName)")
    }
    
    return clothesArray
}


