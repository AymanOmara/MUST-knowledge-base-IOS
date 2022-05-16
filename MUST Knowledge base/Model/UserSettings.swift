//
//  UserSettings.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 16/05/2022.
//

import Foundation
class UserSettings: ObservableObject {
    @Published var isDarkModeEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isDarkModeEnabled, forKey: "isDarkModeEnabled")
        }
    }
    @Published var language :String{
        didSet{
            UserDefaults.standard.set(language, forKey: "language")
        }
    }
    
    init() {
        self.isDarkModeEnabled = UserDefaults.standard.object(forKey: "isDarkModeEnabled") as? Bool ?? false
        self.language = UserDefaults.standard.string(forKey: "language") ?? "en"
    }
}
