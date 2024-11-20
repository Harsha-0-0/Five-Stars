import SwiftUI

struct Outfit: Identifiable {
    var id = UUID()
    var name: String
    var category: String
    var quality: String
    var color: String
    var imageName: String  // Name of the image file (should be added to assets)
}

struct FilterView: View {
    @State  var selectedCategory: String = "All"
    @State  var selectedQuality: String = "All"
    @State  var selectedColor: String = "All"
    
    let outfits: [Outfit] = [
        Outfit(name: "Casual Shirt", category: "Tops", quality: "High", color: "Blue", imageName: "BlackDress"),
        Outfit(name: "Jeans", category: "Bottoms", quality: "Medium", color: "Black", imageName: "BlackDress"),
        Outfit(name: "Leather Jacket", category: "Outerwear", quality: "High", color: "Brown", imageName: "BlackPant"),
        Outfit(name: "T-shirt", category: "Tops", quality: "Low", color: "Red", imageName: "WhiteDress"),
        Outfit(name: "Sneakers", category: "Footwear", quality: "High", color: "White", imageName: "BlackPant"),
        Outfit(name: "Shorts", category: "Bottoms", quality: "Low", color: "Blue", imageName: "WhiteDress"),
        Outfit(name: "Casual Shirt", category: "Tops", quality: "High", color: "Blue", imageName: "WhiteDress"),
        Outfit(name: "Jeans", category: "Bottoms", quality: "Medium", color: "Black", imageName: "WhiteDress"),
        Outfit(name: "Leather Jacket", category: "Outerwear", quality: "High", color: "Brown", imageName: "WhiteDress"),
        Outfit(name: "T-shirt", category: "Tops", quality: "Low", color: "Red", imageName: "WhiteDress"),
        Outfit(name: "Sneakers", category: "Footwear", quality: "High", color: "White", imageName: "WhiteDress"),
        Outfit(name: "Shorts", category: "Bottoms", quality: "Low", color: "Blue", imageName: "WhiteDress")
    ]
    
    var filteredOutfits: [Outfit] {
        outfits.filter { outfit in
            (selectedCategory == "All" || outfit.category == selectedCategory) &&
            (selectedQuality == "All" || outfit.quality == selectedQuality) &&
            (selectedColor == "All" || outfit.color == selectedColor)
        }
    }

    // Define fixed size for each column in the grid
    let columns = [
        GridItem(.adaptive(minimum: 90, maximum: 200)),
       // GridItem(.adaptive(minimum: 80, maximum: 150)),
       // GridItem(.adaptive(minimum: 80, maximum: 150)),
    ]
    
    
    var body: some View {
        
        DisclosureGroup("Filters"){
            
                
                    
                        // Filters Section
                        HStack {
                            Text("Categories")
                            Spacer()
                            // Category Filter
                            Picker("Category", selection: $selectedCategory) {
                                Text("All").tag("All")
                                Text("Shirts").tag("Tops")
                                Text("T-Shirts").tag("Bottoms")
                                Text("Jackets").tag("Outerwear")
                                Text("Pants").tag("Footwear")
                                Text("Dresses").tag("Footwear")
                                Text("Shoes").tag("Footwear")

                            }
                            .pickerStyle(MenuPickerStyle()) // Use segmented style
                            .foregroundStyle(Color.black)
                            //.padding()
                            .background(Color.green.opacity(0.1)) // Background for the picker
                            .cornerRadius(8) // Rounded corners
                            //.shadow(color: .gray.opacity(1), radius: 4, x: 0, y: 2) // Add a shadow
                            .padding(0)
                        }
                        .padding(8)

           
            HStack{
                Text("Material")
                Spacer()
                Picker("Color", selection: $selectedColor) {
                    Text("All").tag("All")
                    Text("Blue").tag("Blue")
                    Text("Black").tag("Black")
                    Text("Brown").tag("Brown")
                    Text("Red").tag("Red")
                    Text("White").tag("White")
                }
                .pickerStyle(MenuPickerStyle())
                .background(Color.green.opacity(0.1)) // Background for the picker
                .cornerRadius(8) // Rounded corners
                .padding(0)
            }
            .padding(8)
            
            HStack{
                Text("Quality")
                Spacer()
                Picker("Quality", selection: $selectedQuality) {
                    Text("All").tag("All")
                    Text("High").tag("High")
                    Text("Medium").tag("Medium")
                    Text("Low").tag("Low")
                }
                .pickerStyle(MenuPickerStyle())
                .background(Color.green.opacity(0.1)) // Background for the picker
                .cornerRadius(8) // Rounded corners
                .padding(0)
            }
            .padding(8)
            
        }
        .padding(16)
        .foregroundStyle(Color.black)
        
            
        
            
        
        ScrollView {
                // Grid View for Filtered Outfits
            LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
                    ForEach(filteredOutfits) { outfit in
                        VStack (alignment: .leading) {
                            Image(outfit.imageName)
                                .resizable()
                                .scaledToFill()
                                //.frame(width: 100, height: 100)
                                .cornerRadius(8)
                                
//                            Text(outfit.name)
//                                .font(.headline)
//
//                            Text("Category: \(outfit.category)")
//                                .font(.subheadline)
//
//                            Text("Quality: \(outfit.quality)")
//                                .font(.subheadline)
//
//                            Text("Color: \(outfit.color)")
//                                .font(.subheadline)
                        }
                        //.padding(0)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                        
                    }
                }
            //.frame(maxWidth: 400)
            // Adjust padding around the entire LazyVGrid for less spacing on sides
               .padding(.horizontal, 20) // Decrease left and right padding
            
        }
        
    }
}

#Preview {
    FilterView()
}

