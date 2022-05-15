//
//  MUST_Knowledge_baseApp.swift
//  MUST Knowledge base
//
//  Created by Ayman on 10/05/2022.
//

import SwiftUI

@main
struct MUST_Knowledge_baseApp: App {
   var  userSettings = UserSettings()
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            WelcomeView()
//                .environment(\.locale, .init(identifier:"en"))
        }
    }
}
