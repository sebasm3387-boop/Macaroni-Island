import SwiftUI
import Playgrounds

struct ContentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius:10)
            .fill(.black)
            .frame(width: 200, height: 40)
            .padding()
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
