//
//  AlertItem.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 13/05/2022.
//

import Foundation
import SwiftUI
struct AlertItem:Identifiable{
    var id = UUID()
    var title:Text
    var body:Text
    var dissmissButton:Alert.Button?
}
