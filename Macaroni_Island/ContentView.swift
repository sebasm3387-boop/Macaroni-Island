import SwiftUI
import Playgrounds
import AppKit

struct ContentView: View {
    var body: some View {
        UnevenRoundedRectangle(topLeadingRadius: 0,
        bottomLeadingRadius: 10,
        bottomTrailingRadius: 10,
        topTrailingRadius: 0)
            .fill(.black)
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
