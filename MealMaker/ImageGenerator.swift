import ImagePlayground
import CoreGraphics
import SwiftUI

@Observable class ImageGenerator {
    
    var image: CGImage? = nil
    var generationError: String? = nil
    var isGenerating: Bool = false
    
    func generateImage(description: String) async {
        isGenerating = true
        generationError = nil
        image = nil
        defer { isGenerating = false }
        
        do {
            let creator = try await ImageCreator()
            let concept: ImagePlaygroundConcept = .text(description)
            let images = creator.images(for: [concept], style: .any, limit: 1)
            
            for try await generatedImage in images {
                self.image = generatedImage.cgImage
                break
            }
            
            if self.image == nil {
                generationError = "No image was generated."
            }
        } catch {
            generationError = "Image creation is not currently available on this device: \(error.localizedDescription)"
        }
    }
}
