import SwiftUI
import Playgrounds
import AppKit

struct ContentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius:10)
            .fill(.black)
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
