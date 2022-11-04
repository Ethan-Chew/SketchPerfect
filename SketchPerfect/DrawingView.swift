//
//  DrawingView.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 4/11/22.
//

import SwiftUI

struct DrawingView: View {
    @Environment(\.dismiss) var dismiss
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    
    // Game Info
    @State var gameData: SelectedGame
    @State var roundNumber = 1
    @State var maxRounds = 0
    func getMaxRounds(difficulty: String) -> Int{
        switch difficulty {
        case "Easy":
            return 3
        case "Medium":
            return 5
        case "Hard":
            return 7
        default:
            return 0
        }
            
    }
    
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
                    VStack {
                        Text("\(gameData.selectedDifficulty) Mode")
                            .foregroundColor(Color("MainBlue"))
                            .fontWeight(.heavy)
                            .font(.system(size: 40))
                            .padding(.top, 20)
                        Text("Image \(roundNumber)/\(maxRounds)")
                            .foregroundColor(Color("MainBlue"))
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                    }
                }
                
                // Close Button
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            dismiss()
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
            }
            .frame(width: frameWidth, height: frameHeight)
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 5)
        }
        .onAppear() {
            maxRounds = getMaxRounds(difficulty: gameData.selectedDifficulty)
            if maxRounds == 0 {
                fatalError("Round Difficulty not found, difficulty: \(gameData.selectedDifficulty) returned with 0.")
            }
        }
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView(frameWidth: 882, frameHeight: 668, gameData: SelectedGame(selectedDifficulty: "easy", totalTime: 3.0, whenSelectedDate: Date(), game: GameData(rounds: [])))
    }
}
