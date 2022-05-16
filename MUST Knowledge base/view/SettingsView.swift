//
//  SettingsView.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 14/05/2022.
//

import SwiftUI

struct SettingsView: View {
    private var settingsViewModel:SettingsViewModelContracts = SettingsViewModel()
    @State private var shouldShowDataDeleted = true
    @ObservedObject private var isDarkMode = UserSettings()
    @State private var shouldShowActionSheet = false
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
                    shouldShowActionSheet = true
                }label: {
                    Text(LocalizedStringKey("clearalldata"))
                        .foregroundColor(Color.red)
                }
            }
            if shouldShowDataDeleted {
                AlertView(shown: $shouldShowDataDeleted , isSuccess: shouldShowDataDeleted, message: "message")
                    .background(Color.clear)
                    .onAppear{
                    if shouldShowDataDeleted{
                        changeState()
                    }
                }
                
            }
        }
        .navigationTitle(LocalizedStringKey("settings"))

        .confirmationDialog(LocalizedStringKey("submit_clearData"), isPresented: $shouldShowActionSheet, titleVisibility: .visible) {
            Button(role: .destructive) {
                settingsViewModel.clearAllFavorite()
                shouldShowDataDeleted = true
            } label: {
                Text(LocalizedStringKey("yes_remove"))
                    .foregroundColor(Color.red)

            }

        }

        

    }
    func changeState(){
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            shouldShowDataDeleted = false
        }
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

struct AlertView: View {
     
     @Binding var shown: Bool

     var isSuccess: Bool
     var message: String
     
     var body: some View {
         VStack {
             
             Image(isSuccess ? "check":"remove")
                 .resizable()
                 .frame(width: 50, height: 50)
                 .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
             Spacer()
             Text(message)
                 .foregroundColor(Color.white)
             Spacer()
             
             
         }.frame(width: UIScreen.main.bounds.width-50, height: 200)
         
         .background(Color.black.opacity(0.5))

         
     }
 }
