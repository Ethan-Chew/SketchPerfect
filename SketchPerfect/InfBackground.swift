//
//  InfBackground.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 3/11/22.
//

import Foundation
import SwiftUI

enum backgroundColour {
    case colour1, colour2, colour3
}

struct InfiniteBackgroundView: View {
    
    func getRelatedColour(bgColour: backgroundColour) -> Color {
        switch bgColour {
        case .colour1:
            return Color(UIColor(red: 138/255, green: 201/255, blue: 38/255, alpha: 1))
        case .colour2:
            return Color(red: 139/255, green: 192/255, blue: 51/255)
        case .colour3:
            return Color(red: 117/255, green: 165/255, blue: 41/255)
        }
    }
    @State var yOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let width1 = geometry.size.width/2+30
            let width2 = (geometry.size.width/3)*2+30
            let height = (geometry.size.height/6)
            
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: -30) {
                    ForEach((1...10), id: \.self) { i in
                        if i % 2 == 0 {
                            VStack(spacing: -(height/2+10)) {
                                HStack(spacing: -30) {
                                    Rectangle()
                                        .fill(getRelatedColour(bgColour: .colour2))
                                        .cornerRadius(60)
                                        .frame(width: width1, height: height)
                                        .offset(x: -33, y: 0)
                                        .zIndex(3)
                                    Rectangle()
                                        .fill(getRelatedColour(bgColour: .colour1))
                                        .cornerRadius(60)
                                        .frame(width: width2, height: height)
                                        .offset(x: -60, y: -height/2+10)
                                        .zIndex(1)
                                }
                                HStack(spacing: 0) {
                                    Spacer()
                                    Rectangle()
                                        .fill(getRelatedColour(bgColour: .colour3))
                                        .cornerRadius(60)
                                        .frame(width: width2, height: height, alignment: .trailing)
                                        .offset(x: -80, y: 0)
                                        .zIndex(1)
                                }
                            }
                            .rotation3DEffect(.degrees(-180), axis: (x: 0, y: 1, z: 0))
                            .offset(x: -130, y: 10)
                            .zIndex(Double(8-i))
                        } else {
                            VStack(spacing: -height/2) {
                                HStack(spacing: -30) {
                                    Rectangle()
                                        .fill(getRelatedColour(bgColour: .colour2))
                                        .cornerRadius(60)
                                        .frame(width: width1, height: height)
                                        .offset(x: -60, y: 0)
                                        .zIndex(3)
                                    Rectangle()
                                        .fill(getRelatedColour(bgColour: .colour1))
                                        .cornerRadius(60)
                                        .frame(width: width2, height: height)
                                        .offset(x: -100, y: -height/2+10)
                                        .zIndex(1)
                                }
                                HStack(spacing: 0) {
                                    Spacer()
                                    Rectangle()
                                        .fill(getRelatedColour(bgColour: .colour3))
                                        .cornerRadius(60)
                                        .frame(width: width2, height: height, alignment: .trailing)
                                        .offset(x: -80, y: 0)
                                        .zIndex(1)
                                }
                            }
                            .zIndex(Double(i))
                        }
                    }
                }
                .offset(x: 20, y: yOffset)
            }
            .ignoresSafeArea()
            .disabled(true)
            .onAppear() {
                withAnimation(.linear(duration: 35).repeatForever(autoreverses: false)) {
                    yOffset = -height*5.2
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct InfiniteBackground_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteBackgroundView()
    }
}
