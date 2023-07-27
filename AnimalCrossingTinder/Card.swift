//
//  Card.swift
//  AnimalCrossingTinder
//
//  Created by Tenzin Norden on 7/17/23.
//

import SwiftUI

var cornerRad: CGFloat = 30
private enum LikeDislike: Int {
    case like, dislike, none
}

struct Card: View {
    @ObservedObject var data: VillagerCard
    @State private var swipeStatus: LikeDislike = .none
    var addVillagerToLiked: (VillagerCard) -> Void
    var addVillagerToBack: (VillagerCard) -> Void

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: self.swipeStatus == .like ? .topLeading : .topTrailing) {
                Color("orange")
                VStack(alignment: .leading, spacing: 0) {
                    ZStack {
                        Image("card-img-background-img")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .cornerRadius(cornerRad)
                            .frame(width: geo.size.width)
                        Image(data.villager.name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 40)
                            .padding(.top, 40)
//                        AsyncImage(url: URL(string: data.villager.poster)) { image in
//                            image
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .padding(.horizontal, 40)
//                                .padding(.top, 40)
//                        } placeholder: {
//                            ProgressView()
//                        }
                    }
                        .background(.white)
                        .cornerRadius(cornerRad)
                        .frame(width: geo.size.width, height: (geo.size.height * 4) / 5)
                    VStack (spacing: 0) {
                        HStack {
                            Text("\(data.villager.name)")
                                .fixedSize()
                                .font(.custom("ArialRoundedMTBold", size: 40))
                                .foregroundColor(Color("text-color"))
                            Text(getGenderSymbol(gender: data.villager.gender))
                                .fixedSize()
                                .font(.system(size: 25))
                                .foregroundColor(Color("text-color"))
                                .frame(maxHeight: .infinity, alignment: .top)
                        }
                        Text("\(data.villager.personality)")
                            .fixedSize()
                            .font(.custom("ArialRoundedMTBold", size: 20))
                            .foregroundColor(Color("text-color"))
                            .padding([.leading, .bottom, .trailing], 10)
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
                        .background(Color("background"))
                        .cornerRadius(cornerRad - 10)
                        .padding(10)
                }
                if self.swipeStatus == .like {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 60))
                        .padding()
                        .cornerRadius(10)
                        .foregroundColor(Color("background"))
                        .padding(24)
                        .rotationEffect(.init(degrees: -10))
                        .transition(.opacity)
                } else if self.swipeStatus == .dislike {
                    Image(systemName: "heart.slash.fill")
                        .font(.system(size: 60))
                        .padding()
                        .cornerRadius(10)
                        .foregroundColor(Color("background"))
                        .padding(24)
                        .rotationEffect(.init(degrees: 10))
                        .transition(.opacity)
                }
            }
                .cornerRadius(cornerRad)
                .gesture(DragGesture(minimumDistance: 10)
                    .onChanged({ value in
                    if value.translation.width > 0 {
                        // swiping to the right and it goes past some value
                        if value.translation.width > 30 {
                            data.update(degreeTo: 5, valueTo: value.translation.width)
                            if value.translation.width > 90 {
                                swipeStatus = .like
                            }
                        } else if value.translation.width < 120 {
                            swipeStatus = .none
                        }
                        // swiping to the right and it dosent go past some value
                            else {
                            data.update(degreeTo: 0, valueTo: value.translation.width)
                            swipeStatus = .none
                        }
                    }
                    else if value.translation.width < 0 {
                        // swiping to the left and it goes past some value
                        if value.translation.width < -30 {
                            data.update(degreeTo: -5, valueTo: value.translation.width)
                            if value.translation.width < -90 {
                                swipeStatus = .dislike
                            }
                        } else if value.translation.width > -120 {
                            swipeStatus = .none
                        }
                        // swiping to the left and it dosent go past some value
                            else {
                            data.update(degreeTo: 0, valueTo: value.translation.width)
                            swipeStatus = .none
                        }
                    }
                })
                    .onEnded({ value in
                    if data.value > 0 {
                        // after a certain data.value adds card to "like"
                        if data.value > geo.size.width / 4 {
                            data.update(degreeTo: 0, valueTo: 500)
                            addVillagerToLiked(data)
                            swipeStatus = .none
                        }
                        else {
                            data.update(degreeTo: 0, valueTo: 0)
                            swipeStatus = .none
                        }
                    }
                    else if data.value < 0 {
                        // after a certain data.value adds card to "dislike"
                        if -data.value > geo.size.width / 4 {
                            data.update(degreeTo: 0, valueTo: -500)
                            addVillagerToBack(data)
                            swipeStatus = .none
                        }
                        else {
                            data.update(degreeTo: 0, valueTo: 0)
                            swipeStatus = .none
                        }
                    }
                }))
                .offset(x: data.value)
                .scaleEffect(abs(data.value) > 80 ? 0.95 : 1)
                .rotationEffect(.init(degrees: data.degree))
                .animation(.spring(response: 0.25), value: data.value)
        }
    }
}
//
//struct Card_Previews: PreviewProvider {
//    static var previews: some View {
//        Card(data: VillagerCard(villager: VillagerData(poster: "https://dodo.ac/np/images/9/91/Ace_amiibo.png", name: "Ace", species: "Bird", gender: "Male", personality: "Jock (A)", birthday: "August 11", catchphrase: "ace")),
//            addVillagerToLiked: { str in
//                print(str) },
//            addVillagerToBack: { str in
//                print(str)
//            })
//    }
//}
