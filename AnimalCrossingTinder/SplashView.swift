//
//  SplashView.swift
//  AnimalCrossingTinder
//
//  Created by Tenzin Norden on 7/27/23.
//

import SwiftUI

struct SplashView: View {
    @State var isActive = false
    @State var size = 0.8
    var body: some View {
        if (isActive) {
            ContentView()
        } else {
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("house")
                        .scaleEffect(size)
                    Spacer()
                    Spacer()
                }
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.5)) {
                        size = 0.9
                    }
                }
            }
                .preferredColorScheme(.light)
                .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
