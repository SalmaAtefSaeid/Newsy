//
//  NetworkManager.swift
//  Newsy
//
//  Created by Salma Atef on 09/12/2021.
//

import UIKit

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
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    // MARK: - Generic HTTP Request
    func sendHTTPRequest<T: Codable>(urlString: String, httpMethod: HTTPMethodType, parameters: [String:Any]? = nil) async throws -> T {
        
        guard let apiURL = URL(string: urlString) else {throw URLError(.badURL)}
        
        guard var components = URLComponents(url: apiURL, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = parameters?.map { (key, value) in
            URLQueryItem(name: key, value: String(describing: value))
        }
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpMethod = httpMethod.rawValue
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard httpResponse.statusCode == 200 else {
            // Attempt to decode error model from the response data
            if let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                throw errorModel
            } else {
                throw URLError(.badServerResponse)
            }
        }
        
        do{
            let myCodableClass = try JSONDecoder().decode(T.self, from: data)
            return myCodableClass
        } catch {
            throw error
        }
    }
    
    // MARK: - Image Downloading with Caching
    func downloadImage(fromURLString urlString: String) async throws -> UIImage {
        let cacheKey = NSString(string: urlString)
        
        if let cachedImage = cache.object(forKey: cacheKey) {
            return cachedImage
        }
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard httpResponse.statusCode == 200 else {
            // Attempt to decode error model from the response data
            if let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                throw errorModel
            } else {
                throw URLError(.badServerResponse)
            }
        }
        
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeRawData)
        }
        
        self.cache.setObject(image, forKey: cacheKey)
        return image
    }
}
