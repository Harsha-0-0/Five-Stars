//
//  MagicSetUp.swift
//  Five Stars
//
//  Created by Hazel Chen on 20/11/2024.
//
import SwiftUI

struct AIDresserView: View {
    @State private var currentStep: Int = 1 // Current step of the setup process

    var body: some View {
        VStack {
            if currentStep == 1 {
                AIDresser1Content(onNext: { currentStep = 2 })
            } else if currentStep == 2 {
                AIDresser2Content(onBack: { currentStep = 1 }, onNext: { currentStep = 3 })
            } else if currentStep == 3 {
                AIDresser3Content(onBack: { currentStep = 2 })
            }
        }
    }
}



struct AIDresserStepView: View {
    
    var step: Int
    var subtitle: String
    
    init(step: Int) {
           self.step = step
           self.subtitle = GetStepSubtitle(step) // Compute subtitle based on step
        print("Navigating to step \(step)")
        
       }
    
    var body: some View {
        VStack(spacing: 8) {
            Text("AI Dresser")
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(subtitle)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60)
                .frame(maxWidth: .infinity, alignment: .center)
            
        }
        .padding(.top, 40)
        
        let StepOneColor = GetStepColor(step, 1)
        let StepTwoColor = GetStepColor(step, 2)
        let StepThreeColor = GetStepColor(step, 3)
        
        
        // Step Indicator
        HStack(spacing: 0) {
            // step 1
            Circle()
                .fill(StepOneColor)
                .overlay(Text("1").foregroundColor(.black))
                .frame(width: 30, height: 30)
            
            Rectangle()
                .fill(Color("Gray_Bg"))
                .frame(height: 1)
                .overlay(
                    Rectangle()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [1, 4]))
                        .foregroundColor(.gray)
                )
                .frame(maxWidth: .infinity)
            
            // step 2
            Circle()
                .fill(StepTwoColor)
                .overlay(Text("2").foregroundColor(.black))
                .frame(width: 30, height: 30)
            
            
            Rectangle()
                .fill(Color("Gray_Bg"))
                .frame(height: 1)
                .overlay(
                    Rectangle()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [1, 4]))
                        .foregroundColor(.gray)
                )
                .frame(maxWidth: .infinity)
            
            // step 3
            Circle()
                .fill(StepThreeColor)
                .overlay(Text("3").foregroundColor(.black))
                .frame(width: 30, height: 30)
        }
        .frame(height: 30)
        .padding(.horizontal, 80)
        
        
//        Text("Pick an occasion now (optional)")
//            .font(.subheadline)
//        
        
    }
}


struct AIDresser1Content: View {
    let onNext: () -> Void
    
    @State var clothesArray: [Image] = []
//    @Binding var navigationPath: [Int]
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            
            AIDresserStepView(step: 1)
            Spacer()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                ForEach(0..<6, id: \.self) { index in
                    ZStack {
                        // Background with rounded corners
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            .background(RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.1)))
                            .frame(width: 112, height: 112)
                        
                        VStack {
                            if index == 5 { // Display "More..." for the last item
                                Text("More...")
                                    .font(.body)
                                    .foregroundColor(.black)
                            } else if index < clothesArray.count { // Display images for available items
                                clothesArray[index]
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 80)
                                    .foregroundColor(.gray)
                            } else { // Placeholder for empty slots
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .foregroundColor(.gray.opacity(0.5))
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            Button(action: {
                // Action for "Next"
//                print("Next pressed")
                onNext()
            }) {
                Text("Next")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("Primary"))
                    .cornerRadius(100)
            }.padding(.horizontal, 20)
            
            
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
        .padding(.bottom, 20)
        .onAppear {
            clothesArray = AddClothesArray("TShirts") // Populate array on appearance
        }
    }
}



struct AIDresser2Content: View {
    let OccasionArr1 = ["Uni", "Interview", "Smart Casual"]
    let OccasionArr2 = ["Wedding", "Date", "Party"]
    let OccasionArr3 = ["Daily", "Concert", "Bar"]
    @Environment(\.dismiss) var dismiss
//    @Binding var navigationPath: [Int]
    let onBack: () -> Void
        let onNext: () -> Void

    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            AIDresserStepView(step: 2)
            Spacer()
            
