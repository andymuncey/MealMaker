import SwiftUI

struct SimpleGeneratorView: View {
    
    @State var thinking = false
    var generator = SimpleGenerator()
    
    var body: some View {
        Button("Generate"){
            thinking = true
            Task {
                await generator.generate()
                thinking = false
            }
        }.disabled(thinking)
        
        if thinking {
            Text("Thinking")
            ProgressView()
        } else {
            Text(generator.idea ?? generator.error ?? "No idea generated yet")
        }
    }
}

#Preview {
    SimpleGeneratorView()
}
