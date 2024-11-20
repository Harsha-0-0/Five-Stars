//
//  Outfit_Generate.swift
//  Five Stars
//
//  Created by Harsha Varthini Maniraj on 20/11/2024.
//

import SwiftUI

struct Cloth: Identifiable {
    var id = UUID()
    var image: Image
    var isSelected: Bool = false
}
struct Outfit_Generate: View {
    @State var clothingItems: [Cloth] = [
        Cloth(image: Image("shirt_01"), isSelected: false),
        Cloth(image: Image("shirt_02"), isSelected: false),
        Cloth(image: Image("shirt_03"), isSelected: false),
        // ... add more clothing items as needed
    ]
    @State var pants: [Cloth] = [
        Cloth(image: Image("pants_01"), isSelected: false),
        Cloth(image: Image("pants_02"), isSelected: false),
        Cloth(image: Image("pants_03"), isSelected: false),
        // ... add more clothing items as needed
    ]
    @State var shoes: [Cloth] = [
        Cloth(image: Image("shoes_01"), isSelected: false),
        Cloth(image: Image("shoes_01"), isSelected: false),
        Cloth(image: Image("shoes_01"), isSelected: false),
        // ... add more clothing items as needed
    ]
    @State private var currentCloth: Cloth?
    @State private var currentPant: Cloth?
    @State private var currentShoe: Cloth?
    @State private var selectedItem: Cloth?
    @State private var showSwapOptions: Bool = false
    @State private var showSwapPantOptions: Bool = false
    @State private var showSwapShoeOptions: Bool = false
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("AI Dresser")
                    .font(.title)
                    .padding(.top)
                
