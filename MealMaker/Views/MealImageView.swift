import SwiftUI
import ImagePlayground

struct MealImageView: View {
    
    var description: String
    @State private var image: Image? = nil
    
    var body: some View {
        VStack {
            
            if let image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300, maxHeight: 300)
                    .padding()
            } else {
                Text("Generating")
                ProgressView()
                    
            }
        }.task {
            await generateImage()
        }
        .padding()
    }
    
    func generateImage() async {
       
        
        
        do {
            let creator = try await ImageCreator()
            let images = creator.images(for: [.text(description)], style: .illustration, limit: 1)
            
            
            for try await image in images {
                let anImage = image.cgImage
                self.image = Image(anImage, scale: 1, label: Text(description))
                break
            }
                   
            
            
        } catch {
            print("Error generating image:", error)
        }
    }
}

#Preview {
    ContentView()
}

