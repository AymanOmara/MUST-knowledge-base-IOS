//
//  Repo.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 13/05/2022.
//

import Foundation
class Repo {
    func getDataFromURL(url: URL,complition:@escaping(Data?)->Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        session.dataTask(with: url) { (data, response, error) in
          if let error = error {
              print("error: \(error)")
          } else {
              complition(data!)
          }
        }.resume()
        
    }
}


