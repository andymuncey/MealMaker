import FoundationModels


@Generable
struct Meal {
    
    @Guide(description: "The name of the meal")
    var name: String
    
    @Guide(description: "A short description of the meal")
    var description: String
    
    @Guide(description: "What is needed to create the meal, You can assume no allergies or intolerances")
    var ingredients: [Ingredient]
    
    @Guide(description: "A series of steps showing how to make the recipe, where applicable oven temperature values should be in celsius and gas mark")
    var steps: [String]
    
    var overview : String {
        return "\(name): \(description). You need \(ingredients) and to follow these steps: \(steps)"
    }
}

@Generable
struct Ingredient: Identifiable, Hashable {
    var name: String
    var quantity: Int
    
    @Guide(description: "The unit to use. If the items are measures solely by how many there are use the count value.")
    var unit: Unit
    
    var id : String {
        return name
    }
}

@Generable
enum Unit : String {
    case count = ""
    case grams = "grams"
    case millilitres = "ml"
    case packet = "packet(s)"
    case pinch = "pinch"
    
    
}
