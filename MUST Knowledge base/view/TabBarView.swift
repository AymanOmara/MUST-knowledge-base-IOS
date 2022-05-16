//
//  TabBarView.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 16/05/2022.
//

import SwiftUI

struct TabBarView:View{
    @State var selection = 1
    @State private var title = ""
    var courses:[Course]
    var body: some View{

        TabView{
            HomeView(courses: courses)
                .tabItem {
                    Image(systemName: "house")
                    Text(LocalizedStringKey("Home"))

                }.tag(1)
            
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart")
                    
                    Text(LocalizedStringKey("Favorite"))


                }.tag(2)
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text(LocalizedStringKey("settings"))

                    
                }.tag(3)
        }
        .navigationTitle(selection == 1 ? LocalizedStringKey("Home") : selection == 2 ? LocalizedStringKey("Favorite") : LocalizedStringKey("settings"))

    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(courses: AllFaculties.initFaculties()[0].majors[0].courses)
    }
}
