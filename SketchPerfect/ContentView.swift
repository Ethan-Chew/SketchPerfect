//
//  ContentView.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 18/9/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            InfiniteBackgroundView()
            VStack {
                Text("SketchPerfect")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
