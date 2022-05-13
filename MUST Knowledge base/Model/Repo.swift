//
//  Repo.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 13/05/2022.
//

import Foundation
import Combine
class Repo {
    func getDataFromURL(URL: URL,complition:@escaping(Data?)->Void) {
        
        let cancellable: AnyCancellable?
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.downloadTask(with: request)	{ data ,response , error in
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                print("Success: \(statusCode)")
//                complition(response)
            }
            
            
        }
//        let observation = task.progress.observe(\.fractionCompleted) { progress, _ in
//            complition(progress.fractionCompleted)
////          print(progress.fractionCompleted)
//        }
        
        task.resume()
        

        
    }
}


