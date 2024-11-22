import SwiftUI

// MARK: - Clothing Model



// MARK: - Clothing ViewModel



// MARK: - FilterView

struct FilterView: View {
    @State private var viewModel = ClothingViewModel()
    @State var selectedCategory: String = "All"
    @State var selectedQuality: String = "All"
    @State var selectedColor: String = "All"
    @State private var searchText = ""
    let columns = [
        GridItem(.adaptive(minimum: 90, maximum: 200))
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Filters
                DisclosureGroup("Filters") {
                    HStack {
                        Text("Categories")
                        Spacer()
                        Picker("Category", selection: $selectedCategory) {
                            Text("All").tag("All")
                            Text("Shirts").tag("Tops")
                            Text("T-Shirts").tag("Bottoms")
                            Text("Jackets").tag("Outerwear")
                            Text("Pants").tag("Bottoms")
                            Text("Shoes").tag("Footwear")
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding(8)
                    
                    HStack {
                        Text("Color")
                        Spacer()
                        Picker("Color", selection: $selectedColor) {
                            Text("All").tag("All")
                            Text("Blue").tag("Blue")
                            Text("Black").tag("Black")
                            Text("Red").tag("Red")
                            Text("White").tag("White")
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding(8)
                    
                    HStack {
                        Text("Quality")
                        Spacer()
                        Picker("Quality", selection: $selectedQuality) {
                            Text("All").tag("All")
                            Text("High").tag("High")
                            Text("Medium").tag("Medium")
                            Text("Low").tag("Low")
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding(8)
                }
                .padding(.top, 8)
                .padding(.horizontal, 16)
                
                // Grid of Clothing Items
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        let filteredItems = viewModel.getFilteredOutfits(
                            category: selectedCategory,
                            quality: selectedQuality,
                            color: selectedColor,
                            searchText: searchText
                        )
                        
                        // Check if no items match
                        if filteredItems.isEmpty {
                            Text("No items found")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            // Group filtered items by category
                            let groupedItems = Dictionary(grouping: filteredItems) { $0.category }
                            
                            // Iterate through groups and display items in grid
                            ForEach(groupedItems.keys.sorted(), id: \.self) { category in
                                if let items = groupedItems[category] {
                                    Section(header: Text(category).font(.headline).padding(.leading)) {
                                        LazyVGrid(columns: columns, spacing: 16) {
                                            ForEach(items) { item in
                                                NavigationLink(destination: ItemDetail(item: item)) {
                                                    VStack {
                                                        Image(item.image) // Display the item image
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(height: 100)
                                                            .cornerRadius(8)
                                                    }
                                                    .padding()
                                                    .background(Color.green.opacity(0.1))
                                                    .cornerRadius(10)
                                                }
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .searchable(text: $searchText, prompt: "Search for clothing...")
                .navigationTitle("Digital Wardrobe")
            }
        }
    }
}

// MARK: - ItemDetail

struct ItemDetail: View {
    let item: Clothing
    @State private var selectedColor: String = "Black"
    @State private var selectedSeason: String = "Spring"
    @State private var selectedOccasion: String = "Daily"
    
    var body: some View {
        ScrollView {
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
                            ForEach(item.color, id: \.self) { color in
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
    FilterView()
}
