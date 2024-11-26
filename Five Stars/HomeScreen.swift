//import SwiftUI
//
//struct HomeScreen: View {
//    @State private var currentImageIndex: Int = 0
//    let bannerImages = ["Outfit_1", "Outfit_2"] // Replace with actual image names
//
//    var body: some View {
//        VStack(spacing: 20) {
//            // Header Section
//            HStack {
//                Image("avatar")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 50, height: 50)
//                    .clipShape(Circle())
//
//                Text("👋🏻 Welcome back, Amy!")
//                    .font(.headline)
//                    .padding(.leading, 8)
//                    .padding(.trailing, 20)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 99)
//                            .stroke(Color.black, lineWidth: 1.5)
//                            .frame(height: 40)
//                    )
//                Spacer()
//            }
//            .padding(.top, 24)
//            .padding(.horizontal, 20)
//
//            // Banner Section
//            ZStack {
//                ForEach(0..<bannerImages.count, id: \.self) { index in
//                    Image(bannerImages[index])
//                        .resizable()
//                        .scaledToFill()
//                        .frame(height: 350) // Increased size for better visibility
//                        .cornerRadius(20)
//                        .shadow(radius: 5)
//                        .opacity(currentImageIndex == index ? 1 : 0)
//                        .animation(.easeInOut, value: currentImageIndex)
//                }
//            }
//            .frame(height: 350) // Matches image height
//            .padding(.horizontal)
//            .onAppear {
//                Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
//                    withAnimation {
//                        currentImageIndex = (currentImageIndex + 1) % bannerImages.count
//                    }
//                }
//            }
//
//            // Speedometer Section
//            SpeedometerView()
//                .padding(.horizontal)
//
//            Spacer()
//        }
//        .background(Color("AppBackground").ignoresSafeArea())
//    }
//}
//
//// SpeedometerView remains the same
//struct SpeedometerView: View {
//    @State private var progress: Double = 0.0
//    @State private var displayValue: Double = 0.0
//    let targetProgress: Double = 0.77
//
//    var displayColor: Color {
//        switch displayValue * 100 {
//        case 0...45:
//            return .green
//        case 46...65:
//            return .yellow
//        default:
//            return .red
//        }
//    }
//
//    var body: some View {
//        VStack {
//            ZStack {
//                VStack(spacing: 12) {
//                    HStack(spacing: 16) {
//                        Text("\(Int(displayValue * 100))")
//                            .font(.largeTitle)
//                            .fontWeight(.bold)
//                            .foregroundColor(displayColor)
//                        Text("Items")
//                            .font(.title2)
//                            .foregroundColor(.gray)
//                    }
//                    Text("Total number of items in your collection")
//                        .font(.body)
//                        .foregroundColor(.secondary)
//                        .multilineTextAlignment(.center)
//                        .padding(.horizontal, 40)
//                }
//                .padding()
//                .background(Color("SecondaryBackground"))
//                .cornerRadius(15)
//                .shadow(radius: 5)
//                .padding(.horizontal)
//            }
//            .padding()
//        }
//        .onAppear {
//            withAnimation(.easeInOut(duration: 2)) {
//                progress = targetProgress
//            }
//            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
//                if displayValue < targetProgress {
//                    displayValue += 0.01
//                } else {
//                    timer.invalidate()
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
