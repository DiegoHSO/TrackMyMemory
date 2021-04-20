//
//  DynamicPartitioningView.swift
//  WWDC21 Swift Student Challenge
//
//  Created by Diego Henrique Silva Oliveira on 17/04/21.
//

import SwiftUI
import PlaygroundSupport

public struct DynamicPartitioningView: View {
    
    public init(){}
    var technique: MemoryManagmentTechniques = .dynamicpartitioning
    var apps: [Application] = Application.dynamicPartitioningApps
    @State var memory: Memory = .dynamicMemory
    @State var firstRun : Bool = true
    @State var isAnimating = false
    @State private var memRects: [String: CGRect] = [:]
    @State private var baseAppRects: [String: CGRect] = [:]
    @State private var appToMem: [String: String] = [:]
    @State private var appNotFitInMemory: [String : Int] = [:]
    @State private var framesUsed: [String : [Int]] = [:]
    
    public var body: some View {
        ZStack {
            LayoutView(technique: technique)
            VStack {
                VStack (spacing: 70) {
                    HStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: technique == .dynamicpartitioning ? 55 : 15) {
                        ForEach(apps) { app in
                            AppIconView(appToMem: $appToMem, appNotFitInMemory: $appNotFitInMemory, technique: technique, app : app)
                        }
                    }
                    
                    .padding(.top, 1580.0)
                    .padding()
                    .onPreferenceChange(AppItemPreferenceKey.self) { appItemRects in
                        for appItemData in appItemRects {
                            baseAppRects[appItemData.appId] = appItemData.rect
                        }
                    }
                    
                    HStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: technique == .dynamicpartitioning ? 64 : 25) {
                        ForEach(apps) { app in
                            AppButtonView(technique: technique, firstRun: $firstRun, memory: $memory, appToMem: $appToMem, appNotFitInMemory: $appNotFitInMemory, framesUsed: $framesUsed, app: app)
                        }
                    }
                    .padding(.top, -210)
                    
                    VStack {
                        ForEach(memory.items) { memItem in
                            MemoryView(technique: technique, memItem: memItem, appToMem: $appToMem, framesUsed: $framesUsed)
                        }
                    }
                    .padding(.top, -985)
                    .onPreferenceChange(MemoryItemPreferenceKey.self) { memItemRects in
                        for memItemData in memItemRects {
                            memRects[memItemData.memoryId] = memItemData.rect
                        }
                    }
                }
                .padding(.top, 100)
                
                Button(action: {
                    PlaygroundPage.current.navigateTo(page: .pageReference(reference: "Simple Paging"))
                }) {
                    Text("Continue")
                        .frame(width: 170.0, height: 78.0)
                        .font(.system(size: 26, weight: .semibold, design: Font.Design.monospaced))
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 5, x: 10, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: .infinity)
                                .stroke(Color.white, lineWidth: 1.5)
                        ).background(RoundedRectangle(cornerRadius: .infinity).fill(Color.black))
                        .padding(.bottom, 300)
                        .padding(.leading, technique == .dynamicpartitioning ? 670.0 : 760.0)
                        .scaleEffect(self.isAnimating ? 1: 0) 
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                withAnimation(Animation.spring()) {
                                    self.isAnimating = true
                                }
                            }
                        }
                }
                .contentShape(Rectangle())
            }
            .padding(.bottom, 400.0)
            Group {
                ForEach(apps) { app in
                    AppIconResizeView(memory: $memory, appToMem: $appToMem, memRects: $memRects, baseAppRects: $baseAppRects, appNotFitInMemory: $appNotFitInMemory, framesUsed: $framesUsed, technique: technique, app: app)
                }
            }
        }
        .coordinateSpace(name: "ContentViewCS")
    }
}
