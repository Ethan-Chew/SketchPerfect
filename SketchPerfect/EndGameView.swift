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
                VStack(alignment: .leading, spacing: 20) {
                    
                }.offset(y: 120+20)
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
