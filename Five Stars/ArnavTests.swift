import SwiftUI

struct HomeScreen: View {
    @State private var currentImageIndex: Int = 0
    let bannerImages = ["Outfit_1", "Outfit_2", "Outfit_3", "Outfit_4", "Outfit_5"] // Replace with actual image names
    
    var body: some View {
        VStack(spacing: 20) {
            // Header Section
            HStack {
                Image("avatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                Text("👋🏻 Welcome back, Amy!")
                    .font(.headline)
                    .padding(.leading, 8)
                    .padding(.trailing, 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 99)
                            .stroke(Color.black, lineWidth: 1.5)
                            .frame(height: 40)
                    )
                Spacer()
            }
            .padding(.top, 24)
            .padding(.horizontal, 20)
            
            // Banner Section
            ZStack {
                ForEach(0..<bannerImages.count, id: \.self) { index in
                    Image(bannerImages[index])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 500) // Increased size for better visibility
                        .cornerRadius(20)
                        //.shadow(radius: 5)
                        .opacity(currentImageIndex == index ? 1 : 0)
                        .animation(.easeInOut, value: currentImageIndex)
                }
            }
            .frame(width: 350, height: 500) // Matches image height
            .padding(.horizontal)
            .padding(.top, 8)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
                    withAnimation {
                        currentImageIndex = (currentImageIndex + 1) % bannerImages.count
                    }
                }
            }
            
            // Speedometer Section
            HStack() {
                SpeedometerView()
                Spacer()
            }
                .padding(.horizontal, 20)
            
            
            
            Spacer()
        }
        .background(Color("AppBackground").ignoresSafeArea())
    }
}

// SpeedometerView remains the same
struct SpeedometerView: View {
    @State private var progress: Double = 0.0
    @State private var displayValue: Double = 0.0
    let targetProgress: Double = 0.71
    
    var displayColor: Color {
        switch displayValue * 100 {
        case 0...45:
            return .green
        case 46...65:
            return .yellow
        default:
            return .red
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 16) {
                Text("\(Int(displayValue * 100))")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(displayColor)
                Text("Total number of items in your closet!")
                    .font(.body)
                    .bold()
                    .foregroundColor(.black)
            }
//            Text("Total number of items in your collection")
//                .font(.body)
//                .foregroundColor(.black)
//                .multilineTextAlignment(.center)
//                //.padding(.horizontal, 40)
        }
        //.padding()
        .background(Color("SecondaryBackground"))
        .cornerRadius(15)
        //.shadow(radius: 5)
        //.padding(.horizontal)
        .onAppear {
            withAnimation(.easeInOut(duration: 2)) {
                progress = targetProgress
            }
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                if displayValue < targetProgress {
                    displayValue += 0.01
                } else {
                    timer.invalidate()
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
