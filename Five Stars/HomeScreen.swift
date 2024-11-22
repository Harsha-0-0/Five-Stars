import SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationStack {
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 131, height: 22)
                .padding(.top, 12)
            
            HStack {
                Image("avatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text(" 👋🏻 Welcome back, Amy!")
                    .font(.headline)
                    .padding(.leading, 8)
                    .padding(.trailing, 20)
                    .overlay(
                                        RoundedRectangle(cornerRadius: 99)
                                            .stroke(Color.black, lineWidth: 1.5)
                                            .frame(height: 40)// Border color and width
                                    )
                Spacer()
            }
            .padding(.top, 24)
            .padding(.horizontal, 20)// Optional: Adds padding to the top of the HStack
            //Spacer() // Optional: Adds space to push content to the top
        
        
        VStack(alignment: .leading) {
//            Text("Outfit of The Day")
//                .padding(.top)
//                .font(.title)
//                .fontWeight(.bold)
            
            NavigationLink(destination: Outfit_Generate()) {
                Image("OutfitButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 380, height: 200)
                    .padding(.top)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
//            Text("Your Digital Wardrobe")
//                .padding(.top)
//                .font(.title)
//                .fontWeight(.bold)
            
            NavigationLink(destination: FilterView()) {
                Image("WardrobeButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 380, height: 200)
                    .padding(.top, 8)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
                //.navigationTitle("Your Wardrobe")
            
        }
        .padding(.horizontal, 20)
        Spacer()

        }
                }
}

#Preview {
    HomeScreen()
}
