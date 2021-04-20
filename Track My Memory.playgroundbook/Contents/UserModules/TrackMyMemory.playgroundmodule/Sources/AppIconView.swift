//
//  AppIconView.swift
//  WWDC21 Swift Student Challenge
//
//  Created by Diego Henrique Silva Oliveira on 14/04/21.
//

import SwiftUI

struct AppIconView: View {
    @Binding var appToMem : [String : String]
    @Binding var appNotFitInMemory: [String : Int]
    var technique: MemoryManagmentTechniques
    let app : Application
    
    var body: some View {
        
        if (technique == .fixedpartitioning) {
            Image(uiImage: app.iconImageName)
                .resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(maxWidth: 110, maxHeight: 110)
                .modifier(Shake(animatableData: CGFloat(appNotFitInMemory[app.id, default: 0])))
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 10)
                .background(
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(Color.clear)
                            .preference(key: AppItemPreferenceKey.self,
                                        value: [AppItemPreferenceData(appId: app.id, rect: geometry.frame(in: .named("ContentViewCS")))])
                    }
                )
            
            RoundedRectangle(cornerRadius: .infinity)
                .stroke(Color.black, lineWidth: 2.5)
                .frame(width: 120, height: 50)
                .overlay(Text(app.size >= 1000 ? String(format: "%.1f GB", (Double(Double(app.size)/1000))) : "\(app.size) MB").font(.system(size: 20, weight: .semibold, design: Font.Design.monospaced)).foregroundColor(.black))
                .background(RoundedRectangle(cornerRadius: .infinity).fill(Color.gray).opacity(0.5))
        }
        
        else {
            VStack {
                RoundedRectangle(cornerRadius: .infinity)
                    .stroke(Color.black, lineWidth: 2.5)
                    .frame(width: 90, height: 45)
                    .overlay(Text(app.size >= 1000 ? String(format: "%.1f GB", (Double(Double(app.size)/1000))) : "\(app.size) MB").font(.system(size: 17, weight: .semibold, design: Font.Design.monospaced)).foregroundColor(.black))
                    .background(RoundedRectangle(cornerRadius: .infinity).fill(Color.gray).opacity(0.5))
                
                Image(uiImage: app.iconImageName)
                    .resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: technique == .dynamicpartitioning ? 80 : 70, maxHeight: technique == .dynamicpartitioning ? 80 : 70)
                    .modifier(Shake(animatableData: CGFloat(appNotFitInMemory[app.id, default: 0])))
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 10)
                    .background(
                        GeometryReader { geometry in
                            Rectangle()
                                .fill(Color.clear)
                                .preference(key: AppItemPreferenceKey.self,
                                            value: [AppItemPreferenceData(appId: app.id, rect: geometry.frame(in: .named("ContentViewCS")))])
                        }
                    )
            }
        }
    }
}
