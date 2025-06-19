//
//  MainAppView.swift
//  SOS Light
//
//  Created by Pieter Yoshua Natanael on 30/11/24.
//

import SwiftUI
import CoreLocation

struct MainAppView: View {
    @State private var selectedTab = 0

    init() {
        // Customize the tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black // Tab bar background color
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(white: 0.7, alpha: 1.0) // unselected icon
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(white: 0.7, alpha: 1.0)] // unselected text
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(displayP3Red: 0.832, green: 0.646, blue: 1, alpha: 1)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(displayP3Red: 0.832, green: 0.646, blue: 1, alpha: 1)]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            ContentView()
                .tabItem {
                    Image(systemName: "light.max")
                    Text("Cards")
                }
                .tag(3)

            ContentView()
                .tabItem {
                    Image(systemName: "flame.circle")
                    Text("Bonfire")
                }
                .tag(1)

            MatchesView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Matches")
                }
                .tag(0)

            ContentView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                        Text("Profile")
                    
                }
                .tag(2)
        }
        .tint(Color(#colorLiteral(red: 0.8323512853, green: 0.6462482497, blue: 1, alpha: 1))) // Selected tab color
    }
}
