import SwiftUI

struct GeneratedImageView: View {
    
    var description: String
    @State private var imageGenerator = ImageGenerator()
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
            await imageGenerator.generateImage(description: description)
            if let generatedImage = imageGenerator.image {
                image = Image.init(generatedImage, scale: 1, label: Text(description))
            }
        }
        .padding()
    }
    
}

#Preview {
    GeneratedImageView(description: "Sausages and mashed potato with gravy")
}

