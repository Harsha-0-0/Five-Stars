import SwiftUI

struct HomeScreen: View {
    @Binding var selectedTab: Int
    var body: some View {
        NavigationStack {
            VStack {
                // Logo Section
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 131, height: 22)
                    .padding(.top, 16)

                // Welcome Section
                HStack {
                    Image("avatar")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .shadow(radius: 4)

                    Text("👋🏻 Welcome back, Amy!")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.leading, 12)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 2)
                        )
                    Spacer()
                }
                .padding(.top, 24)
                .padding(.horizontal, 20)

                Spacer()

                // Buttons Section
                VStack(spacing: 16) {
                    Button(action: {
                        selectedTab = 2
                        // Switch to Wardrobe tab
                    }) {
                        Image("OutfitButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 360, height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                    }
                    Button(action: {
                        selectedTab = 1 // Switch to Wardrobe tab
                    }){
                        Image("WardrobeButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 360, height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.05)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
        }
    }
}
