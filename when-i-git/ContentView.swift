//
//  ContentView.swift
//  when-i-git
//
//  Created by 김민택 on 2023/03/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            UserListView()
                .tabItem({
                    Image(systemName: "square.grid.3x3.square")
                    Text("Users")
                })
            HelpView()
                .tabItem({
                    Image(systemName: "questionmark.app")
                    Text("Help")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
