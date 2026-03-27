import FoundationModels
import SwiftUI

@Observable class SimpleGenerator {
    
    private(set) var idea: String?
    private(set) var error: String?
    
    func generate() async {
      
        error = nil
        idea = nil
        
        if !SystemLanguageModel.default.isAvailable {
            return
        }
   
        do {
            let session = LanguageModelSession()
            let prompt = "I've just graduated from university of Chester, what can I do to celebrate, in or around Chester?"
            let response = try await session.respond(to: prompt)
            idea = response.content
            error = nil
        }
        catch LanguageModelSession.GenerationError.guardrailViolation(let context){
            self.error = "Unable to geneate response for safety reasons: \(context.debugDescription)"
        }
        catch {
            self.error = "Unable to generate response"
        }
        
    }
    
    
}

