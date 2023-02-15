//
//  ContentView.swift
//  TestingSandbox
//
//  Created by Yoli on 07/02/2023.
//

import SwiftUI

class DataModel: ObservableObject {
    //allows us to give example of testing with data that affects the UI
    @Published var flag = false
    
    func goingToFail() throws {
        throw CocoaError(.fileNoSuchFile)
    }

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
