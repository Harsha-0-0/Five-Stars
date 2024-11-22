//
//  test.swift
//  Five Stars
//
//  Created by Hazel Chen on 20/11/2024.
//

//
//  checkJson.swift
//  Five Stars
//
//  Created by Hazel Chen on 20/11/2024.
//

import Foundation
import UIKit
import SwiftUI

struct Item: Codable {
    let name: String
    let description: String
    let color: String
}

struct Wardrobe: Codable {
    let dress: [Item]
    let jackets: [Item]
    let pants: [Item]
    let shirts: [Item]
    let shoes: [Item]
    let TShirts: [Item]
}

struct WardrobeData: Codable {
    let wardrobe: Wardrobe
}

var categoryArrays: [String: [String]] = [:]

struct outfitGenerateView: View {
    var body: some View {
        
        VStack {
            if let uiImage = UIImage(named: "jacket_01"),
               let croppedImage = uiImage.cropTransparentArea() {
                // croped pic
                Image(uiImage: croppedImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Failed to crop image")
            }
        }
        .padding()
        
    }
}

// load the wardrobe JSON data
func loadWardrobeData() -> Wardrobe? {
    if let path = Bundle.main.path(forResource: "wardrobe", ofType: "json"),
       let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
        let decoder = JSONDecoder()
        if let wardrobeData = try? decoder.decode(WardrobeData.self, from: data) {
            return wardrobeData.wardrobe
        }
    }
    return nil
}

// Create all the category array
func loadAllCategories() {
    if let wardrobe = loadWardrobeData() {
        //（1st level keys）
        let mirror = Mirror(reflecting: wardrobe)
        
        for child in mirror.children {
            if let categoryName = child.label,
               let items = child.value as? [Item] {
                
                categoryArrays[categoryName] = items.map { $0.name }
            }
        }
    }
}

extension UIImage {
    func cropTransparentArea() -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        
        // Buffer
        guard let data = calloc(height * width, bytesPerPixel) else { return nil }
        defer { free(data) }
        
        guard let context = CGContext(data: data,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: bitsPerComponent,
                                      bytesPerRow: bytesPerRow,
                                      space: CGColorSpaceCreateDeviceRGB(),
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil
        }
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        let pixelData = data.assumingMemoryBound(to: UInt8.self)
        
        // find the boarder
        var top = height
        var left = width
        var bottom = 0
        var right = 0
        
        for y in 0..<height {
            for x in 0..<width {
                let pixelIndex = (y * width + x) * bytesPerPixel
                let alpha = pixelData[pixelIndex + 3]
                if alpha > 0 { // non transparent
                    if y < top { top = y }
                    if y > bottom { bottom = y }
                    if x < left { left = x }
                    if x > right { right = x }
                }
            }
        }
        
        guard top < bottom, left < right else { return nil }
        
        // calculate for the crop range
        let cropRect = CGRect(x: left, y: top, width: right - left, height: bottom - top)
        
        // crop
        guard let croppedCgImage = cgImage.cropping(to: cropRect) else { return nil }
        return UIImage(cgImage: croppedCgImage)
    }
}


struct TestView: View {
    let categoryName: String
    
    var body: some View {
//        VStack {
            if let categoryArray = getCategoryArr(categoryName) {
                ScrollView {
                    HStack {
                        ForEach(categoryArray, id: \.self) { itemName in
                            if let uiImage = UIImage(named: itemName) {
                                if let croppedImage = cropImage(uiImage) {
//                                    HStack {
                                        croppedImage
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 220)
                                            .padding()
//                                    }
                                } else {
                                    Text("Failed to crop image: \(itemName)")
                                }
                            } else {
                                Text("Unable to load image: \(itemName)")
                            }
                        }
                    }
                }
            } else {
                Text("No items found in category \(categoryName)")
            }
//        }
    }
    
}

// 從 categoryArrays 中獲取分類數據
func getCategoryArr(_ categoryName: String) -> [String]? {
    
    if categoryArrays.isEmpty {
        loadAllCategories() // init
    }
    return categoryArrays[categoryName]
}

func cropImage(_ image: UIImage) -> Image? {
    if let croppedUIImage = image.cropTransparentArea() {
        return Image(uiImage: croppedUIImage)
    } else {
        return nil
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(categoryName: "pants") // 傳入分類名稱
    }
}

#Preview {
    //    TestView()
    outfitGenerateView()
}
