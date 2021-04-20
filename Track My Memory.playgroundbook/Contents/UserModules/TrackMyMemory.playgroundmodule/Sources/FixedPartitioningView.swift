//
//  FixedPartitioningView.swift
//  WWDC21 Swift Student Challenge
//
//  Created by Diego Henrique Silva Oliveira on 14/04/21.
//

import SwiftUI
import PlaygroundSupport

public struct FixedPartitioningView: View {
    
    var technique: MemoryManagmentTechniques = .fixedpartitioning
    var apps: [Application] = Application.fixedPartitioningApps
    @State private var memory: Memory = .fixedMemory
    @State var firstRun = true
    @State var isAnimating = false
    @State private var memRects: [String: CGRect] = [:]
    @State private var baseAppRects: [String: CGRect] = [:]
    @State private var appToMem: [String: String] = [:]
    @State private var appNotFitInMemory: [String : Int] = [:]
    @State private var framesUsed: [String : [Int]] = [:]
    
    public init() {}
    public var body: some View {
        ZStack {
            LayoutView(technique: technique)
            VStack (spacing: -60) {
                HStack {
                    VStack {
                        ForEach(apps) { app in
                            AppIconView(appToMem: $appToMem, appNotFitInMemory: $appNotFitInMemory, technique: technique, app : app)
                        }
                    }
                    .padding(.top, 545.0)
                    .onPreferenceChange(AppItemPreferenceKey.self) { appItemRects in
                        for appItemData in appItemRects {
                            baseAppRects[appItemData.appId] = appItemData.rect
                        }
                    }
                    
                    VStack {
                        ForEach(apps) { app in
                            AppButtonView(technique: technique, firstRun: $firstRun, memory: $memory, appToMem: $appToMem, appNotFitInMemory: $appNotFitInMemory, framesUsed: $framesUsed, app: app)
                        }
                    }
                    .padding(.leading, 10.0)
                    .padding(.trailing, 425.0)
                    .padding(.top, 380.0)
                    
                    VStack {
                        ForEach(memory.items) { memItem in
                            MemoryView(technique: technique, memItem: memItem, appToMem: $appToMem, framesUsed: $framesUsed)
                        }
                    }
                    .padding(.top, 515.0)
                    .onPreferenceChange(MemoryItemPreferenceKey.self) { memItemRects in
                        for memItemData in memItemRects {
                            memRects[memItemData.memoryId] = memItemData.rect
                        }
                    }
                }
                .padding(.top, 280)
                Button(action: {
                    PlaygroundPage.current.navigateTo(page: .pageReference(reference: "Dynamic Partitioning"))
                }) {
                    Text("Continue")
                        .frame(width: 200.0, height: 78.0)
                        .font(.system(size: 30, weight: .semibold, design: Font.Design.monospaced))
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 5, x: 10, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: .infinity)
                                .stroke(Color.white, lineWidth: 1.5)
                        ).background(RoundedRectangle(cornerRadius: .infinity).fill(Color.black))
                        .padding(.bottom, 300)
                        .padding(.leading, 670.0)
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

