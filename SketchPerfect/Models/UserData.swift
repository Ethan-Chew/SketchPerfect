//
//  UserData.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 4/11/22.
//

import Foundation

class UserData: ObservableObject {
    let userDefaults = UserDefaults.standard
    
    @Published var currentGameData: SelectedGame {
        didSet {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(currentGameData)
            userDefaults.set(data, forKey: "currentGameData")
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        let currentGameDat = userDefaults.object(forKey: "currentGameData")
        if let currentGameDat = currentGameDat {
            let gameData = try? decoder.decode(SelectedGame.self, from: currentGameDat as! Data)
            self.currentGameData = gameData ?? SelectedGame(selectedDifficulty: "", totalTime: 0.0, whenSelectedDate: Date(), game: GameData(rounds: []))
        } else {
            self.currentGameData = SelectedGame(selectedDifficulty: "", totalTime: 0.0, whenSelectedDate: Date(), game: GameData(rounds: []))
        }
    }
}
