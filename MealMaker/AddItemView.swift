
import SwiftUI

struct AddItemView : View {
    
    @Environment(\.dismiss) private var dismiss
    
    
    @State var itemName: String
    //@State var itemCount: Int
    let onAdd: (String) -> Void
    
    
    var body : some View {
        
        NavigationStack {
            
            Form {
                
                Section {
                    TextField("Item name", text:$itemName)
                    
//                    Stepper (value: $itemCount, in: 1...100, step:1) {
//                        Text("Quantity: \(itemCount)")
//                    }
                }
                
                
                Button("Add"){
                    onAdd(itemName)
                    itemName = ""
                  //  itemCount = 1
                }.disabled(itemName.isEmpty)
                
                Section {
                    Button("Done"){
                        dismiss()
                    }
                }
                
            }.navigationTitle("Add new items")
            
            
            
            
        }
        
        
        
    }
    
    
    
}
