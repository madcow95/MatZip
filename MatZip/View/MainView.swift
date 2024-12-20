//
//  TabView.swift
//  MatZip
//
//  Created by MadCow on 2024/12/20.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Tab("Map", image: "map.fill") {
                MapView()
            }
            
            Tab("Community", image: "shareplay") {
                CommunityView()
            }
        }
    }
}

#Preview {
    MainView()
}
