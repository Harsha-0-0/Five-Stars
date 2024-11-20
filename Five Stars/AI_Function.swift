import SwiftUI
import GoogleGenerativeAI
import PhotosUI

struct AI_View: View {
    //    @State private var AI_response: GenerateContentResponse?
    @State private var analyzedResult:  [CandidateResponse] = []
    @State private var isAnalyzing: Bool = false
    let model = GenerativeModel(name: "gemini-1.5-flash", apiKey: "AIzaSyDu1cqIHQxGV9TcNG4L6jYejhuE_rGZkyk")
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    func AI() async{
        
        let imageRenderer1 = ImageRenderer(content: Image("BlackDress"))
        imageRenderer1.scale = 1.0
        guard let uiImage1 = imageRenderer1.uiImage else { return }
        
        let imageRenderer2 = ImageRenderer(content: Image("WhiteShirt"))
        imageRenderer2.scale = 1.0
        guard let uiImage2 = imageRenderer2.uiImage else { return }
        
        let imageRenderer3 = ImageRenderer(content: Image("BlackShirt"))
        imageRenderer3.scale = 1.0
        guard let uiImage3 = imageRenderer3.uiImage else { return }
        
        let imageRenderer4 = ImageRenderer(content: Image("BlackPant"))
        imageRenderer4.scale = 1.0
        guard let uiImage4 = imageRenderer4.uiImage else { return }
        
        let model = GenerativeModel(name: "gemini-1.5-pro", apiKey: "key")
        let prompt = "can you generate an outfit image from these pictures? I just want one outfit. Also return the name of the images you used to create the outfit."
        
        Task {
            do {
                let response = try await model.generateContent(prompt, uiImage1, uiImage2, uiImage3, uiImage4)
                
                if !response.candidates.isEmpty {
                    print("Response: \(response)")
                    
                    self.analyzedResult = response.candidates
                    self.isAnalyzing.toggle()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    var body: some View {
        VStack {
            Button {
                Task {
                    await AI()
                    
                }
            }label: {
                Text("Gemini")
            }
        }
    }
}

#Preview {
    AI_View()
}
