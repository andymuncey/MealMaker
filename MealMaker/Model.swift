import FoundationModels
import SwiftUI

@Observable class Model {
    
    var aiModel = SystemLanguageModel.default//( guardrails: .permissiveContentTransformations)
    
   
    var session = LanguageModelSession()
    
    var meal: Meal? = nil
    

    func generate(ingredients: [String]) async {
      
        meal = nil
        do {
            
            print(aiModel.availability)
            
            let prompt = "Suggest a recipe that will use as many of these ingredient as possible, whilst remaining tasty. Ingredients are \(ingredients). You can suggest meals that use additional ingredients, but try to keep these fairly minimal. Meals can be cooked or cold, choose whatever fits the ingredients best"
        
            let response = try await session.respond(to: prompt, generating: Meal.self)
            
            meal = response.content


        } catch LanguageModelSession.GenerationError.refusal(let refusal, _) {
            // Generate an explanation for the refusal.
            if let message = try? await refusal.explanation.content {
                print(message)
            }
        }
        catch {
            print(error)
        }
        
    }
    
    
}

