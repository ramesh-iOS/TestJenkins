//
//  ServiceRequest.swift
//  Hider
//
//  Created by user on 25/06/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

class RequestService: RequestHandler {
    
    // method to connect with server
    private class func connectToServer(_ screen: LoadingProtocol, appendUrl url: String,httpMethod method: HTTPMethod,query queryItems: Parameters, completion:@escaping (Result<Data,ErrorResult>)->Void) {
        
        if !reachability.isReachable {
            completion(.failure(.network(string: "--No Internet Connection--")))
            return
        }
        
        screen.showActivityIndicator()
        let session = URLSession.shared
        let internalRequest = RequestBuilder.buildRequest(appendUrl: url,
                                                          method: method,
                                                          parameters: queryItems)
        guard let request = internalRequest else { print("invalid request"); return }
        let task = session.dataTask(with: request) { (data, response, error) in
            screen.hideActivityIndicator()
            if let error = error {
                completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                return
            }
            if let data = data {
                completion(.success(data))
            }
        }
        
        task.resume()
    }
    
    class func loginUser(_ screen:LoadingProtocol, queryItems: Parameters, completion:@escaping ((Result<User, ErrorResult>) -> Void)) {
        
        self.connectToServer(screen, appendUrl: "login", httpMethod: .POST, query: queryItems, completion: self.networkResult(completion: completion))
    }
}
