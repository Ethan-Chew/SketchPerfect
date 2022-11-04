//
//  StatisticsView.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 4/11/22.
//

import SwiftUI

struct StatisticsView: View {
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

//struct StatisticsView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatisticsView()
//    }
//}
