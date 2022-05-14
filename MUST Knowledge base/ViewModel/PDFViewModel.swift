//
//  PDFViewModel.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 14/05/2022.
//

import Foundation
import Combine
class PDFViewModel:ObservableObject,PDFViewModelContracts{
    var repo: Repo = Repo()
    @Published var isLoading = true
    @Published var data:Data?
    func getPDF(url:String) {
        repo.getDataFromURL(url: URL(string: url)!) {[weak self] data in
            guard let self = self else{return}
            guard let data = data else {return}
            self.data = data
            self.isLoading = false

        }
    }
}
protocol PDFViewModelContracts{
    var repo:Repo{get}
    func getPDF(url:String)
    
}
