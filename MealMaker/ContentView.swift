import SwiftUI

struct ContentView: View {
    
    var model = Model()
    
    @State var thinking = false
    
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
                            Text("Add Ingredient")
                        }
                    }
                    ToolbarItem(placement: .topBarLeading, content: {
                        Button("Start again", role: .destructive){
                            ingredients = []
                        }
                    })
                }
                
                if let meal = model.meal {
                    MealView(meal: meal).padding()
                } else {
                    if thinking {
                        Text("Thinking")
                        ProgressView()
                    }
                }
                Spacer()
                    
                    
            }
        }
    }
}

#Preview {
    ContentView()
}
