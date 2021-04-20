//
//  AppButtonView.swift
//  WWDC21 Swift Student Challenge
//
//  Created by Diego Henrique Silva Oliveira on 14/04/21.
//

import SwiftUI
import PlaygroundSupport

struct AppButtonView: View {
    var technique : MemoryManagmentTechniques
    @Binding var firstRun : Bool
    @Binding var memory: Memory
    @Binding var appToMem: [String: String]
    @Binding var appNotFitInMemory: [String: Int]
    @Binding var framesUsed: [String : [Int]]
    
    let app: Application
    
    var body: some View {
        Button(action: {
            tryLoadApp(app)
        }, label: {
            RoundedRectangle(cornerRadius: .infinity)
                .stroke(Color.black, lineWidth: 2.5)
                .frame(width: technique == .fixedpartitioning ? 100 : 80, height: technique == .fixedpartitioning ? 50 : 45)
                .overlay(Text(appToMem.keys.contains(app.id) ? "Stop": "Run").font(.system(size: 20, weight: .semibold, design: Font.Design.monospaced)).foregroundColor(.black))
                .background(RoundedRectangle(cornerRadius: .infinity).fill(appToMem.keys.contains(app.id) ? Color.red:Color.green))
                .padding(.top, technique == .fixedpartitioning ? 118.0 : 140.0)
        })
    }
    