            HStack(alignment: .top, spacing: 8) {
                ForEach(OccasionArr1, id: \.self) { occasion in
                    Button(action: {
                        // Action for selecting the occasion
                        print("\(occasion) selected")
                    }) {
                        Text(occasion)
                            .font(.body)
                            .foregroundColor(.black)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 20)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(20)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .fixedSize(horizontal: true, vertical: false)
                }
            }
            HStack(alignment: .top, spacing: 8) {
                ForEach(OccasionArr2, id: \.self) { occasion in
                    Button(action: {
                        // Action for selecting the occasion
                        print("\(occasion) selected")
                    }) {
                        Text(occasion)
                            .font(.body)
                            .foregroundColor(.black)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 20)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(20)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .fixedSize(horizontal: true, vertical: false)
                }
            }
            HStack(alignment: .top, spacing: 8) {
                ForEach(OccasionArr3, id: \.self) { occasion in
                    Button(action: {
                        // Action for selecting the occasion
                        print("\(occasion) selected")
                    }) {
                        Text(occasion)
                            .font(.body)
                            .foregroundColor(.black)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 20)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(20)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .fixedSize(horizontal: true, vertical: false)
                }
            }
            
            
            Spacer()
                // Back and Next Buttons
                HStack(spacing: 8) {
                    Button(action: {
                        // Action for "Back"
        //                print(key)
                        onBack()
//                        dismiss()
                    }) {
                        Text("Back")
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.black)
                            .background(Color("Secondary"))
                            .cornerRadius(100)
                    }
                    Button(action: {
                        // Action for "Next"
                        onNext()
//                        navigationPath.append(3)
                    }) {
                        Text("Next")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("Primary"))
                            .cornerRadius(100)
                    }
                }
//                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            
            
        }
        .padding(12)
        .frame(width: 345, alignment: .topLeading)
    }
}

struct AIDresser3Content: View {
//    @Binding var navigationPath: [Int]
    @Environment(\.dismiss) var dismiss
    let onBack: () -> Void
    var body: some View {
        
        VStack (alignment: .leading, spacing: 40){
            
            AIDresserStepView(step: 3)
            Spacer()
            
            // Text Area
            TextEditor(text: .constant("Add more description here if you’d like..."))
                .frame(height: 200)
                .padding(.horizontal, 40)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1).padding(.horizontal, 28))
                .foregroundColor(Color.gray)
            
            
            Spacer()
            
            // Back and Next Buttons
            HStack(spacing: 8) {
                Button(action: {
                    // Action for "Back"
    //                print(key)
//                    dismiss()
                    onBack()
                }) {
                    Text("Back")
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color("Secondary"))
                        .cornerRadius(100)
                }
                NavigationLink(destination: Outfit_Generate()) {
                    Text("Next")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("Primary"))
                        .cornerRadius(100)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
       
    }
}


struct step3ButtonsBox: View {
    
    var step: Int
    
    var body: some View {
        // Back and Next Buttons
        HStack(spacing: 8) {
            Button(action: {
                // Action for "Back"
//                print(key)
            }) {
                Text("Back")
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color("Secondary"))
                    .cornerRadius(100)
            }
            Button(action: {
                // Action for "Next"
                print("Next pressed")
            }) {
                Text("Next")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("Primary"))
                    .cornerRadius(100)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}

//@ViewBuilder
//func ContentChooser(step: Int, navigationPath: Binding<[Int]>) -> some View {
//    switch step {
//    case 1:
//        AIDresser1Content(navigationPath: navigationPath)
//    case 2:
//        AIDresser2Content(navigationPath: navigationPath)
//    case 3:
//        AIDresser3Content(navigationPath: navigationPath)
//    default:
//        Text("Invalid step")
//            .foregroundColor(.red)
//    }
//}



//
//@ViewBuilder
//func PageChanger(_ step: Int) -> some View {
//    if step == 1 {
//        AIDresser1Content()
//    } else if step == 2 {
//        AIDresser2Content()
//    } else if step == 3 {
//        AIDresser3Content()
//    } else {
//        Text("Invalid step")
//            .foregroundColor(.red)
//            .font(.headline)
//    }
//}

#Preview {
    AIDresserView()
}

