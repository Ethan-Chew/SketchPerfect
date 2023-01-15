//
//  EndGameView.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 19/11/22.
//

import SwiftUI

struct EndGameView: View {
    @Environment(\.isPresented) var isPresented
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    
    // Observed Objects
    @ObservedObject var storageManager: StorageManager
    @ObservedObject var appData: AppData
    
    // State Variables
    @State var gameData: SelectedGame

    var body: some View {
        ZStack {
            InfiniteBackgroundView()
            
            ZStack {
                // Top Header
                ZStack(alignment: .top) {
                    VStack {
                        Rectangle()
                            .frame(width: frameWidth, height: 120)
                            .foregroundColor(Color("LightBlue"))
                        Spacer()
                    }
                    Text("Game Over!")
                        .foregroundColor(Color("MainBlue"))
                        .fontWeight(.heavy)
                        .font(.system(size: 55))
                        .padding(.top, 30)
                }
                
                // Close Button
                VStack {
                    HStack {
                        Spacer()
                        Button {

                        } label: {
                            Text("Close")
                                .padding(9)
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                                .background(.red)
                                .foregroundColor(.white)
                                .bold()
                                .font(.title2)
                                .cornerRadius(16)
                        }
                        .padding(.trailing,10)
                    }
                    Spacer()
                }
                .padding(.top, 10)
                
                // Main Content
                VStack {
                    ForEach(gameData.rounds, id: \.self) { round in
                        RoundStatsView(gameData: gameData, round: round, frameWidth: frameWidth)
                    }
                }
            }
            .frame(width: frameWidth, height: frameHeight)
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 5)
        }
    }
}

struct EndGameView_Previews: PreviewProvider {
    static var previews: some View {
        EndGameView(frameWidth: 882, frameHeight: 668, storageManager: StorageManager(), appData: AppData(), gameData: SelectedGame(selectedDifficulty: "Easy", totalTime: 3.0, restPeriod: 10, whenSelectedDate: Date(), rounds: []))
    }
}

struct RoundStatsView: View {
    
    // Variables
    let gameData: SelectedGame
    let round: RoundData
    let frameWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Round \(gameData.rounds.firstIndex(of: round)! + 1)")
                .bold()
                .font(.largeTitle)
            HStack {
                HStack(spacing: 20) {
                    VStack {
                        Text("The Image:")
                            .font(.title)
                            .bold()
                        Image(uiImage: UIImage(data: round.shownImage)!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: (frameWidth-20)/4)
                    }
                    
                    VStack {
                        Text("You Drew:")
                            .font(.title)
                            .bold()
                        Image(uiImage: UIImage(data: round.drawnImage)!)          
                            .resizable()
                            .scaledToFit()
                            .frame(width: (frameWidth-20)/4)
                    }
                }
                VStack {
                    Text("**Percentage Accuracy:** \(round.percentageAccuracy)%")
                        .font(.largeTitle)
                    Text("**Difficulty:** \(gameData.selectedDifficulty)")
                        .font(.largeTitle)
                }
            }
        }
        .padding()
        .cornerRadius(8)
        .shadow(radius: 6)
    }
}
