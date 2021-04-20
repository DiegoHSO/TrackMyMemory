//
//  LayoutView.swift
//  WWDC21 Swift Student Challenge
//
//  Created by Diego Henrique Silva Oliveira on 14/04/21.
//

import SwiftUI

struct LayoutView: View {
    var technique: MemoryManagmentTechniques
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(red: 19/255, green: 43/255, blue: 92/255)]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.vertical)
        
        RoundedRectangle(cornerRadius: 50)
            .frame(width: technique == .fixedpartitioning ? 330 : technique == .dynamicpartitioning ? 930 : 960, height: technique == .fixedpartitioning ? 930 : 230)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .opacity(0.2)
            .padding(.top, technique == .fixedpartitioning ? 120 : 820)
            .padding(.trailing, technique == .fixedpartitioning ? 575 : -5)
        
        RoundedRectangle(cornerRadius: 50)
            .frame(width: 260, height: 650)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .opacity(0.2)
            .padding(technique == .fixedpartitioning ? .top : .bottom, technique == .fixedpartitioning ? 90 : 220)
            .padding(.leading, technique == .fixedpartitioning ? 675.0 : 0)
        
        Text(technique == .fixedpartitioning ? "Fixed Partitioning" : technique == .dynamicpartitioning ? "Dynamic Partitioning" : "Simple Paging")
            .padding(.top, -580.0)
            .padding(.trailing, 120)
            .font(.system(size: 60, weight: .semibold, design: Font.Design.monospaced))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .frame(width: 990.0, height: 200.0)
            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 0.1, x: -1, y: 4)
            .modifier(SkewedOffset(offset: 10, pct: 0.05, goingRight: true))
    }
}

// For italic title
struct SkewedOffset: GeometryEffect {
    var offset: CGFloat
    var pct: CGFloat
    let goingRight: Bool
    
    init(offset: CGFloat, pct: CGFloat, goingRight: Bool) {
        self.offset = offset
        self.pct = pct
        self.goingRight = goingRight
    }
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { return AnimatablePair<CGFloat, CGFloat>(offset, pct) }
        set {
            offset = newValue.first
            pct = newValue.second
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        var skew: CGFloat
        
        if pct < 0.2 {
            skew = (pct * 5) * 0.5 * (goingRight ? -1 : 1)
        } else if pct > 0.8 {
            skew = ((1 - pct) * 5) * 0.5 * (goingRight ? -1 : 1)
        } else {
            skew = 0.5 * (goingRight ? -1 : 1)
        }
        
        return ProjectionTransform(CGAffineTransform(a: 1, b: 0, c: skew, d: 1, tx: offset, ty: 0))
    }
}
