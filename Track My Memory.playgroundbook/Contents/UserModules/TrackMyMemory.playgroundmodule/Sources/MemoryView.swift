//
//  MemoryView.swift
//  WWDC21 Swift Student Challenge
//
//  Created by Diego Henrique Silva Oliveira on 14/04/21.
//

import SwiftUI

struct MemoryView: View {
    var technique : MemoryManagmentTechniques
    var memItem : MemoryItem
    @Binding var appToMem : [String : String]
    @Binding var framesUsed: [String: [Int]]
    
    var body: some View {
        if let frames = framesUsed[memItem.app ?? ""] {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black, lineWidth: 2.5)
                .frame(maxWidth: 160, maxHeight: 30, alignment: .center)
                .overlay(Text(frames.contains(Int(memItem.id)!) ? "": memItem.size >= 1000 ? "\(memItem.size/1000) GB": "\(memItem.size) MB").font(.system(size: 20, weight: .semibold, design: Font.Design.monospaced)).foregroundColor(.black))
                .background(RoundedRectangle(cornerRadius: 5).fill(Color.white).opacity(0.5))
                .padding(.bottom, -8.0)
                .background(
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(Color.clear)
                            .preference(key: MemoryItemPreferenceKey.self,
                                        value: [MemoryItemPreferenceData(memoryId: memItem.id, rect: geometry.frame(in: .named("ContentViewCS")))])
                    }
                )
        }
        else {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black, lineWidth: 2.5)
                .frame(maxWidth: 160, maxHeight: technique == .fixedpartitioning ? 110 : technique == .dynamicpartitioning && memItem.size < 200 ? 27.5 : technique == .dynamicpartitioning ? 550 * (CGFloat(memItem.size)/4000) : 30, alignment: .center)
                .overlay(Text(appToMem.values.contains(memItem.id) ? "": memItem.size >= 1000 ? String(format: "%.2f GB", (Double(Double(memItem.size)/1000))) : "\(memItem.size) MB").font(.system(size: 20, weight: .semibold, design: Font.Design.monospaced)).foregroundColor(.black))
                .background(RoundedRectangle(cornerRadius: 5).fill(Color.white).opacity(0.5))
                .padding(.bottom, -8.0)
                .background(
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(Color.clear)
                            .preference(key: MemoryItemPreferenceKey.self,
                                        value: [MemoryItemPreferenceData(memoryId: memItem.id, rect: geometry.frame(in: .named("ContentViewCS")))])
                    }
                )
        }
    }
}
