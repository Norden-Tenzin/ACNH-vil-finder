//
//  OldCode.swift
//  AnimalCrossingTinder
//
//  Created by Tenzin Norden on 7/25/23.
//

import Foundation

//    init() {
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
//    }
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
