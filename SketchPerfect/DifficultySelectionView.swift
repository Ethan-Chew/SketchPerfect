//
//  DifficultySelectionView.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 4/11/22.
//

import SwiftUI

struct DifficultySelectionView: View {
    @Binding var presentView: Bool
    let frameWidth: CGFloat
    let frameHeight:CGFloat
    
    var body: some View {
        VStack {
            Text("Hello World")
        }
        .frame(width: frameWidth, height: frameHeight)
        .background(.white)
        .cornerRadius(20)
    }
}

struct TimeSelectionPopup: View {
    var body: some View {
        VStack {
            Text("Hello World")
        }
    }
}

//struct DifficultySelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        DifficultySelectionView()
//    }
//}
