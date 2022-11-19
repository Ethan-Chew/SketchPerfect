//
//  EndGameView.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 19/11/22.
//

import SwiftUI

struct EndGameView: View {
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    
    // Observed Objects
    @ObservedObject var storageManager: StorageManager
    @ObservedObject var userData: UserData
    
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
                    VStack {
                        Text("\(gameData.selectedDifficulty) Mode")
                            .foregroundColor(Color("MainBlue"))
                            .fontWeight(.heavy)
                            .font(.system(size: 40))
                            .padding(.top, 20)
                    }
                }
                
                // Top Buttons
                VStack {
                    HStack {
                        Spacer()
                        VStack {
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
                        }.padding(.trailing,10)
                    }
                    Spacer()
                }
                .padding(.top, 10)
            }
        }
    }
}

struct EndGameView_Previews: PreviewProvider {
    static var previews: some View {
        EndGameView(frameWidth: 882, frameHeight: 668, storageManager: StorageManager(), userData: UserData(), gameData: SelectedGame(selectedDifficulty: "easy", totalTime: 3.0, restPeriod: 10, whenSelectedDate: Date(), game: GameData(rounds: [])))
    }
}
