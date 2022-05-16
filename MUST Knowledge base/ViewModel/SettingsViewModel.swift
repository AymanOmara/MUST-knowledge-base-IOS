//
//  SettingsViewModel.swift
//  MUST Knowledge base
//
//  Created by ARG on 16/05/2022.
//

import Foundation
class SettingsViewModel:SettingsViewModelContracts{
    
    var localModel: LocalModel = LocalModel.shared
    
    func clearAllFavorite() {
        localModel.removeAllFavoriteCourses()
    }
    
}
protocol SettingsViewModelContracts{
    var localModel:LocalModel{get}
    func clearAllFavorite()
}
