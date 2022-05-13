//
//  Repo.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 13/05/2022.
//

import Foundation
import Combine
class Repo {
    func getDataFromURL(URL: URL,complition:@escaping(Double?)->Void) {
        
        let cancellable: AnyCancellable?
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.downloadTask(with: request)	{ data ,response , error in
            print((response as? HTTPURLResponse)?.statusCode)
         
        }
        complition(task.progress.fractionCompleted)
        task.resume()
        
//        cancellable = session.dataTaskPublisher(for: request)
//
//            .tryMap { element -> Data in
//                guard let httpResponse = element.response as? HTTPURLResponse,
//                      httpResponse.statusCode == 200 else {
//                    throw URLError(.badServerResponse)
//                }
//                return element.data
//            }.eraseToAnyPublisher()
//
//            .sink(receiveCompletion: {comp in}, receiveValue: { date in
//              print(date)
//            })
        
    }
}


