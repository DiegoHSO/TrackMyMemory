//
//  MemorySetting.swift
//  WWDC21 Swift Student Challenge
//
//  Created by Diego Henrique Silva Oliveira on 14/04/21.
//

import SwiftUI

struct MemoryItem: Identifiable, Hashable {
    var id: String
    var size: Int
    var app: String?
}

struct Memory {
    var items: [MemoryItem]
    
    static var fixedMemory: Memory {
        Memory(items: (0..<5).map { MemoryItem(id: "\($0)", size: 800, app: nil) })
    }
    
    static var dynamicMemory: Memory {
        Memory(items: (0..<1).map { MemoryItem(id: "\($0)", size: 4000, app: nil) } )
    }
    
    static var simplePagingMemory: Memory {
        Memory(items: (0..<20).map { MemoryItem(id: "\($0)", size: 200, app: nil) } )
    }
    
}

struct MemoryItemPreferenceData: Equatable {
    let memoryId: String
    let rect: CGRect
}

struct MemoryItemPreferenceKey: PreferenceKey {
    typealias Value = [MemoryItemPreferenceData]
    
    static var defaultValue: [MemoryItemPreferenceData] = []
    
    static func reduce(value: inout [MemoryItemPreferenceData], nextValue: () -> [MemoryItemPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

public enum MemoryManagmentTechniques{
    case fixedpartitioning
    case dynamicpartitioning
    case simplepaging
}