    func tryLoadApp(_ app: Application) {
        
        // App removal algorithm - Simple paging
        if (technique == .simplepaging) {
            let keyExists = framesUsed[app.id] != nil
            if (keyExists) {
                withAnimation(.easeInOut) {
                    for index in 0...framesUsed[app.id]!.count-1 {
                        memory.items.remove(at:framesUsed[app.id]![index])
                        memory.items.insert(MemoryItem(id: "\(framesUsed[app.id]![index])", size: 200, app: nil), at: framesUsed[app.id]![index])
                    }
                    framesUsed.removeValue(forKey: app.id)
                    _ = appToMem.removeValue(forKey: app.id)
                }
                return
            }
        }
        
        // App removal algorithm - Dynamic Partitioning
        if appToMem.keys.contains(app.id) {
            withAnimation(.easeInOut) {
                if (technique == .dynamicpartitioning) {
                    for (index, item) in memory.items.enumerated() {
                        if (appToMem[app.id] == item.id) {
                            if (((index != memory.items.count-1) && (index != 0)) && ((memory.items[index+1].app == nil) && (memory.items[index-1].app == nil))) {
                                memory.items.remove(at:index)
                                memory.items.insert(MemoryItem(id: "\(index)", size: app.size + memory.items[index].size + memory.items[index-1].size, app: nil), at: index)
                                memory.items.remove(at:index+1)
                                memory.items.remove(at:index-1)
                                break
                            }
                            else if (((index != memory.items.count-1) && (index != 0)) && ((memory.items[index-1].app != nil) && (memory.items[index+1].app != nil))) {
                                memory.items.remove(at:index)
                                memory.items.insert(MemoryItem(id: "\(index)", size: app.size, app: nil), at: index)
                                break
                            }
                            else if ((index != memory.items.count-1) && memory.items[index+1].app == nil) {
                                memory.items.remove(at:index)
                                memory.items.insert(MemoryItem(id: "\(index)", size: app.size + memory.items[index].size, app: nil), at: index)
                                memory.items.remove(at:index+1)
                                break
                            }
                            else if ((index != 0) && memory.items[index-1].app == nil) {
                                memory.items.remove(at:index)
                                memory.items.insert(MemoryItem(id: "\(index)", size: app.size + memory.items[index-1].size, app: nil), at: index)
                                memory.items.remove(at:index-1)
                                break
                            }
                            else if ((index == 0) && (memory.items[index+1].app != nil)) {
                                memory.items.remove(at:index)
                                memory.items.insert(MemoryItem(id: "\(index)", size: app.size, app: nil), at: index)
                            }
                            else if ((index == memory.items.count-1) && (memory.items[index-1].app != nil)) {
                                memory.items.remove(at:index)
                                memory.items.insert(MemoryItem(id: "\(index)", size: app.size, app: nil), at: index)
                            }
                        }
                    }
                    
                    for index in 0...memory.items.count-1 {
                        if ((index != 0) && ((memory.items[index].app == nil) && (memory.items[index-1].app == nil))) {
                            memory.items.insert(MemoryItem(id: "\(index)", size: memory.items[index].size + memory.items[index-1].size, app: nil), at: index)
                            memory.items.remove(at: index+1)
                            memory.items.remove(at: index-1)
                            break
                        }
                        else if ((index != memory.items.count-1) && ((memory.items[index].app == nil) && (memory.items[index+1].app == nil))) {
                            memory.items.insert(MemoryItem(id: "\(index)", size: memory.items[index].size + memory.items[index+1].size, app: nil), at: index)
                            memory.items.remove(at: index+1)
                            memory.items.remove(at: index+2)
                            break
                        }
                    }
                    
                    for index in 0...memory.items.count-1 {
                        if (index != Int(memory.items[index].id)) {
                            memory.items[index].id = String(index)
                        }
                        for (key, id) in appToMem {
                            if key == memory.items[index].app {
                                if id != memory.items[index].id {
                                    appToMem[key] = memory.items[index].id
                                }
                                break
                            }
                        }
                    }
                    
                }
                _ = appToMem.removeValue(forKey: app.id)
            }
            return
        }
        
        // App insertion algorithm - Simple Paging
        if (technique == .simplepaging) {
            let framesNeeded = ceil(Double(app.size)/200)
            var freeFrames : [Int] = []
            for index in 0...memory.items.count-1 {
                if (memory.items[index].app == nil) {
                    freeFrames.append(index)
                }
            }
            
            if freeFrames.count >= Int(framesNeeded) {
                if firstRun {
                    PlaygroundPage.current.assessmentStatus = .pass(message: "Great job 😁! An app is being executed in main memory. When you're ready to move on, press the \"Continue\" button.")
                    firstRun = false
                }
                withAnimation(.easeInOut) {
                    for index in 0...Int(framesNeeded)-1 {
                        memory.items.remove(at: freeFrames[index])
                        memory.items.insert(MemoryItem(id: "\(freeFrames[index])", size: 200, app: app.id), at: freeFrames[index])
                    }
                    
                    if freeFrames.count == Int(framesNeeded) {
                        framesUsed[app.id] = freeFrames
                    }
                    else {
                        let range = Int(framesNeeded)...freeFrames.count-1
                        freeFrames.removeSubrange(range)
                        framesUsed[app.id] = freeFrames
                    }
                    appToMem[app.id] = memory.items[freeFrames[0]].id
                }
            }
            
            else {
                withAnimation(.default) {
                    appNotFitInMemory[app.id, default: 0] += 1
                    PlaygroundPage.current.assessmentStatus = .fail(hints: ["Oh, no! This app couldn't be stored in memory. Try to free some memory before trying again 😬"], solution: nil)
                }
            }
            return
        }
        
        let firstFreeMemItem = memory.items.first { memItem in
            memItem.size >= app.size && !appToMem.values.contains(memItem.id)
        }
        
        if let memItem = firstFreeMemItem {
            appNotFitInMemory.removeValue(forKey: app.id)
            if firstRun {
                PlaygroundPage.current.assessmentStatus = .pass(message: "Great job 😁! An app is being executed in main memory. When you're ready to move on, press the \"Continue\" button.")
                firstRun = false
            }
            // App insertion algorithm - Fixed Partitioning
            withAnimation(.easeInOut) {
                appToMem[app.id] = memItem.id
                
                // App insertion algorithm - Dynamic Partitioning
                if (technique == .dynamicpartitioning) {
                    for (index, item) in memory.items.enumerated() {
                        if item.id == memItem.id {
                            memory.items.remove(at: index)
                            memory.items.insert(MemoryItem(id: "\(memItem.id)", size: app.size, app: app.id), at: index)
                            if (memItem.size - app.size != 0) {
                                memory.items.insert(MemoryItem(id: "\(Int(memItem.id)!+1)", size: memItem.size-app.size, app: nil), at: index+1)
                            }
                        }
                    }
                    
                    for index in 0...memory.items.count-1 {
                        if (index != Int(memory.items[index].id)) {
                            memory.items[index].id = String(index)
                        }
                        for (key, id) in appToMem {
                            if key == memory.items[index].app {
                                if id != memory.items[index].id {
                                    appToMem[key] = memory.items[index].id
                                }
                                break
                            }
                        }
                    }
                }
            }
        } else {
            withAnimation(.default) {
                appNotFitInMemory[app.id, default: 0] += 1
                if (technique == .fixedpartitioning) {
                    PlaygroundPage.current.assessmentStatus = .fail(hints: ["Oh, no! This app couldn't be stored in memory. Unfortunately, the partitions avaliable are smaller than the app's size 😕"], solution: nil)
                }
                else {
                    PlaygroundPage.current.assessmentStatus = .fail(hints: ["Oh, no! This app couldn't be stored in memory. Try to free some memory before trying again 😬"], solution: nil)
                }
            }
        }
    }
}