                Text("Shuffle with the Button, or Manually Swap Specific Pieces by Selecting")
                    .font(.headline)
                    .foregroundStyle(.navDefault)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                ZStack {
                    Rectangle().fill(.yellowBg)
                    VStack() {
                        // Button to randomly pick a clothing item
                        Button {
                            // Randomly pick a clothing item
                            currentCloth = clothingItems.randomElement()
                            
                            // Ensure currentCloth is not nil
                            guard let currentCloth = currentCloth else { return }
                            
                            // Find the index of the current cloth
                            if let index = clothingItems.firstIndex(where: { $0.id == currentCloth.id }) {
                                // Update the isSelected property of the item
                                clothingItems[index].isSelected.toggle()
                                
                                // Optionally update other state variables
                                selectedItem = clothingItems[index]
                                showSwapOptions = true
                            }
                        } label: {
                            currentCloth?.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .padding()
                                .frame(width: min(geometry.size.width * 0.7, 200), height: min(geometry.size.height * 0.3, 200))
                            
                            
                        }
                        
                        .onAppear {
                            // Optionally show a random item when the view appears
                            currentCloth = clothingItems.randomElement()
                        }
                        
                        
                        
                        // Button to randomly pick a clothing item
                        Button () {
                          
                            showSwapPantOptions = true
                            
                            //                            }
                        } label: {
                            @State var current = pants.randomElement()
                            current?.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .padding()
                                .frame(width: min(geometry.size.width * 0.7, 200), height: min(geometry.size.height * 0.3, 200))
                            
                            
                        }
                        
                        .onAppear {
                            // Optionally show a random item when the view appears
                            currentPant = pants.randomElement()
                        }
                        
                        
                        
                        // Button to randomly pick a clothing item
                        Button {
                            // Randomly pick a clothing item
                            currentShoe = shoes.randomElement()
                            
                            // Ensure currentCloth is not nil
                            guard let currentShoe = currentShoe else { return }
                            
                            // Find the index of the current cloth
                            if let index = shoes.firstIndex(where: { $0.id == currentShoe.id }) {
                                // Update the isSelected property of the item
                                shoes[index].isSelected.toggle()
                                
                                // Optionally update other state variables
                                selectedItem = shoes[index]
                                showSwapShoeOptions = true
                            }
                        } label: {
                            currentShoe?.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .padding()
                                .frame(width: min(geometry.size.width * 0.7, 200), height: min(geometry.size.height * 0.3, 200))
                            
                            
                        }
                        
                        .onAppear {
                            // Optionally show a random item when the view appears
                            currentShoe = shoes.randomElement()
                        }
                        if showSwapOptions && !showSwapPantOptions && !showSwapShoeOptions{
                            SwapOptionsView(selectedItem: $selectedItem, clothingItems: $clothingItems) {
                                showSwapOptions = false
                            }
                        }
                        else if showSwapPantOptions && !showSwapOptions && !showSwapShoeOptions{
                            SwapPantsView(pants: $pants, clothingItems: $pants) {
                                showSwapPantOptions = false
                            }
                        }
                        else if showSwapShoeOptions && !showSwapPantOptions && !showSwapOptions{
                            SwapShoesView(selectedItem: $selectedItem, clothingItems: $shoes){
                                showSwapShoeOptions = false
                            }
                        }
                    }
                    
                    
                }.frame(maxHeight: geometry.size.height)
                
                
                Spacer(minLength: 30)
                HStack(spacing: 20) {
                    Button {
                        // Implement restart logic here
                    } label: {
                        Label("Restart", systemImage: "arrow.clockwise")
                            .labelStyle(CustomTextBeforeIconStyle())
                        
                            .foregroundStyle(.black)
                        
                    }
                    
                    .buttonStyle(.borderedProminent)
                    
                    .clipShape(Capsule())
                    Button {
                        // Implement shuffle logic here
                        currentCloth = clothingItems.randomElement()
                        currentPant = pants.randomElement()
                        currentShoe = shoes.randomElement()
                    } label: {
                        Label("Shuffle", systemImage: "shuffle")
                            .labelStyle(CustomTextBeforeIconStyle())
                    }
                    .buttonStyle(.borderedProminent)
                    .clipShape(Capsule())
                }
                .padding(.bottom)
                .scaledToFit()
                
                
            }
            .frame(maxHeight: geometry.size.height)
            
        }
        
    }
}
struct SwapOptionsView: View {
    @Binding var selectedItem: Cloth?
    @Binding var clothingItems: [Cloth]
    @Environment(\.dismiss) var dismiss
    var onDismiss: () -> Void
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Swap it with...")
                    .font(.title2)
                    .padding()
                Button {
                    onDismiss()
                }label:{
                    Image(systemName: "xmark.circle.fill")
                }
            }
            
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(clothingItems, id: \.id) { item in
                        if item.id != selectedItem?.id {
                            Button {
                                // Implement swap logic here, updating the selectedItem's image
                            } label: {
                                item.image
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
            }
            
        }
        
        .padding()
        
        .background(Color.gray.opacity(0.2))
        
        .cornerRadius(10)
        
    }
}
struct SwapPantsView: View {
    @Binding var pants: [Cloth]
    @Binding var clothingItems: [Cloth]
    @Environment(\.dismiss) var dismiss
    var onDismiss: () -> Void
    
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Swap it with...")
                    .font(.title2)
                    .padding()
                Button {
                    onDismiss()
                }label:{
                    Image(systemName: "xmark.circle.fill")
                }
            }
            
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    var selectedItem = pants.randomElement()
                    ForEach(clothingItems, id: \.id) { item in
                        if item.id != selectedItem?.id {
                            Button {
                                // Ensure both selectedItem and clothingItems are not nil
                                guard let selectedPant = selectedItem else { return }
                                
                                // Find the index of the selected pant
                                if let selectedIndex = clothingItems.firstIndex(where: { $0.id == selectedPant.id }) {
                                    // Swap logic: Replace the selected item with the chosen item
                                    clothingItems[selectedIndex] = item
                                    // Update selectedItem to reflect the new choice
                                    selectedItem = item
                                    // Call onDismiss to close the view
                                    onDismiss()
                                }
                            } label: {
                                item.image
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
struct SwapShoesView: View {
    @Binding var selectedItem: Cloth?
    @Binding var clothingItems: [Cloth]
    @Environment(\.dismiss) var dismiss
    var onDismiss: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("Swap it with...")
                    .font(.title2)
                    .padding()
                Button {
                    onDismiss()
                }label:{
                    Image(systemName: "xmark.circle.fill")
                }
            }
            
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(clothingItems, id: \.id) { item in
                        if item.id != selectedItem?.id {
                            Button {
                                // Implement swap logic here, updating the selectedItem's image
                            } label: {
                                item.image
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
struct CustomTextBeforeIconStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

#Preview {
    Outfit_Generate()
}
