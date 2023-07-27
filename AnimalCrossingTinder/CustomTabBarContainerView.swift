//
//  CustomTabBarContainerView.swift
//  AnimalCrossingTinder
//
//  Created by Tenzin Norden on 7/25/23.
//

import SwiftUI

//let tabs = [TabBarItem(img: "magnifyingglass", text: "discover"), TabBarItem(img: "heart.fill", text: "heart")]

struct CustomTabBarContainerView <Content: View>: View {
    @Binding var selection: TabBarItem
    @State var tabs: [TabBarItem] = [TabBarItem(img: "magnifyingglass", text: "discover"), TabBarItem(img: "heart.fill", text: "heart")]
    let content: Content
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                content
            }
            CustomTabBarView(tabs: tabs, selection: $selection)
        }
            .onPreferenceChange(TabBarItemPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
    static let tabs = [TabBarItem(img: "magnifyingglass", text: "discover"), TabBarItem(img: "heart.fill", text: "heart")]
    static var previews: some View {
        CustomTabBarContainerView(selection: .constant(tabs.first!), content: {
                Color.red
            })
    }
}
