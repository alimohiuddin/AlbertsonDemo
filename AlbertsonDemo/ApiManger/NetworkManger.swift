//
//  NetworkManger.swift
//  AlbertsonDemo
//
//  Created by Ali Mohiuddin on 11/01/23.
//

import Foundation
import UIKit

class NetworkManger{
    
    static let shared = NetworkManger()
    private init(){}
    
    // Webservice Api Url
    
    struct ApiEndpoints {
        static let acronymUrl = "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf="
    }
    
    // Webservice Api Call
    func ApiCall(searchParam : String, completionHandler : @escaping(Result<[VarsData],Error>)-> Void){
        
        guard let url = URL.init(string: ApiEndpoints.acronymUrl.appending(searchParam)) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
            }else if let data = data {
                do{
                    let result = try JSONDecoder().decode([acronymModel].self, from: data)
                    var resultData : [VarsData] = []
                    if result.count > 0 {
                        let array = result[0].lfs ?? []
                       resultData = array.flatMap{$0.vars ?? []}
                    }
                    completionHandler(.success(resultData))

                }catch {
                    completionHandler(.failure(error))
                }
            }else{
                completionHandler(.failure(error!))
            }
        }.resume()
        
    }
    
}
