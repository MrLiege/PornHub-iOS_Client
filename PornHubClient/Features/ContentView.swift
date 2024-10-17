//
//  ContentView.swift
//  PornHubClient
//
//  Created by Artyom Petrichenko on 17.10.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        EmptyView()
        .onAppear {
            viewModel.input.onAppear.send(())
        }
    }
}

#Preview {
    ContentView()
}
