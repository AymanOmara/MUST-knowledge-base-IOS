//
//  Repo.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 13/05/2022.
//

import Foundation
import Combine
class Repo {
    func getDataFromURL(url: URL,complition:@escaping(Data?)->Void) {
         
        let cancellable: AnyCancellable?
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
//        var request = URLRequest(url: URL)
//        request.httpMethod = "GET"
        
//        session.dataTask(with: URL, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
        session.dataTask(with: url) { (data, response, error) in
          if let error = error {
              print("error: \(error)")
          } else {
              let response = response as! HTTPURLResponse
              let data = data!
              complition(data)
              print("status: \(response.statusCode)")
              for (key, value) in response.allHeaderFields {
                  print("header: \(key) = \(value)")
              }
              print("body: \(data as NSData)")
          }
        }.resume()
        
//        let task = session.downloadTask(with: request)	{ data:NSData? , response:URLResponse? , error: NSError? in
////            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
////
//////                complition(data as! Data)
//////                print("Success: \(statusCode)")
//////                complition(response)
////            }
////            response.
//
//
//        }
//        let observation = task.progress.observe(\.fractionCompleted) { progress, _ in
//            complition(progress.fractionCompleted)
////          print(progress.fractionCompleted)
//        }
        
//        task.resume()
        

        
    }
}


