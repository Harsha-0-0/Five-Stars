import SwiftUI

// MARK: - Clothing Model



// MARK: - Clothing ViewModel



// MARK: - FilterView
import SwiftUI

struct FilterView: View {
    @State private var viewModel = ClothingViewModel()
    @State var selectedCategory: String = "All"
    @State var selectedQuality: String = "All"
    @State var selectedColor: String = "All"
    @State private var searchText = ""
    let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 200))
    ]
    @Binding var selectedTab: Int  // Binding to control the tab selection

    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
        // Customize the appearance of the back button
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
//        appearance.backButtonAppearance.normal.iconColor = .black
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color("LightBlue"), Color("LightPurple")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack(alignment: .leading) {
                    // Filters Section
                    DisclosureGroup(
                        content: {
                            VStack(spacing: 12) {
                                filterRow(label: "Category", selection: $selectedCategory, options: ["All", "Tops", "Bottoms", "Outerwear", "Footwear"])
                                filterRow(label: "Color", selection: $selectedColor, options: ["All", "Blue", "Black", "Red", "White"])
                                filterRow(label: "Quality", selection: $selectedQuality, options: ["All", "High", "Medium", "Low"])
                            }
                            .padding()
                        },
                        label: {
                            Text("Filters")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    )
                    .accentColor(.white) // Arrow color
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(15)
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

                            // Display message for empty results
                            if filteredItems.isEmpty {
                                Text("No items found")
                                    .foregroundColor(.gray)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .center)
                            } else {
                                // Group filtered items by category
                                let groupedItems = Dictionary(grouping: filteredItems) { $0.category }

                                ForEach(groupedItems.keys.sorted(), id: \.self) { category in
                                    if let items = groupedItems[category] {
                                        Section(header: Text(category)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(.leading)) {
                                                LazyVGrid(columns: columns, spacing: 16) {
                                                    ForEach(items) { item in
                                                        NavigationLink(destination: ItemDetail(item: item)) {
                                                            VStack {
                                                                Image(item.image)
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(height: 100)
                                                                    .cornerRadius(8)
                                                            }
                                                            .padding()
                                                            .background(Color.white.opacity(0.8))
                                                            .cornerRadius(15)
                                                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y: 2)
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
                    .searchable(
                        text: $searchText,
                        placement: .automatic,
                        prompt: "Search for clothing..."
                    )
                    .tint(.white) // Customize the color of the text and cursor
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                }
                .navigationTitle("Digital Wardrobe")
                .foregroundColor(.white)
                .toolbar {
                    // Custom Back Button with text
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            // Go back to the Home Screen by selecting the first tab
                            selectedTab = 0
                        }) {
                            HStack {
                                Image(systemName: "chevron.left") // Back arrow
                                    .foregroundColor(.black)
                                Text("Back")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Filter Row Helper
    private func filterRow(label: String, selection: Binding<String>, options: [String]) -> some View {
        HStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Picker(label, selection: selection) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(10)
            .background(Color.white.opacity(0.15))
            .cornerRadius(8)
            .foregroundColor(.white)
        }
        .padding(8)
        .background(Color.white.opacity(0.15))
        .cornerRadius(10)
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
//
//#Preview {
//    FilterView()
//}
