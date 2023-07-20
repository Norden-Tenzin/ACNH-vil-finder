//
//  ContentView.swift
//  AnimalCrossingTinder
//
//  Created by Tenzin Norden on 7/9/23.
//

import SwiftUI

struct ContentView: View {
    @State var villagers: [VillagerCard] = getJSONTest(from: "data", count: 5)
    @State var villagersLiked: [VillagerCard] = []

    func addVillagerToLiked (villager: VillagerCard) {
        print("LIKED")
        if let index = villagers.firstIndex(of: villager) {
            let removedVillager = villagers.remove(at: index)
            villagersLiked.append(removedVillager)
        }
    }

    func addVillagerToBack (villager: VillagerCard) {
        print("DISLIKED")
        if let index = villagers.firstIndex(of: villager) {
            let removedVillager = villagers.remove(at: index)
            villagers.append(removedVillager)
        }
    }

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 0) {
                Text("Discover")
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                    .font(.system(size: 45))
                ZStack {
                    ForEach(villagers, id: \.id) { villager in
                        Card(data: villager, addVillagerToLiked: addVillagerToLiked, addVillagerToBack: addVillagerToBack)
                    }
                }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                HStack {
                    Button {
                        let removed = villagers.remove(at: 0)
                        print(removed)
                        villagers.append(removed)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: cornerRad)
                                .frame(width: geo.size.width / 3, height: 50)
                                .foregroundColor(Color("card-background"))
                            Image(systemName: "arrowshape.turn.up.backward.fill")
                                .font(.system(size: 25))
                        }
                    }
                }
                    .padding(.horizontal)
                HStack {
                    Spacer()
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    Image(systemName: "heart.fill")
                    Spacer()
                }
                    .font(.system(size: 25))
                    .padding(10)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color("card-background"))
                    .cornerRadius(cornerRad)
                    .padding(.horizontal)
                    .padding(.top, 10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//struct CircleTap: View {
//    @State private var didTap: Bool = false
//    var body: some View {
//        Circle()
//            .fill(didTap ? .blue : .red)
//            .frame(width: 150, height: 150, alignment: .center)
//            .gesture(TapGesture(count: 2)
//                .onEnded { _ in
//                didTap.toggle()
//            })
//    }
//}
//
//struct CircleLongPress: View {
//    @State private var didLongPress: Bool = false
//    var body: some View {
//        Circle()
//            .scaleEffect(didLongPress ? 1.2 : 1)
//            .frame(width: 150, height: 150, alignment: .center)
//            .gesture(LongPressGesture(minimumDuration: 0.5)
//                .onEnded { _ in
//                didLongPress.toggle()
//            })
//            .animation(.easeOut, value: didLongPress)
//    }
//}
//
//struct RectangleLongPress: View {
//    @GestureState private var didLongPress: Bool = false
//    var body: some View {
//        Rectangle()
//            .foregroundColor(Color.purple)
//            .cornerRadius(40)
//            .scaleEffect(didLongPress ? 1.2 : 1)
//            .frame(width: 200, height: 200, alignment: .center)
//            .gesture(LongPressGesture(minimumDuration: 1.0)
//                .updating($didLongPress) { value, state, transcation in
//                state = value
//                print("\(value), \(state), \(transcation)")
//            })
//            .animation(.easeInOut, value: didLongPress)
//    }
//}
//
//struct RectangleDrag: View {
//    @State var dragOffset: CGSize = CGSize.zero
//    var body: some View {
//        Rectangle()
//            .cornerRadius(40)
//            .offset(y: dragOffset.height)
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//            .gesture(DragGesture()
//                .onChanged({ value in
//                dragOffset = value.translation
//            })
//                .onEnded({ value in
//                dragOffset = .zero
//            }))
//            .animation(.spring(), value: dragOffset)
//    }
//}
//
//struct RectangleMagnification: View {
//    @State var magScale: CGFloat = CGFloat.zero
//    @State var rotValue: Angle = .zero
//    var body: some View {
//        Rectangle()
//            .cornerRadius(40)
//            .scaleEffect(magScale)
//            .rotationEffect(rotValue)
//            .frame(width: 200, height: 200, alignment: .center)
//            .gesture(MagnificationGesture()
//                .onChanged({ value in
//                magScale = value
//            })
//                .onEnded({ value in
//                magScale = 1
//            })
//                .simultaneously(with: RotationGesture()
//                    .onChanged({ value in
//                    rotValue = value
//                })
//                    .onEnded({ value in
//                    rotValue = .zero
//                })
//            ))
//            .animation(.spring(), value: magScale)
//    }
//}
