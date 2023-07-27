//
//  GlassCard.swift
//  AnimalCrossingTinder
//
//  Created by Tenzin Norden on 7/24/23.
//

import SwiftUI

struct GlassCard: View {
    var body: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: cornerRad)
                .fill(Color.black)
                .opacity(0.10)
                .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct GlassCard_Previews: PreviewProvider {
    static var previews: some View {
        GlassCard()
    }
}
