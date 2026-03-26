import FoundationModels
import SwiftUI

@Observable class SimpleGenerator {
    
    private var session = LanguageModelSession()
    private(set) var idea: String?
    private(set) var error: String?
    
    func generate() async {
      
        error = nil
        idea = nil
        let aiModel = SystemLanguageModel.default
        if !aiModel.isAvailable {
            //model not available
            return
        }
   
        do {
            let prompt = "Suggest something to do to celebrate finishing my studies at the University of Chester. Local ideas would be great"
            let response = try await session.respond(to: prompt)
            idea = response.content
            error = nil
        }
        catch LanguageModelSession.GenerationError.guardrailViolation(let context){
            self.error = "Unable to geneate meal for safety reasons: \(context.debugDescription)"
        }
        catch {
            self.error = "Unable to generate meal"
        }
        
    }
    
    
}

