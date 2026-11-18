import SwiftUI

struct MealGeneratorView: View {
    
    var model = MealGenerator()
    
    @State var thinking = false
    @State var started = false
    
    @State var ingredients = ["Bread", "Cheese", "Tomato", "Bacon", "Ketchup", "Lettuce", "Burger", "Sauce", "Onion"]
    
    var body: some View {
        
        HStack{
            
            NavigationStack {
                
                HStack {
                    Text("Ingredients:").padding(.leading)
                    ScrollView (.horizontal){
                        HStack {
                            ForEach(ingredients, id: \.self){
                                Text($0).padding(12)
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem {
                        Button("Get meal", role: .confirm){
                            started = true
                            thinking = true
                            Task {
                                
                                await model.generate(ingredients: ingredients)
                                await MainActor.run{
                                    thinking = false
                                }
                            }
                        }.disabled(ingredients.count < 2)
                    }
                    ToolbarItem{
                        NavigationLink {
                            AddItemView(itemName: "") { item in
                                if !ingredients.contains(item) {
                                    ingredients.append(item)
                                }
                            }
                        } label: {
                            Label("Add ingredient", systemImage: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigation, content: {
                        Button(role: .destructive) {
                            ingredients = []
                            started = false
                        } label: {
                            Label("Start again", systemImage: "arrow.clockwise")
                        }
                    })
                }
                
                if let meal = model.meal, started {
                    MealView(meal: meal).padding()
                } else {
                    if thinking {
                        Text("Thinking")
                        ProgressView()
                    } else if !started {
                        Text("Add ingredients and then tap Get Meal")
                    }
                    else {
                        Text(model.error ?? "Unknown error")
                    }
                }
                Spacer()
                    
                    
            }
        }
    }
}

#Preview {
    MealGeneratorView()
}
