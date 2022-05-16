//
//  SettingsView.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 14/05/2022.
//

import SwiftUI

struct SettingsView: View {

    @ObservedObject private var isDarkMode = UserSettings()
    var body: some View {
        Form{
            Section("app language") {
                Button(LocalizedStringKey("language")) {
                    if isDarkMode.language == "en"{
                        isDarkMode.language = "ar"
                    }else{
                        isDarkMode.language = "en"
                    }
                }
                Button {
                    _isDarkMode.wrappedValue.isDarkModeEnabled.toggle()
                    changeAppearanceMode()
                    
                } label: {
                    Toggle(LocalizedStringKey("darkmode"), isOn: $isDarkMode.isDarkModeEnabled)
                        .onTapGesture {
                            _isDarkMode.wrappedValue.isDarkModeEnabled.toggle()
                            changeAppearanceMode()
                            
                        }
                }
                
                
            }
            Section(LocalizedStringKey("appdata_section")){
                Button{
                    
                }label: {
                    Text(LocalizedStringKey("clearalldata"))
                        .foregroundColor(Color.red)
                }
            }
        }
        .navigationTitle(LocalizedStringKey("settings"))
    }
    func changeAppearanceMode(){
        UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = isDarkMode.isDarkModeEnabled ? .dark : .light
        
        
    }
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
