//
//  AppIconResizeView.swift
//  WWDC21 Swift Student Challenge
//
//  Created by Diego Henrique Silva Oliveira on 14/04/21.
//

import SwiftUI

struct AppIconResizeView: View {
    @Binding var memory: Memory
    @Binding var appToMem : [String : String]
    @Binding var memRects : [String: CGRect]
    @Binding var baseAppRects: [String: CGRect]
    @Binding var appNotFitInMemory: [String : Int]
    @Binding var framesUsed: [String: [Int]]
    var technique: MemoryManagmentTechniques
    var app : Application
    
    @State var isAnimating = false
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    
    var body: some View {
        // If the technique is simple paging, gets the amount of app icons needed in order to move to the correct frames when necessary
        if (technique == .simplepaging) {
            let framesNeeded = ceil(Double(app.size)/200)
            Group {
                ForEach(0..<Int(framesNeeded), id: \.self) { index in 
                        Image(uiImage: app.iconImageName)
                            .resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: 70, maxHeight: 70)
                            .rotationEffect(Angle(degrees: self.isAnimating && appToMem.keys.contains(app.id) ? 360 : 0.0))
                            .animation(self.isAnimating && appToMem.keys.contains(app.id) ? foreverAnimation : .default)
                            .onAppear { self.isAnimating = true }
                            .onDisappear { self.isAnimating = false }
                            .modifier(Shake(animatableData: CGFloat(appNotFitInMemory[app.id, default: 0])))
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 10)
                            .scaleEffect((appToMem.keys.contains(app.id) ? 0.35 : 1))
                            .position(originForMovableAppPaging(id: app.id, index: index))
                }
            }
        }
        
        // If it's Fixed or Dynamic Partitioning, gets the app icon in order to move to the correct position in memory when necessary
        else {
            Image(uiImage: app.iconImageName)
                .resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(maxWidth: technique == .fixedpartitioning ? 110 : 100, maxHeight: technique == .fixedpartitioning ? 110 : 100)
                .rotationEffect(Angle(degrees: self.isAnimating && appToMem.keys.contains(app.id) ? 360 : 0.0))
                .animation(self.isAnimating && appToMem.keys.contains(app.id) ? foreverAnimation : .default)
                .onAppear { self.isAnimating = true }
                .onDisappear { self.isAnimating = false }
                .modifier(Shake(animatableData: CGFloat(appNotFitInMemory[app.id, default: 0])))
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 10)
                .scaleEffect((appToMem.keys.contains(app.id) && technique == .dynamicpartitioning) ? app.size <= 200 ? 0.17 : app.size <= 300 ? 0.3 : app.size <= 600 ? 0.5 : 0.7 : appToMem.keys.contains(app.id) && technique == .fixedpartitioning ? 0.6 : 1)
                .position(originForMovableApp(id: app.id))
        }
    }
    
    // Gets the position (x,y) of memory block in screen to move the app icon to the correct position when executing
    func originForMovableApp(id: String) -> CGPoint {
        if let memId = appToMem[id], let memRect = memRects[memId] {
            return CGPoint(x: memRect.midX, y: memRect.midY)
        } else {
            let baseAppRect = baseAppRects[id] ?? .zero
            return CGPoint(x: baseAppRect.midX, y: baseAppRect.midY)
        }
    }
    
    // Same as the previous function, modified in order to support Simple Paging
    func originForMovableAppPaging(id: String, index: Int) -> CGPoint {
        if let memId = framesUsed[id], let memRect = memRects[String(memId[index])] {
            return CGPoint(x: memRect.midX, y: memRect.midY)
        } else {
            let baseAppRect = baseAppRects[id] ?? .zero
            return CGPoint(x: baseAppRect.midX, y: baseAppRect.midY)
        }
    }
}

// Structure that makes app icon "shake" when it does not fit in memory
struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
                                                amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                                              y: 0))
    }
}
