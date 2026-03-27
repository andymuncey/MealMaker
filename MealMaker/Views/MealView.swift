import SwiftUI
struct MealView : View {
    
    var meal: Meal
    
    var body : some View {
        
        Text(meal.name).font(.headline)
        Text(meal.description).font(.subheadline)
        
        HStack {
            VStack {
                List{
                    ForEach(meal.ingredients){
                        ingredient in
                        HStack {
                            Text("\(ingredient.name)")
                            Spacer()
                            Text("\(ingredient.quantity)")
                            Text(ingredient.unit == .count ? "" : "\(ingredient.unit.rawValue)")
                        }
                    }
                }.listStyle(.plain)
                
            }
            Spacer()
            VStack {
                List {
                    ForEach(meal.steps, id: \.self){
                        Text($0)
                    }
                }.listStyle(.plain)
            }
            
            GeneratedImageView(description: meal.description)
        }
    }
}


