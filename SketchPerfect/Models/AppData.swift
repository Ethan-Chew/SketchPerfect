//
//  UserData.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 4/11/22.
//

import Foundation

class AppData: ObservableObject {
    let userDefaults = UserDefaults.standard
    let encoder = JSONEncoder()
    
    // Image Data
    @Published var gameImages: ImageData {
        didSet {
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
    
    // User's Data
    @Published var userData: UserData {
        didSet {
            let data = try? encoder.encode(userData)
            userDefaults.set(data, forKey: "userData")
        }
    }
    
    // Game Settings
    @Published var settings: Settings {
        didSet {
            let data = try? encoder.encode(userData)
            userDefaults.set(data, forKey: "settings")
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        
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
        
        // User's Data
        let userDat = userDefaults.object(forKey: "userData")
        if let userDat = userDat {
            let userData = try? decoder.decode(UserData.self, from: userDat as! Data)
            self.userData = userData ?? UserData(numOfGamesStarted: 0, numOfGamesCompleted: 0)
        } else {
            self.userData = UserData(numOfGamesStarted: 0, numOfGamesCompleted: 0)
        }
        
        // Settings
        let rawSettings = userDefaults.object(forKey: "userData")
        if let rawSettings = rawSettings {
            let settings = try? decoder.decode(Settings.self, from: rawSettings as! Data)
            self.settings = settings ?? Settings()
        } else {
            self.settings = Settings()
        }
    }
}
