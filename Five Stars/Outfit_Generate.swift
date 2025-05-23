import SwiftUI

// MARK: - Data Models
struct Cloth: Identifiable {
    var id = UUID()
    var image: Image
    var isSelected: Bool = false
}

struct Items: Codable {
    let name: String
    let description: String
    let color: String
}

struct Wardrobes: Codable {
    let dress: [Items]
    let jackets: [Items]
    let pants: [Items]
    let shirts: [Items]
    let shoes: [Items]
    let TShirts: [Items]
}

struct WardrobeDatas: Codable {
    let wardrobe: Wardrobes
}

// MARK: - Model
class Model: ObservableObject {
    @Published var tops: [Items] = []
    @Published var pants: [Items] = []
    @Published var shoes: [Items] = []
    @Published var topImage: [Cloth] = []
    @Published var pantsImage: [Cloth] = []
    @Published var shoesImage: [Cloth] = []
    
    func loadWardrobeData() -> Wardrobes? {
        if let path = Bundle.main.path(forResource: "wardrobe", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            let decoder = JSONDecoder()
            return try? decoder.decode(WardrobeDatas.self, from: data).wardrobe
        }
        return nil
    }
    
    func loadAllCategories() {
        if let wardrobe = loadWardrobeData() {
            pants = wardrobe.pants
            pantsImage = pants.map { Cloth(image: Image($0.name)) }
            tops = wardrobe.TShirts
            topImage = tops.map { Cloth(image: Image($0.name)) }
            shoes = wardrobe.shoes
            shoesImage = shoes.map { Cloth(image: Image($0.name)) }
        }
    }
}

// MARK: - Main View
struct Outfit_Generate: View {
    @StateObject var model = Model()
    
    @State var currentCloth: Cloth? = nil
    @State var currentPant: Cloth? = nil
    @State var currentShoe: Cloth? = nil
    @State var showSwapTopOptions: Bool = false
    @State var showSwapPantOptions: Bool = false
    @State var showSwapShoeOptions: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Title
                Text("AI Dresser")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Spacer(minLength: 10)
                
                // Subtitle
                Text("Shuffle with the Button, or Manually Swap Specific Pieces by Selecting")
                    .font(.title3)
                    .foregroundStyle(.navDefault)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .lineLimit(2)
                
                Spacer(minLength: 20)
                
                // Dynamic Rectangle and Buttons
                ZStack {
                    let rectangleHeight: CGFloat = showSwapTopOptions || showSwapPantOptions || showSwapShoeOptions ? 350 : 450
                    
                    Rectangle()
                        .fill(.yellowBg)
                        .frame(width: geometry.size.width * 0.9, height: rectangleHeight)
                        .cornerRadius(10)
                    
                    VStack(spacing: -60) {
                        let buttonHeight = rectangleHeight / 2.8
                        
                        // Button for shirts
                        Button {
                            showSwapTopOptions.toggle()
                        } label: {
                            currentCloth?.image
                                .resizable()
                                .scaledToFit()
                                .frame(height: buttonHeight)
                                .clipShape(Rectangle())
                        }
                        .onAppear {
                            model.loadAllCategories()
                            currentCloth = model.topImage.randomElement()
                        }
                        
                        // Button for pants
                        Button {
                            showSwapPantOptions.toggle()
                        } label: {
                            currentPant?.image
                                .resizable()
                                .scaledToFit()
                                .frame(height: buttonHeight)
                                .clipShape(Rectangle())
                        }
                        .onAppear {
                            model.loadAllCategories()
                            currentPant = model.pantsImage.randomElement()
                        }
                        
                        // Button for shoes
                        Button {
                            showSwapShoeOptions.toggle()
                        } label: {
                            currentShoe?.image
                                .resizable()
                                .scaledToFit()
                                .frame(height: buttonHeight)
                                .clipShape(Rectangle())
                        }
                        .onAppear {
                            model.loadAllCategories()
                            currentShoe = model.shoesImage.randomElement()
                        }
                    }
                }
                .animation(.easeInOut, value: showSwapTopOptions || showSwapPantOptions || showSwapShoeOptions)
                
                Spacer(minLength: 20)
                
                // Swap Views (Capped Heights)
                if showSwapTopOptions {
                    SwapTopView(
                        tops: $model.topImage,
                        onDismiss: { showSwapTopOptions = false },
                        onSelectTop: { newTop in
                            currentCloth = newTop
                        }
                    )
                    .frame(maxHeight: 250) // Cap the height
                    .transition(.move(edge: .bottom))
                }
                
                if showSwapPantOptions {
                    SwapPantsView(
                        pants: $model.pantsImage,
                        onDismiss: { showSwapPantOptions = false },
                        onSelectPant: { newPant in
                            currentPant = newPant
                        }
                    )
                    .frame(maxHeight: 250) // Cap the height
                    .transition(.move(edge: .bottom))
                }
                
                if showSwapShoeOptions {
                    SwapShoeView(
                        shoes: $model.shoesImage,
                        onDismiss: { showSwapShoeOptions = false },
                        onSelectShoe: { newShoe in
                            currentShoe = newShoe
                        }
                    )
                    .frame(maxHeight: 250) // Cap the height
                    .transition(.move(edge: .bottom))
                }
                
                Spacer(minLength: 20)
                
                // Shuffle Button
                if !showSwapTopOptions && !showSwapPantOptions && !showSwapShoeOptions {
                                    Button {
                                        currentCloth = model.topImage.randomElement()
                                        currentPant = model.pantsImage.randomElement()
                                        currentShoe = model.shoesImage.randomElement()
                                    } label: {
                                        Label("Shuffle", systemImage: "shuffle")
                                            .fontWeight(.medium)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color("Primary"))
                                            .cornerRadius(100)
                                    }
                                    .padding(.horizontal, 20)
                                    .clipShape(Capsule())
                                }
                
                Spacer(minLength: 30)
            }
            .frame(width: geometry.size.width, height: geometry.size.height) // Ensure it fits within the screen
        }
    }
}


// MARK: - Swap Pants View
struct SwapPantsView: View {
    @Binding var pants: [Cloth]
    var onDismiss: () -> Void
    var onSelectPant: (Cloth) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("Swap it with...")
                    .font(.title2)
                    .padding()
                
                Button {
                    onDismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(pants) { pant in
                        Button {
                            // Call the onSelectPant closure to swap the pant
                            onSelectPant(pant)
                            onDismiss()
                        } label: {
                            pant.image
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

// MARK: - Swap Top View
struct SwapTopView: View {
    @Binding var tops: [Cloth]
    var onDismiss: () -> Void
    var onSelectTop: (Cloth) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("Swap it with...")
                    .font(.title2)
                    .padding()
                
                Button {
                    onDismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(tops) { top in
                        Button {
                            // Call the onSelectTop closure to swap the top
                            onSelectTop(top)
                            onDismiss()
                        } label: {
                            top.image
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

// MARK: - Swap Shoe View
struct SwapShoeView: View {
    @Binding var shoes: [Cloth]
    var onDismiss: () -> Void
    var onSelectShoe: (Cloth) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("Swap it with...")
                    .font(.title2)
                    .padding()
                
                Button {
                    onDismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(shoes) { shoe in
                        Button {
                            // Call the onSelectShoe closure to swap the shoe
                            onSelectShoe(shoe)
                            onDismiss()
                        } label: {
                            shoe.image
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

// MARK: - Custom Label Style
struct CustomTextBeforeIconStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

// MARK: - Preview
#Preview {
    Outfit_Generate()
}
