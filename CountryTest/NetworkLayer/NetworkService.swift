//
//  NetworkService.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import UIKit

protocol Networking {
    func request(url: URL, method: HttpMethod, completion: @escaping (Data?, Error?)-> Void)
    
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkService: Networking {
    
    var task: URLSessionDataTask?
    
    func request(url: URL, method: HttpMethod, completion: @escaping (Data?, Error?) -> Void) {
        self.task?.cancel()
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let task = createDataTask(from: request, completion: completion)
        self.task = task
        
        self.isLoading(true)
        self.task?.resume()
        
        
    }
    private func isLoading(_ status: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = status

        }

    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            defer {
                self?.task = nil
                self?.isLoading(false)
            }
            
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            if status == 404 {
                completion(nil, NetworkError.notFound)
                return
            }
            
            if let error = error as NSError? {
                if error.code == NSURLErrorCancelled {
                    return
                }
            }
            completion(data, error)
            
            
        }
    }
}
