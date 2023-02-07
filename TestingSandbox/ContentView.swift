//
//  ContentView.swift
//  TestingSandbox
//
//  Created by Yoli on 07/02/2023.
//

import SwiftUI
//gives us something to test with, both these will fail guarenteed but they're slightly different.
class DataModel: ObservableObject {
    func goingToFail() throws {
        throw CocoaError(.fileNoSuchFile)
    }
    //swift knows which of these to call depending if we're in an async context at call time or not. 
    func goingToFail() async throws {
        try await Task.sleep(for: .milliseconds(500))
        throw CocoaError(.fileNoSuchFile)
    }
}
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
