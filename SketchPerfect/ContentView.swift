//
//  ContentView.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 18/9/22.
//

import SwiftUI

struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color
    
    var body: some View {
        ZStack {
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}

struct ContentView: View {
    // Control Entry/Exit of Views
    @State var presentPlayView = false
    var playXOffset: CGFloat {
        presentPlayView ? 0 : -UIScreen.main.bounds.width
    }
    
    @State var presentStatisticsView = false
    var statisticsXOffset: CGFloat {
        presentStatisticsView ? 0 : UIScreen.main.bounds.width
    }
    
    @State var presentSettingsView = false
    var settingsXOffset: CGFloat {
        presentSettingsView ? 0 : UIScreen.main.bounds.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            let btnWidth = geometry.size.width/2-30
            
            ZStack {
                InfiniteBackgroundView()
                VStack(spacing: 200) {
                    Spacer()
                    
                    Text("SketchPerfect")
                        .font(.system(size: 85))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .shadow(radius: 6.0)
                    
                    VStack(spacing: 40) {
                        Button {
                            withAnimation { presentPlayView.toggle() }
                        } label: {
                            Text("Play")
                                .font(.system(size: 50))
                                .fontWeight(.semibold)
                                .frame(width: btnWidth)
                                .padding(14)
                                .background(Color.white)
                                .foregroundColor(Color(uiColor: UIColor(red: 64/255, green: 111/255, blue: 185/255, alpha: 1)))
                                .cornerRadius(25)
                                .padding(12)
                                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 5))
                        }
                        
                        Button {
                            withAnimation { presentSettingsView.toggle() }
                        } label: {
                            Text("Statistics")
                                .font(.system(size: 50))
                                .fontWeight(.semibold)
                                .frame(width: btnWidth)
                                .padding(14)
                                .background(Color.white)
                                .foregroundColor(Color(uiColor: UIColor(red: 27/255, green: 113/255, blue: 168/255, alpha: 1)))
                                .cornerRadius(25)
                                .padding(12)
                                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 5))
                        }
                        
                        Button {
                            withAnimation { presentSettingsView.toggle() }
                        } label: {
                            Text("Settings")
                                .font(.system(size: 50))
                                .fontWeight(.semibold)
                                .frame(width: btnWidth)
                                .padding(14)
                                .background(Color.white)
                                .foregroundColor(Color(uiColor: UIColor(red: 25/255, green: 98/255, blue: 144/255, alpha: 1)))
                                .cornerRadius(25)
                                .padding(12)
                                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 5))
                        }
                    }
                    
                    Spacer()
                    Spacer()
                }
                
                VStack {
                    DifficultySelectionView(presentView: $presentPlayView, frameWidth: geometry.size.width-100, frameHeight: (geometry.size.height/3)*2.7)
                        .offset(x: playXOffset)
                    Spacer()
                }
                
                StatisticsView(presentView: $presentStatisticsView, frameWidth: geometry.size.width-100, frameHeight: (geometry.size.height/3)*2.7)
                    .offset(x: statisticsXOffset)
                
                SettingsView(presentView: $presentSettingsView, frameWidth: geometry.size.width-100, frameHeight: (geometry.size.height/3)*2.7)
                    .offset(x: settingsXOffset)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
