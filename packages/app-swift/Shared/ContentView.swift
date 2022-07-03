//
//  ContentView.swift
//  Shared
//
//  Created by Kyle Alan Hale on 7/1/22.
// 

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            Text(viewModel.thing ?? "Hmm…")
                .padding()

            Button("Hi!") {
                viewModel.update()
            } 
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
