//
//  NetworkService.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import Foundation

protocol Networking {
    func request(url: URL, method: HttpMethod, completion: @escaping (Data?, Error?)-> Void)
    
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkService: Networking {
    
    func request(url: URL, method: HttpMethod, completion: @escaping (Data?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, error)
        }
    }
}
