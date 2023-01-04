//
//  SelectedGame.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 4/11/22.
//

import Foundation

struct SelectedGame: Codable {
    var selectedDifficulty: String // Either 'easy', 'medium', 'hard'
    var totalTime: Double
    var restPeriod: Int
    var whenSelectedDate: Date
    var rounds: [RoundData]
}

struct RoundData: Codable, Equatable, Hashable {
    var id = UUID()
    var drawnImage: Data
    var shownImage: Data
    var percentageAccuracy: String
}
