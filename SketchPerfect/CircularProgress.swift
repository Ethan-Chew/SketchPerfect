//
//  CircularProgress.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 8/11/22.
//

import Foundation
import SwiftUI

struct CircularProgress: View {
    let colour: String
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color(colour).opacity(0.5),
                    lineWidth: 22
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color(colour),
                    style: StrokeStyle(
                        lineWidth: 22,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }
    }
}

