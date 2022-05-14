//
//  SettingsView.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 14/05/2022.
//

import SwiftUI

struct SettingsView: View {
    @State private var isOn = false
    var body: some View {
        Form{
            Section("app language") {
                Button(LocalizedStringKey("language")) {
                    
                }
                Button {
                    
                } label: {
                    Toggle(LocalizedStringKey("darkmode"), isOn: $isOn)
                }


            }
            Section(LocalizedStringKey("appdata_section")){
                Button{
                    
                }label: {
                    Text(LocalizedStringKey("clearalldata"))
                        .foregroundColor(Color.red)
                }
            }
            
        }.navigationTitle(LocalizedStringKey("settings"))
        
    }
        
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
