//
//  CustomTabBarView.swift
//  AnimalCrossingTinder
//
//  Created by Tenzin Norden on 7/25/23.
//

import SwiftUI

struct CustomTabBarView: View {
    @State var tabs: [TabBarItem]
    @Binding var selection: TabBarItem;
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                    switchToTab(tab: tab)
                }
            }
        }
            .font(.system(size: 25))
            .padding(10)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 50)
            .background(Color("orange"))
            .cornerRadius(cornerRad)
            .padding(.horizontal)
            .background(Color("background"))
    }
}

//struct CustomTabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            Spacer()
//            CustomTabBarView(selection: .constant("discover"))
//        }
//    }
//}

extension CustomTabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.img
            )
        }
            .foregroundColor(selection.text == tab.text ? Color("background") : Color("dark-orange"))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .scaleEffect(selection.text == tab.text ? 1.2 : 1)
    }

    private func switchToTab(tab: TabBarItem) {
        withAnimation(.easeInOut) {
            self.selection = tab
        }
    }
}

struct TabBarItem: Hashable {
    let img: String;
    var text: String;
}
