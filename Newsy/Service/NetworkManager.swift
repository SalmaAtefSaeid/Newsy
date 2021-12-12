//
//  NetworkManager.swift
//  Newsy
//
//  Created by Salma Atef on 09/12/2021.
//

import Foundation
import Alamofire

public enum HTTPMethodType: String {
   
   case options = "OPTIONS"
   case get     = "GET"
   case head    = "HEAD"
   case post    = "POST"
   case put     = "PUT"
   case patch   = "PATCH"
   case delete  = "DELETE"
   case trace   = "TRACE"
   case connect = "CONNECT"
   
}

class NetworkManager {
   
   func sendHTTPRequest<T: Codable>(urlString: String, httpMethod: String, parameters: [String:Any]?, successHandler: @escaping(T) -> Void, failureHandler: @escaping(Error) -> Void) {
       
       guard let apiURL = URL(string: urlString) else {return}
       if let isReachable = NetworkReachabilityManager(host: apiURL.host ?? "")?.isReachable, isReachable == true{
           let header = HTTPHeaders(["Accept": "application/json", "Content-Type": "application/json"])
           AF.request(apiURL, method: HTTPMethod(rawValue: httpMethod), parameters: parameters, headers: header).responseData{(dataResponse) in
               if let error = dataResponse.error{
                   failureHandler(error)
               }else if let data = dataResponse.data{
                   do{
                       let myCodableClass = try JSONDecoder().decode(T.self, from: data)
                       successHandler(myCodableClass)
                   }catch let error{
                       failureHandler(error)
                   }
               }
           }
       }else{
           let error = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue, userInfo: nil) as Error
           failureHandler(error)
       }
   }
}
