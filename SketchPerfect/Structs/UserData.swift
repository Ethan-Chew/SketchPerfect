//
//  UserData.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 21/11/22.
//

import Foundation

struct UserData: Codable {
    // Game Statistics
    var numOfGamesStarted: Int
    var numOfGamesCompleted: Int
    var completionPercentage: Double {
        return Double((numOfGamesCompleted / numOfGamesStarted) * 100)
    }
    var userGames: [Game] = []
    
    // User Statistics
    var gameFirstOpen: Double = Date().timeIntervalSince1970
    var username: String = "User"
}

struct Game: Codable {
    var difficulty: String
    var rounds: [Round]
}

struct Round: Codable {
    var percentageAccuracy: Double
    var timeTaken: Double
    var imageData: Data
}
