//
//  DummyCard.swift
//  AnimalCrossingTinder
//
//  Created by Tenzin Norden on 7/24/23.
//

import SwiftUI

struct DummyCard: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRad)
                    .opacity(0.10)
                    .frame(width: geo.size.width, height: geo.size.height)
                Text("EndOfTheLine")
            }
        }
    }
}

struct DummyCard_Previews: PreviewProvider {
    static var previews: some View {
        DummyCard()
    }
}
