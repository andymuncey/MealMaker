import SwiftUI
import ImagePlayground
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

struct GeneratedImageView: View {
    var description: String
    
    @Environment(\.supportsImagePlayground) private var supportsImagePlayground
    @State private var showingPlayground = false
    @State private var image: Image? = nil
    
    var body: some View {
        VStack(spacing: 12) {
            if let image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300, maxHeight: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 4)
                
                if supportsImagePlayground {
                    Button {
                        showingPlayground = true
                    } label: {
                        Label("Edit or Regenerate", systemImage: "arrow.triangle.2.circlepath")
                    }
                    .buttonStyle(.bordered)
                }
            } else if supportsImagePlayground {
                VStack(spacing: 12) {
                    Image(systemName: "photo.badge.plus")
                        .font(.system(size: 48))
                        .foregroundStyle(.secondary)
                    
                    Text("No Image Yet")
                        .font(.headline)
                    
                    Button {
                        showingPlayground = true
                    } label: {
                        Label("Generate Image", systemImage: "sparkles")
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: 300, minHeight: 200)
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(.quaternary.opacity(0.5)))
            } else {
                ContentUnavailableView(
                    "Image Playground Unavailable",
                    systemImage: "photo.badge.exclamationmark",
                    description: Text("Image Playground is not supported on this device.")
                )
                .frame(maxWidth: 300, maxHeight: 300)
            }
        }
        .padding()
        .imagePlaygroundSheet(
            isPresented: $showingPlayground,
            concepts: [.text(description)]
        ) { url in
            loadImage(from: url)
        }
    }
    
    private func loadImage(from url: URL) {
        #if os(macOS)
        if let nsImage = NSImage(contentsOf: url) {
            self.image = Image(nsImage: nsImage)
        }
        #elseif canImport(UIKit)
        if let data = try? Data(contentsOf: url), let uiImage = UIImage(data: data) {
            self.image = Image(uiImage: uiImage)
        }
        #endif
    }
}

#Preview {
    GeneratedImageView(description: "Sausages and mashed potato with gravy")
}
