
import SwiftUI

struct AddItemView : View {
    
    @Environment(\.dismiss) private var dismiss
    @State var itemName: String
    let onAdd: (String) -> Void
    
    @FocusState private var textFieldHasFocus
    
    func add(){
        if itemName.isEmpty {return}
        onAdd(itemName)
        itemName = ""
        textFieldHasFocus = true
    }
    
    var body : some View {
        
        NavigationStack {
            
            Form {
                
                Section {
                    TextField("Item name", text:$itemName).focused($textFieldHasFocus)
                }.onAppear{
                    textFieldHasFocus = true
                }.onSubmit {
                    add()
                }
                
                
                Button("Add"){
                    add()
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
