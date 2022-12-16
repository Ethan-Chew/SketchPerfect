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
    @ObservedObject var appData: AppData
    var compareImages = CompareImages()
    
    // Game Info
    let colourChange = ["MainGreen", "MainYellow", "MainRed"]
    @State var toggleOverlay: Bool = false
    @State var gameData: SelectedGame
    @State var roundNumber = 1
    @State var maxRounds = 0
    @State var timeRemaining: [Any] = [0.0, "MainGreen"]
    @State var secondaryCooldown = 2
    @State var cooldownPeriod = 10
    @State var progress = 1.0
    @State var timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    @State var disableDrawing = false
    @State private var triggerEndGame = false
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
    
    // Code to calculate percentage accuracy
    fileprivate func calcAccuracy(distance: Float) -> Double {
        if distance == 0.0 {
            return 100.0
        } else {
            let potAcc = (distance / 24) * 100
            if potAcc > 100.0 {
                return 100.0
            } else {
                return Double(potAcc)
            }
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
                
                // Top Buttons
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
                            Image(uiImage: UIImage(data: appData.gameImages.easy[roundNumber - 1])!)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: frameWidth/3, maxHeight: frameWidth/4+30)
                        case "Medium":
                            Image(uiImage: UIImage(data: appData.gameImages.medium[roundNumber - 1])!)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: frameWidth/3, maxHeight: frameWidth/4+30)
                        case "Hard":
                            Image(uiImage: UIImage(data: appData.gameImages.hard[roundNumber - 1])!)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: frameWidth/3, maxHeight: frameWidth/4+30)
                        default:
                            fatalError("Cannot find Selected Difficulty of: \(gameData.selectedDifficulty)")
                        }
                        
                        Spacer()
                        
                        ZStack(alignment: .center) {
                            if Int(timeRemaining[0] as! Double) != 0 {
                                CircularProgress(colour: timeRemaining[1] as? String ?? "MainGreen", progress: progress)
                                    .frame(maxWidth: frameWidth/4, maxHeight: frameWidth/4+30)
                            } else {
                                CircularProgress(colour: "MainYellow", progress: progress)
                                    .frame(maxWidth: frameWidth/4, maxHeight: frameWidth/4+30)
                            }
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
                                } else if Int(timeRemaining[0] as! Double) == 0 && cooldownPeriod == gameData.restPeriod {
                                    Text("Times Up!")
                                        .font(.system(size: 27))
                                        .foregroundColor(Color("MainRed"))
                                        .fontWeight(.bold)
                                        .frame(maxWidth: frameWidth/4)
                                        .multilineTextAlignment(.center)
                                } else {
                                    Text(String(cooldownPeriod))
                                        .fontWeight(.heavy)
                                        .font(.system(size: 27))
                                        .foregroundColor(Color("MainYellow"))
                                    Text("Seconds before restart")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color("MainYellow"))
                                        .frame(maxWidth: frameWidth/4)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        // Debug
