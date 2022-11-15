//
//  ContentView.swift
//  CATAAS Client
//
//  Created by Ahmed Browne on 11/14/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    var body: some View {
        if !viewModel.cats.isEmpty {
            TabView {
                ForEach(viewModel.cats, id: \._id) { cat in
                    AsyncImage(url: URL(string: "https://cataas.com/cat?\(cat._id)")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        } else {
            Text("No cats :(")
        }
    }
}
