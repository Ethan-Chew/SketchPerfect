//
//  SelectedGame.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 4/11/22.
//

import Foundation

struct SelectedGame: Codable {
    let selectedDifficulty: String // Either 'easy', 'medium', 'hard'
    let totalTime: Double
    let whenSelectedDate: Date
    let game: GameData
}

struct GameData: Codable {
    let rounds: [RoundData]
}

struct RoundData: Codable {
    var id = UUID()
    let imageID: String
    let percentageAccuracy: String
}