//                        if let imageData = UIImage(data: appData.currentGameData.game.rounds[roundNumber - 1].image) {
//                            Image(uiImage: imageData)
//                                .resizable()
//                                .scaledToFit()
//                                .border(Color.black, width: 2)
//                        }
                    }
                    
                    // Drawing Area
                    ZStack(alignment: .leading) {
                        DrawingCanvas(canvas: $canvasView, toolPicker: $toolPicker, appData: appData, gameData: gameData, currentRound: roundNumber)
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
                            .disabled(disableDrawing)
                            .border(.gray, width: 1)
                        
                        VStack {
                            HStack(spacing: 20) {
                                Text("Draw!")
                                    .bold()
                                    .font(.largeTitle)
                                
//                                Button {
//                                    print("submit")
//                                } label: {
//                                    Text("Submit")
//                                        .padding(9)
//                                        .padding(.leading, 10)
//                                        .padding(.trailing, 10)
//                                        .background(Color("MainGreen"))
//                                        .foregroundColor(.white)
//                                        .bold()
//                                        .font(.title3)
//                                        .cornerRadius(16)
//                                }
                            }
                            .padding(.leading, 10)
                            .padding(.top, 10)
                            Spacer()
                        }
                    }
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
            appData.gameImages.easy.shuffle()
            appData.gameImages.medium.shuffle()
            appData.gameImages.hard.shuffle()
            
            // Config Timer
            timeRemaining = [gameData.totalTime/Double(maxRounds)*60.0, "MainGreen"]
            cooldownPeriod = gameData.restPeriod
        }
        .onReceive(timer) { _ in
            if appData.currentGameData.rounds.count == 0 {
                appData.currentGameData.rounds.append(RoundData(image: Data(), percentageAccuracy: ""))
            }
            
            print(appData.currentGameData)
            if Int(timeRemaining[0] as! Double) == 0 {
                disableDrawing = true
                if secondaryCooldown != 0 {
                    secondaryCooldown -= 1
                    progress = 1.0
                } else {
                    if cooldownPeriod != 0 {
                        cooldownPeriod -= 1
                        let oneSecProgress = 1.0 / Double(gameData.restPeriod)
                        withAnimation { progress = progress - oneSecProgress }
                    } else {
                        appData.currentGameData.rounds[roundNumber - 1].image = canvasView.drawing.image(from: canvasView.bounds, scale: 1.0, userInterfaceStyle: .light).pngData()!

                        // Compare the Images
                        let drawnImage: UIImage = UIImage(data: appData.currentGameData.rounds[roundNumber - 1].image)!
                        var currentImage: UIImage
                        
                        switch gameData.selectedDifficulty {
                        case "Easy":
                            currentImage = UIImage(data: appData.gameImages.easy[roundNumber - 1])!
                        case "Medium":
                            currentImage = UIImage(data: appData.gameImages.medium[roundNumber - 1])!
                        case "Hard":
                            currentImage = UIImage(data: appData.gameImages.hard[roundNumber - 1])!
                        default:
                            fatalError("Cannot find Selected Difficulty of: \(gameData.selectedDifficulty)")
                        }
                                                
//                        let croppedDrawnImage: UIImage? = compareImages.cropImage(imageToCrop: drawnImage)
//                        let croppedCurrentImage: UIImage? = compareImages.cropImage(imageToCrop: currentImage)
                        
                        /// Check if Cropped Images are nil, if not, compare them using vision
//                        if let croppedDrawnImage = croppedDrawnImage {
//                            if let croppedCurrentImage = croppedCurrentImage {
//                                // Images are not nil
//
//                                let distance: Float? = compareImages.compare(origImg: croppedCurrentImage, drawnImg: croppedDrawnImage)
//
////                                print(distance)
//                            } else {
//
//                            }
//                        } else {
//
//                        }
                        var distance: Float = 0.0
                        
                        if let dist = compareImages.compare(origImg: currentImage, drawnImg: drawnImage) {
                            distance = dist
                        } else {
                            fatalError("Could not determine Euclidian Distance between images")
                        }
                        
                        // Add data to round data
                        appData.currentGameData.rounds[roundNumber - 1].image = drawnImage.pngData()!
                        appData.currentGameData.rounds[roundNumber - 1].percentageAccuracy = String(calcAccuracy(distance: distance))
                        
                        // Set up for new round
                        progress = 1.0
                        secondaryCooldown = 2
                        roundNumber += 1
                        timeRemaining = [gameData.totalTime/Double(maxRounds)*60.0, "MainGreen"]
                        cooldownPeriod = gameData.restPeriod
                        appData.currentGameData.rounds.append(RoundData(image: Data(), percentageAccuracy: ""))
                        disableDrawing = false
                        canvasView.drawing = PKDrawing()
                    }
                }
            } else {
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
            
            // End Game
            if roundNumber == getMaxRounds(difficulty: gameData.selectedDifficulty) + 1 {
                roundNumber = getMaxRounds(difficulty: gameData.selectedDifficulty)
                triggerEndGame = true
                appData.userData.numOfGamesCompleted += 1
            }
        }
        .fullScreenCover(isPresented: $triggerEndGame) {
            EndGameView(frameWidth: frameWidth, frameHeight: frameHeight, storageManager: storageManager, appData: appData, gameData: gameData)
        }
    }
}

extension DrawingView {
    func saveImage(image: UIImage) -> URL? {
        guard let imageData = image.pngData() else {
            return nil
        }
        let baseURL = FileManager.default.temporaryDirectory
        let imageURL = baseURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
        do {
            try imageData.write(to: imageURL)
            return imageURL
        } catch {
            print("Error saving image to \(imageURL.path): \(error)")
            return nil
        }
    }
    
    func deleteImage(url: URL) -> Bool {
        return true
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView(frameWidth: 882, frameHeight: 668, storageManager: StorageManager(), appData: AppData(), gameData: SelectedGame(selectedDifficulty: "easy", totalTime: 3.0, restPeriod: 10, whenSelectedDate: Date(), rounds: []))
    }
}
