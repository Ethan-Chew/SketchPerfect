//
//  DrawingView.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 4/11/22.
//

import SwiftUI
import PencilKit

struct DrawingView: View {
    @Environment(\.dismiss) var dismiss
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    
    // Observed Objects
    @ObservedObject var storageManager: StorageManager
    @ObservedObject var userData: UserData
    
    // Game Info
    let colourChange = ["MainGreen", "MainYellow", "MainRed"]
    @State var toggleOverlay: Bool = false
    @State var gameData: SelectedGame
    @State var roundNumber = 1
    @State var maxRounds = 0
    @State var timeRemaining: [Any] = [0.0, "MainGreen"]
    @State var progress = 1.0
    @State var timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
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
    
    // PencilKit
    @State private var canvasView = PKCanvasView()
    @State private var toolPicker = PKToolPicker()
    @State var deleteConfirmation: Bool = false
    
    var body: some View {
        ZStack {
            InfiniteBackgroundView()
            
            ZStack {
                ZStack {
                    
                }
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
                        VStack {
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
                            
                            Button {
                                toggleOverlay.toggle()
                            } label: {
                                Text("Overlay")
                                    .padding(9)
                                    .padding(.leading, 10)
                                    .padding(.trailing, 10)
                                    .background(Color("MainBlue"))
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.title3)
                                    .cornerRadius(16)
                            }
                        }.padding(.trailing,10)
                    }
                    Spacer()
                }
                .padding(.top, 10)
                
                // Main Content
                VStack {
                    // Display Image and Timer
                    HStack {
                        Spacer()
                        
                        switch gameData.selectedDifficulty {
                        case "Easy":
                            Image(uiImage: UIImage(data: userData.gameImages.easy[roundNumber - 1])!)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: frameWidth/4, maxHeight: frameWidth/4+30)
                        case "Medium":
                            Image(uiImage: UIImage(data: userData.gameImages.medium[roundNumber - 1])!)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: frameWidth/4, maxHeight: frameWidth/4+30)
                        case "Hard":
                            Image(uiImage: UIImage(data: userData.gameImages.hard[roundNumber - 1])!)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: frameWidth/4, maxHeight: frameWidth/4+30)
                        default:
                            fatalError("Cannot find Selected Difficulty of: \(gameData.selectedDifficulty)")
                        }
                        
                        Spacer()
                        
                        ZStack(alignment: .center) {
                            CircularProgress(colour: timeRemaining[1] as? String ?? "MainGreen", progress: progress)
                                .frame(maxWidth: frameWidth/4, maxHeight: frameWidth/4+30)
                            VStack(alignment: .center) {
                                if Int(timeRemaining[0] as! Double) > 0 {
                                    Text(String(Int(timeRemaining[0] as! Double)))
                                        .fontWeight(.heavy)
                                        .font(.system(size: 27))
                                        .foregroundColor(Color(timeRemaining[1] as? String ?? "MainGreen"))
                                    Text("Seconds Remaining")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color(timeRemaining[1] as? String ?? "MainGreen"))
                                        .frame(maxWidth: frameWidth/4)
                                        .multilineTextAlignment(.center)
                                } else {
                                    Text("Times Up!")
                                        .font(.system(size: 27))
                                        .foregroundColor(Color("MainRed"))
                                        .fontWeight(.bold)
                                        .frame(maxWidth: frameWidth/4)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    
                    // Drawing Area
                    DrawingCanvas(canvas: $canvasView, toolPicker: $toolPicker, userData: userData, gameData: gameData, currentRound: roundNumber)
                        .preferredColorScheme(.light)
                        .foregroundColor(.white)
                        .frame(width: frameWidth, height: frameHeight-(frameWidth/4+30)-20)
                        .alert("Are you sure?", isPresented: $deleteConfirmation, actions: {
                            Button("Yes", role: .destructive, action: {
                                canvasView.drawing = PKDrawing()
                            })
                        }, message: {
                            Text("This button will clear your whole canvas (removing your drawing FOREVER).")
                        })
                }
                .offset(y: 130)
            }
            .frame(width: frameWidth, height: frameHeight)
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 5)
        }
        .ignoresSafeArea()
        .onAppear() {
            maxRounds = getMaxRounds(difficulty: gameData.selectedDifficulty)
            if maxRounds == 0 {
                fatalError("Round Difficulty not found, difficulty: \(gameData.selectedDifficulty) returned with 0.")
            }
            
            // Randomise Game Images
            userData.gameImages.easy.shuffle()
            userData.gameImages.medium.shuffle()
            userData.gameImages.hard.shuffle()
            
            // Config Timer
            timeRemaining = [gameData.totalTime/Double(maxRounds)*60.0, "MainGreen"]
        }
        .onReceive(timer) { _ in
            if timeRemaining.count != 0 && timeRemaining[0] as! Double >= 0.0 {
                timeRemaining[0] = (timeRemaining[0] as? Double)! - 1.0
                let oneSecProgress = 1.0 / (gameData.totalTime/Double(maxRounds)*60.0)
                withAnimation { progress = progress - oneSecProgress }
                if progress > 0.5 {
                    withAnimation { timeRemaining[1] = "MainGreen" }
                } else if progress > 0.3 {
                    withAnimation { timeRemaining[1] = "MainYellow" }
                } else {
                    withAnimation { timeRemaining[1] = "MainRed" }
                }
            }
        }
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView(frameWidth: 882, frameHeight: 668, storageManager: StorageManager(), userData: UserData(), gameData: SelectedGame(selectedDifficulty: "easy", totalTime: 3.0, restPeriod: 10, whenSelectedDate: Date(), game: GameData(rounds: [])))
    }
}
