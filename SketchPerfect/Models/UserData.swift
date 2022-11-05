//
//  UserData.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 4/11/22.
//

import Foundation

class UserData: ObservableObject {
    let userDefaults = UserDefaults.standard
    
    // Data of the Current Game
    @Published var currentGameData: SelectedGame {
        didSet {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(currentGameData)
            userDefaults.set(data, forKey: "currentGameData")
        }
    }
    
    // Image Data
    @Published var gameImages: ImageData {
        didSet {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(gameImages)
            userDefaults.set(data, forKey: "gameImages")
        }
    }
    
    // Last Data Update
    @Published var lastDataUpdate: [String] {
        didSet {
            userDefaults.set(lastDataUpdate, forKey: "lastDataUpdate")
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        
        // Current Game Data
        let currentGameDat = userDefaults.object(forKey: "currentGameData")
        if let currentGameDat = currentGameDat {
            let gameData = try? decoder.decode(SelectedGame.self, from: currentGameDat as! Data)
            self.currentGameData = gameData ?? SelectedGame(selectedDifficulty: "", totalTime: 0.0, whenSelectedDate: Date(), game: GameData(rounds: []))
        } else {
            self.currentGameData = SelectedGame(selectedDifficulty: "", totalTime: 0.0, whenSelectedDate: Date(), game: GameData(rounds: []))
        }
        
        // Image Data
        let rawGameImg = userDefaults.object(forKey: "gameImages") as? Data
        if let rawGameImg = rawGameImg {
            let data = try? decoder.decode(ImageData.self, from: rawGameImg)
            self.gameImages = data ?? ImageData(easy: [], medium: [], hard: [])
        } else {
            self.gameImages = ImageData(easy: [], medium: [], hard: [])
            print("Failed to decode Game Image Data")
        }
        
        // Last Data Update
        self.lastDataUpdate = userDefaults.object(forKey: "lastDataUpdate") as? [String] ?? []
    }
}
