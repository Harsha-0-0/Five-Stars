//
//  Magic.swift
//  Five Stars
//
//  Created by Hazel Chen on 20/11/2024.
//

import SwiftUI

struct MagicView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("AI Dresser")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.top, 60)
            
            // Subtitle
            Text("Let us help you visualise your imagination")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60)
                
            
            Spacer()
            
            // Buttons
            VStack(spacing: 20) {
                Button(action: {
                    // Action for "Generate Now"
                    print("Generate Now pressed")
                }) {
                    VStack (spacing: 12) {
                        Image(systemName: "sparkles") // Use appropriate icon
                            .font(.title)
                            .foregroundColor(Color("Nav_selected"))
                        Text("Generate Now")
                            .fontWeight(.medium)
                            .foregroundColor(Color("Nav_selected"))
                        Text("Let me create something for you.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 24)
                    .frame(maxWidth: .infinity)
                    .background(Color("Secondary"))
                    .cornerRadius(12)
                }
                
                Button(action: {
                    // Action for "Set up First"
                    print("Set up First pressed")
                }) {
                    VStack (spacing: 12){
                        Image(systemName: "pencil")
                            .font(.title)
                            .foregroundColor(Color("Nav_selected"))
                        Text("Set up First")
                            .fontWeight(.medium)
                            .foregroundColor(Color("Nav_selected"))
                        Text("Put some preference first")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 24)
                    .frame(maxWidth: .infinity)
                    .background(Color("Secondary"))
                    .cornerRadius(12)
                    
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
            
        }
    }
}

#Preview {
    MagicView()
}


