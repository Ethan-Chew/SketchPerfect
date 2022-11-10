//
//  DrawingView.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 9/11/22.
//

import Foundation
import SwiftUI
import PencilKit

extension PKDrawing {
    func image(from rect: CGRect, scale: CGFloat, userInterfaceStyle: UIUserInterfaceStyle) -> UIImage {
        let currentTraits = UITraitCollection.current
        UITraitCollection.current = UITraitCollection(userInterfaceStyle: userInterfaceStyle)
        let image = self.image(from: rect, scale: scale)
        UITraitCollection.current = currentTraits
        return image
    }
}

struct DrawingCanvas: UIViewRepresentable {
    
    // Canvas Objects
    @Binding var canvas: PKCanvasView
    @Binding var toolPicker: PKToolPicker
    
    // Game Data
    @ObservedObject var userData: UserData
    var gameData: SelectedGame
    var currentRound: Int
    
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.overrideUserInterfaceStyle = .light
        canvas.drawingPolicy = .anyInput
//        userData.currentGameData.game.rounds[currentRound - 1].image = canvas.drawing.image(from: canvas.bounds, scale: 1.0, userInterfaceStyle: .light).pngData()!
        canvas.tool = PKInkingTool(.pen, color: .gray, width: 10)
        #if targetEnvironment(simulator)
        canvas.drawingPolicy = .anyInput
        #endif
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.becomeFirstResponder()
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
}
