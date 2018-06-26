//
//  URLRequest.swift
//  Hider
//
//  Created by user on 25/06/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case POST
    case GET
}

final class RequestBuilder {
    
    static let timeoutInterval : TimeInterval = 120
    
    // url request builder method
    class func buildRequest(appendUrl url: String, method: HTTPMethod = .GET, parameters: [String:Any] = [:]) -> URLRequest? {
        
        let urlString = APIConstants.endPoint + url
        
        guard let requestUrl = URL(string: urlString) else {
            print("-wrong url format-")
            return nil
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method.rawValue
        request.timeoutInterval = RequestBuilder.timeoutInterval
        
        if method == .POST {
            self.postJsonRequestData(parameters, request: &request)
        }
        
        return request
    }
    
    // append post data with url request
    class func postJsonRequestData(_ parameters: [String:Any], request: inout URLRequest) {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = data
            request.allHTTPHeaderFields = ["content-type":"application/json",
                                           "cache-control":"no-cache"]
        }
        catch {
            assertionFailure("-invalid json format-")
        }
    }
}
