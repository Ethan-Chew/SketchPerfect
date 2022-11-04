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
        }
        .frame(width: frameWidth, height: frameHeight)
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

struct TimeSelectionPopup: View {
    var body: some View {
        VStack {
            Text("Hello World")
        }
    }
}

struct DSBindingViewPreviewContainer : View {
    @State private var value = false
    
    var body: some View {
        DifficultySelectionView(presentView: $value, frameWidth: 882, frameHeight: 668)
    }
}

#if DEBUG
struct DSBindingView_Previews : PreviewProvider {
    static var previews: some View {
        DSBindingViewPreviewContainer()
    }
}
#endif
