import FoundationModels
import SwiftUI

@Observable class MealGenerator {
    
    private var session = LanguageModelSession()
    private(set) var meal: Meal? = nil
    private(set) var error: String?
    
    func generate(ingredients: [String]) async {
      
        let aiModel = SystemLanguageModel.default
        if !aiModel.isAvailable {
            error = "No Apple Intelligence model available, reason: \(aiModel.availability)"
            return
        } else {
            error = nil
        }
        
        meal = nil
        do {
            let prompt = "Suggest a recipe that will use some, or all of these ingredients: \(ingredients). You can suggest meals that use a few commonly available ingredients."
            let response = try await session.respond(to: prompt, generating: Meal.self)
            meal = response.content

        }
        catch LanguageModelError.guardrailViolation(let context){
            self.error = "Unable to geneate meal for safety reasons: \(context.debugDescription)"
        }
        catch {
            self.error = "Unable to generate meal"
        }
        
    }
    
    
}

