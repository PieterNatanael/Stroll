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
                    Image(systemName: "location.north.circle.fill")
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
                    Image(systemName: "figure.walk")
                    Text("Profile")
                }
                .tag(2)
            

            
        }
        .tint(Color(#colorLiteral(red: 0.8323512853, green: 0.6462482497, blue: 1, alpha: 1)))
        
    }
}
