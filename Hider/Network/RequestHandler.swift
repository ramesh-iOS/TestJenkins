//
//  RequestHandler.swift
//  Hider
//
//  Created by user on 25/06/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

class RequestHandler {
    
    class var reachability : Reachability {
        let reachability = Reachability()!
        return reachability
    }
    
    class func networkResult<T: Parceable>(completion: @escaping ((Result<[T], ErrorResult>) -> Void)) ->
        ((Result<Data, ErrorResult>) -> Void) {
            
            return { dataResult in 
                
                DispatchQueue.global(qos: .background).async(execute: { 
                    switch dataResult {
                    case .success(let data) : 
                        ParserHelper.parse(data: data, completion: completion)
                        break
                    case .failure(let error) :
                        print("Network error \(error)")
                        completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                        break
                    }
                })
                
            }
    }
    //completion:
    class func networkResult<T: Parceable>(completion: @escaping ((Result<T, ErrorResult>) -> Void)) -> 
        ((Result<Data, ErrorResult>) -> Void) {
            
            return { dataResult in 
                
                DispatchQueue.global(qos: .background).async(execute: { 
                    switch dataResult {
                    case .success(let data) : 
                        ParserHelper.parse(data: data, completion: completion)
                        break
                    case .failure(let error) :
                        print("Network error \(error)")
                        completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                        break
                    }
                })
                
            }
    }
}
