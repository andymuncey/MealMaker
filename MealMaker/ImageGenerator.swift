import ImagePlayground
import CoreGraphics

class ImageGenerator {
    
    var image: CGImage? = nil
    var generationError: String? = nil
    
    func generateImage(description: String) async {
       
        generationError = nil
        image = nil
        
        do {
            let creator = try await ImageCreator()
            let concept: ImagePlaygroundConcept = .text(description)
            let images = creator.images(for: [concept], style: .illustration, limit: 1)
            
            for try await generatedImage in images {
                self.image = generatedImage.cgImage
                
                break
            }
            
        } catch {
            generationError = "Image creation is not currently available on this device: \(error)"
        }
    }
    
    
}
