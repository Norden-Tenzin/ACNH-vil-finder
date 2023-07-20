//
//  Card.swift
//  AnimalCrossingTinder
//
//  Created by Tenzin Norden on 7/17/23.
//

import SwiftUI

var cornerRad: CGFloat = 30

struct Card: View {
    @State var data: VillagerCard
    var addVillagerToLiked: (VillagerCard) -> Void
    var addVillagerToBack: (VillagerCard) -> Void

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Color("card-background")
                VStack(alignment: .leading, spacing: 0) {
                    ZStack {
                        Color("card-img-background")
                        AsyncImage(url: URL(string: data.villager.poster)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal, 40)
                                .padding(.top, 40)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                        .background(.white)
                        .cornerRadius(cornerRad)
                        .frame(width: geo.size.width, height: (geo.size.height * 4) / 5)
                    VStack {
                        HStack {
                            Text("\(data.villager.name)")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                            Image(systemName: "person")
                                .font(.system(size: 30))
                        }
                        Text("\(data.villager.personality)")
                            .font(.system(size: 20))
                    }
                        .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                        .padding(.horizontal, 25)
                        .padding(.vertical, 10)
                        .background(.white)
                        .cornerRadius(cornerRad - 10)
                        .padding(10)
//                        .frame(height: geo.size.height / 5, alignment: .topLeading)
                }
            }
                .cornerRadius(cornerRad)
                .gesture(DragGesture()
                    .onChanged({ value in
                    if value.translation.width > 0 {
                        // swiping to the right and it goes past some value
                        if value.translation.width > 30 {
                            data.update(degreeTo: 12, valueTo: value.translation.width)
                        }
                        // swiping to the right and it dosent go past some value
                            else {
                            print("INCHANGED RIGHT ELSE")
                            data.update(degreeTo: 0, valueTo: value.translation.width)
                        }
                    }
                    else {
                        // swiping to the left and it goes past some value
                        if value.translation.width < -30 {
                            data.update(degreeTo: -12, valueTo: value.translation.width)
                        }
                        // swiping to the left and it dosent go past some value
                            else {
                            print("INCHANGED LEFT ELSE")
                            data.update(degreeTo: 0, valueTo: value.translation.width)
                        }
                    }
                })
                    .onEnded({ value in
                    if data.value > 0 {
                        // after a certain data.value adds card to "like"
                        if data.value > geo.size.width / 4 {
                            data.update(degreeTo: 0, valueTo: 500)
                            addVillagerToLiked(data)
                        }
                        else {
                            data.update(degreeTo: 0, valueTo: 0)
                        }
                    }
                    else if data.value < 0 {
                        // after a certain data.value adds card to "dislike"
                        if -data.value > geo.size.width / 4 {
                            data.update(degreeTo: 0, valueTo: -500)
                            addVillagerToBack(data)
                        }
                        else {
                            data.update(degreeTo: 0, valueTo: 0)
                        }
                    }
                }))
                .offset(x: data.value)
                .scaleEffect(abs(data.value) > 80 ? 0.9 : 1)
                .rotationEffect(.init(degrees: data.degree))
                .animation(.spring(response: 0.25), value: data.value)
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(data: VillagerCard(villager: VillagerData(poster: "https://dodo.ac/np/images/9/91/Ace_amiibo.png", name: "Ace", species: "Bird", gender: "Male", personality: "Jock (A)", birthday: "August 11", catchphrase: "ace"), degree: 0, value: 0),
            addVillagerToLiked: { str in
                print(str) },
            addVillagerToBack: { str in
                print(str)
            })
    }
}
