
//
//  CreditsView.swift
//  WWDC21 Swift Student Challenge
//
//  Created by Diego Henrique Silva Oliveira on 19/04/21.
//

import SwiftUI
import PlaygroundSupport

public struct CreditsView: View {
    public init(){}
    @State var isAnimating = false
    public var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 43/255, blue: 92/255)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.vertical)
                VStack {
                    Image(uiImage: #imageLiteral(resourceName: "RamMemory.png"))
                        .padding(.leading, 340.0)
                        .padding(.top, -300.0)
                        .frame(width: 100.0, height: 200.0)
                        .scaleEffect(self.isAnimating ? 1 : 0.5)
                        .rotationEffect(Angle(degrees: self.isAnimating ? 9 : 0.0))
                        .animation(Animation.linear(duration: 3))
                        .onAppear {
                            self.isAnimating = true
                        }
                    Image(uiImage: #imageLiteral(resourceName: "Track.png"))
                        .frame(maxWidth: 336, maxHeight: 127)
                        .padding(.leading, 400.0)
                        .padding(.bottom, -120.0)
                        .scaleEffect(self.isAnimating ? 1: 0)
                        .animation(Animation.spring().delay(1))
                        .onAppear {
                            self.isAnimating = true
                        }
                    Image(uiImage: #imageLiteral(resourceName: "My.png"))
                        .frame(maxWidth: 174, maxHeight: 127)
                        .padding(.leading, 400.0)
                        .scaleEffect(self.isAnimating ? 1: 0)
                        .animation(Animation.spring().delay(2))
                        .onAppear {
                            self.isAnimating = true
                        }
                    Image(uiImage: #imageLiteral(resourceName: "Memory.png"))
                        .frame(maxWidth: 393, maxHeight: 127)
                        .padding(.leading, 400.0)
                        .padding(.top, -120.0)
                        .scaleEffect(self.isAnimating ? 1: 0)
                        .animation(Animation.spring().delay(3))
                        .onAppear {
                            self.isAnimating = true
                            PlaygroundPage.current.assessmentStatus = .pass(message: "Thank you for playing! ☺️")
                        }
                    .contentShape(Rectangle())
                }
                .padding(.trailing, 380.0)
                .padding(.top, 100.0)
            }
    }
}
