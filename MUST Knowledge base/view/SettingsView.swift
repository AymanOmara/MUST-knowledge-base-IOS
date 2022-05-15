//
//  SettingsView.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 14/05/2022.
//

import SwiftUI

struct SettingsView: View {
//    @State private var isOn = false
    @ObservedObject private var isDarkMode = UserSettings()
    var body: some View {
        Form{
            Section("app language") {
                Button(LocalizedStringKey("language")) {
                    
                }
                Button {
                    _isDarkMode.wrappedValue.username.toggle()
                    changeAppearanceMode()
                    
                } label: {
                    Toggle(LocalizedStringKey("darkmode"), isOn: $isDarkMode.username)
                        .onTapGesture {
                            _isDarkMode.wrappedValue.username.toggle()
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
        UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = isDarkMode.username ? .dark : .light
    }
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
class UserSettings: ObservableObject {
    @Published var username: Bool {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? Bool ?? false
    }
}
