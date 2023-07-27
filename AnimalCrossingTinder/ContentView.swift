//
//  ContentView.swift
//  AnimalCrossingTinder
//
//  Created by Tenzin Norden on 7/9/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var villagerCards: VillagerCards = VillagerCards(villagers: getJSON(from: "data"))
    @ObservedObject var villagersLiked: VillagerCards = VillagerCards(villagers: [])
    @State var undoList: [String] = []
    @State var newSelection: TabBarItem = TabBarItem(img: "magnifyingglass", text: "discover")
    @State var unHeartAlert: Bool = false

    init() {
        let doesDataExist = doesFileExist(at: "data.json") ?? false
        if (doesDataExist) {
            villagerCards = VillagerCards(villagers: villagerDataToVillagerCard(villagerList: readJSON(from: "data", to: villagerCards)))
        } else {
            writeJSON(to: "data", villagers: getJSON(from: "data"))
        }

        let doesDataLikedExist = doesFileExist(at: "data-liked.json") ?? false
        if (doesDataLikedExist) {
            villagersLiked = VillagerCards(villagers: villagerDataToVillagerCard(villagerList: readJSON(from: "data-liked", to: villagerCards)))
        } else {
            writeJSON(to: "data-liked", villagers: [])
        }
    }

    func addVillagerToLiked (villager: VillagerCard) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            if let index = villagerCards.villagers.firstIndex(of: villager) {
                let removedVillager = villagerCards.villagers.remove(at: index)
                villagersLiked.villagers.append(removedVillager)
                writeJSON(to: "data", villagers: villagerCards.villagers)
                writeJSON(to: "data-liked", villagers: villagersLiked.villagers)
            }
        }
    }

    func addVillagerToBack (villager: VillagerCard) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            if let index = villagerCards.villagers.firstIndex(of: villager) {
                let removedVillager = villagerCards.villagers.remove(at: index)
                removedVillager.addToDeck()
                villagerCards.villagers.append(removedVillager)
                undoList.append("undo")
                writeJSON(to: "data", villagers: villagerCards.villagers)
            }
        }
    }

    func removeVillagerFromLiked(villager: VillagerCard) {
        if let index = villagersLiked.villagers.firstIndex(of: villager) {
            let removedVillagers = villagersLiked.villagers.remove(at: index)
            villagerCards.villagers.append(removedVillagers)
            undoList = []
        }
    }

    var body: some View {
        CustomTabBarContainerView(selection: $newSelection) {
            GeometryReader { geo in
                VStack(alignment: .center, spacing: 0) {
                    Text("Discover")
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        .font(.custom("nintendoP_Humming-E_002pr", size: 45))
                        .foregroundColor(Color("text-color"))
                    ZStack {
                        DummyCard()
                        ForEach(villagerCards.villagers.prefix(10).reversed(), id: \.id) { villager in
                            Group {
                                ZStack {
                                    if (villagerCards.villagers.firstIndex(of: villager) == 0) {
                                        GlassCard()
                                    }
                                    Card(data: villager, addVillagerToLiked: addVillagerToLiked, addVillagerToBack: addVillagerToBack)
                                }
                            }
                        }
                    }
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    HStack {
                        Button {
                            let removed = villagerCards.villagers.removeLast()
                            villagerCards.villagers.insert(removed, at: 0)
                            undoList.removeLast()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: cornerRad)
                                    .frame(width: geo.size.width / 3, height: 50)
                                    .foregroundColor(Color("orange"))
                                Image(systemName: "arrowshape.turn.up.backward.fill")
                                    .font(.system(size: 25))
                            }
                        }.disabled(undoList.count < 1)
                    }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                }
                    .background(Color("background"))
            }
                .tabBarItem(tab: TabBarItem(img: "magnifyingglass", text: "discover"), selection: $newSelection)
            GeometryReader { geo in
                VStack(spacing: 0) {
                    Text("Favorite")
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        .font(.custom("nintendoP_Humming-E_002pr", size: 45))
                        .foregroundColor(Color("text-color"))
                        .frame(maxWidth: .infinity, alignment: .center)
                    ZStack {
                        Color("orange")
                            .cornerRadius(cornerRad)
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(villagersLiked.villagers.reversed(), id: \.id) { villager in
                                    HStack(alignment: .top, spacing: 10) {
                                        ZStack {
                                            Image("card-img-background-img")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .cornerRadius(cornerRad)
                                            Image(villager.villager.name)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .padding(2.5)
//                                            AsyncImage(url: URL(string: villager.villager.poster)) { image in
//                                                image
//                                                    .resizable()
//                                                    .aspectRatio(contentMode: .fit)
//                                                    .padding(2.5)
//                                            } placeholder: {
//                                                ProgressView()
//                                            }
                                        }
                                            .background(.white)
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(cornerRad - 10)
                                            .clipped()
                                        VStack (alignment: .leading, spacing: 0) {
                                            HStack (alignment: .top, spacing: 5) {
                                                Text("\(villager.villager.name)")
                                                    .font(.custom("ArialRoundedMTBold", size: 24))
                                                    .foregroundColor(Color("text-color"))
                                                Text(getGenderSymbol(gender: villager.villager.gender))
                                                    .font(.system(size: 20))
                                                    .foregroundColor(Color("text-color"))
                                                Spacer()
                                                Image(systemName: "heart.slash.fill")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(Color("text-color"))
                                                    .onTapGesture {
                                                    unHeartAlert = true
                                                }
                                            }
                                            Text("\(villager.villager.personality)")
                                                .fixedSize()
                                                .font(.custom("ArialRoundedMTBold", size: 20))
                                                .foregroundColor(Color("text-color"))
                                                .padding(.leading, 20)
                                            Spacer()
                                        }
                                            .padding(.top, 10)
                                            .frame(maxWidth: .infinity, minHeight: 90)
                                            .padding(.horizontal, 15)
                                            .background(Color("background"))
                                            .cornerRadius(cornerRad - 10)
                                    }
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal, 10)
                                        .alert(isPresented: $unHeartAlert) {
                                        Alert(title: Text("Do you want to remove \(villager.villager.name)"), primaryButton: .cancel(),
                                            secondaryButton: .destructive(Text("Confirm")) {
                                                removeVillagerFromLiked(villager: villager) })
                                    }
                                }
                                Spacer()
                            }
                                .padding([.top], 10)
                        }
                            .cornerRadius(cornerRad)
                            .clipped()
                    }
                        .padding(.horizontal)
                        .padding([.bottom], 10)
                }
                    .background(Color("background"))
            }
                .tabBarItem(tab: TabBarItem(img: "heart.fill", text: "heart"), selection: $newSelection)
        }
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
