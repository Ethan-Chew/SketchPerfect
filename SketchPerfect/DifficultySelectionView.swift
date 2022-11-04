//
//  DifficultySelectionView.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 4/11/22.
//

import SwiftUI

struct DifficultySelectionView: View {
    @Binding var presentView: Bool
    let frameWidth: CGFloat
    let frameHeight:CGFloat
    
    // Control Entry/Exit of Views
    @State var presentChooseTimeView = false
    var viewXOffset: CGFloat {
        presentChooseTimeView ? 0 : -UIScreen.main.bounds.width
    }
    
    // Variables
    @State var selectedMode: String
    
    var body: some View {
        ZStack {
            // Top Header
            ZStack(alignment: .top) {
                VStack {
                    Rectangle()
                        .frame(width: frameWidth, height: 120)
                        .foregroundColor(Color("LightBlue"))
                    Spacer()
                }
                Text("Play")
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
                        withAnimation { presentView = false }
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
            
            // Difficulty Boxes
            VStack(spacing: 20) {
                // Easy Box
                HStack {
                    Spacer() // Temp
                    VStack(alignment: .leading, spacing: 30) {
                        VStack(alignment: .leading) {
                            Text("Easy")
                                .font(.system(size: 45))
                                .fontWeight(.heavy)
                            Text("Easy Mode includes 3 easy shapes to replicate")
                                .font(.system(size: 22))
                        }
                        .padding(.top, 40)
                        
                        Button {
                            selectedMode = "Easy"
                            withAnimation { presentChooseTimeView = true }
                        } label: {
                            Text("Start")
                                .font(.system(size: 30))
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding(10)
                                .padding(.leading, 50)
                                .padding(.trailing, 50)
                                .background(Color("MainGreen"))
                                .cornerRadius(20)
                        }
                        .padding(.bottom, 40)
                    }
                }
                .frame(width: frameWidth-60, height: frameWidth/4)
                .padding()
                .background(Color("BackgroundGrey"))
                .cornerRadius(16)
                .shadow(radius: 2)
                
                // Medium Box
                HStack {
                    Spacer() // Temp
                    VStack(alignment: .leading, spacing: 30) {
                        VStack(alignment: .leading) {
                            Text("Medium")
                                .font(.system(size: 45))
                                .fontWeight(.heavy)
                            Text("Medium Difficulty includes 4 outlines to replicate")
                                .font(.system(size: 22))
                        }
                        .padding(.top, 40)
                        
                        Button {
                            selectedMode = "Medium"
                            withAnimation { presentChooseTimeView = true }
                        } label: {
                            Text("Start")
                                .font(.system(size: 30))
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .padding(10)
                                .padding(.leading, 50)
                                .padding(.trailing, 50)
                                .background(Color("MainYellow"))
                                .cornerRadius(20)
                        }
                        .padding(.bottom, 40)
                    }
                }
                .frame(width: frameWidth-60, height: frameWidth/4)
                .padding()
                .background(Color("BackgroundGrey"))
                .cornerRadius(16)
                .shadow(radius: 2)
                
                // Hard Box
                HStack {
                    Spacer() // Temp
                    VStack(alignment: .leading, spacing: 30) {
                        VStack(alignment: .leading) {
                            Text("Hard")
                                .font(.system(size: 45))
                                .fontWeight(.heavy)
                            Text("Hard Difficulty includes 5 harder outlines to replicate")
                                .font(.system(size: 22))
                        }
                        .padding(.top, 40)
                        
                        Button {
                            selectedMode = "Hard"
                            withAnimation { presentChooseTimeView = true }
                        } label: {
                            Text("Start")
                                .font(.system(size: 30))
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding(10)
                                .padding(.leading, 50)
                                .padding(.trailing, 50)
                                .background(Color("MainRedBrown"))
                                .cornerRadius(20)
                        }
                        .padding(.bottom, 40)
                    }
                }
                .frame(width: frameWidth-60, height: frameWidth/4)
                .padding()
                .background(Color("BackgroundGrey"))
                .cornerRadius(16)
                .shadow(radius: 2)
                
                Spacer()
            }.offset(y: 120+20)
            
            VStack {
                Spacer()
                TimeSelectionPopup(showPopup: $presentChooseTimeView, frameWidth: frameWidth, frameHeight: frameHeight/2, modeSelected: selectedMode, currentGame: SelectedGame(selectedDifficulty: selectedMode, totalTime: 3.0, whenSelectedDate: Date(), game: GameData(rounds: [])))
                    .offset(x: viewXOffset)
                Spacer()
            }
            
        }
        .frame(width: frameWidth, height: frameHeight)
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 5)
        .onAppear() {
            print(presentChooseTimeView)
        }
    }
}

struct TimeSelectionPopup: View {
    @Binding var showPopup: Bool
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    let modeSelected: String
    
    // Configuration
    @State var totalTime:Double = 1
    @State var configMin:Double = 1
    @State var currentGame: SelectedGame
    
    var body: some View {
        ZStack {
            // Close Button
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        withAnimation { showPopup = false }
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                            Text("X")
                                .foregroundColor(.white)
                        }.padding()
                    }
                }
                
                Spacer()
            }
            
            // Main
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("**\(modeSelected)** Mode")
                            .font(.system(size: 40))
                        Text("3 Images, in \(String(totalTime).contains(".0") ? String(Int(totalTime)) : String(totalTime)) Minute\(totalTime <= 1 ? "" : "s").")
                            .font(.system(size: 22))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Change Time (per Image)")
                            .font(.system(size: 25))
                            .bold()
                        Slider(value: $configMin, in: 20...120, step: 1) {}
                            minimumValueLabel: {
                                Text("20 s").font(.title2).fontWeight(.thin)
                            } maximumValueLabel: {
                                Text("2 mins").font(.title2).fontWeight(.thin)
                            }
                            .frame(width: frameWidth/2)
                            .tint(Color("MainBlue"))
                            .onChange(of: configMin) { _ in
                        totalTime = (configMin*3)/60
                        totalTime = Double(round(10 * totalTime) / 10)
                    }
                        Text("Current Duration: \(String(totalTime).contains(".0") ? String(Int(totalTime)) : String(totalTime)) Minute\(totalTime <= 1 ? "" : "s")")
                            .font(.system(size: 22))
                    }
                    
                    Button {
                        currentGame = SelectedGame(selectedDifficulty: modeSelected, totalTime: totalTime, whenSelectedDate: Date(), game: GameData(rounds: []))
                        print(currentGame)
                    } label: {
                        Text("Lets Go!")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(10)
                            .padding(.leading, 50)
                            .padding(.trailing, 50)
                            .background(Color("MainBlue"))
                            .cornerRadius(20)
                    }
                }
                .padding()
                .padding(.leading, 20)
                
                Spacer()
            }
        }
        .frame(width: frameWidth, height: frameHeight)
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

struct DSBindingViewPreviewContainer : View {
    @State private var value = false
    
    var body: some View {
        //        DifficultySelectionView(presentView: $value, frameWidth: 882, frameHeight: 668)
        TimeSelectionPopup(showPopup: $value,frameWidth: 882 ,frameHeight: 668/2, modeSelected: "Easy", currentGame: SelectedGame(selectedDifficulty: "easy", totalTime: 3.0, whenSelectedDate: Date(), game: GameData(rounds: [])))
    }
}

#if DEBUG
struct DSBindingView_Previews : PreviewProvider {
    static var previews: some View {
        DSBindingViewPreviewContainer()
    }
}
#endif
