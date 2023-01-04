//
//  SketchPerfectApp.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 18/9/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct SketchPerfectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
//            EndGameView(frameWidth: 882, frameHeight: 668, storageManager: StorageManager(), appData: AppData(), gameData: SelectedGame(selectedDifficulty: "Easy", totalTime: 3.0, restPeriod: 10, whenSelectedDate: Date(), game: GameData(rounds: [])))
        }
    }
}
