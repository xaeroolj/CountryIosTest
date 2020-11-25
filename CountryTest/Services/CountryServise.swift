//
//  CountryServise.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import Foundation

protocol CountryServiseProtocol {
    
    func getCountryFor(code: String, completion: @escaping (Result<Country, NetworkError>) -> Void)
    func getCountryName(name: String, completion: @escaping (Result<[Country], NetworkError>) -> Void)
}

final public class CountryServise: CountryServiseProtocol {

    private let dataFetcher = NetworkDataFetcher()

    //MARK: - Request Countryes for name
    func getCountryName(name: String, completion: @escaping (Result<[Country], NetworkError>) -> Void) {
        
        guard let url = UrlConstructor.getCountryByNameUrl(name: name ) else {
            completion(.failure(.badUrlError))
            return
        }
        var resource = Resource<[Country]>(url: url)
        resource.httpMethod = .get
        
        dataFetcher.fetchGenericJsonData(resource: resource) { (result) in
            completion(result)
        }

    }
    
    //MARK: - Request detail data for Country
    func getCountryFor(code: String, completion: @escaping (Result<Country, NetworkError>) -> Void) {
        guard let url = UrlConstructor.getCountryByCodeUrl(code: code) else {
            completion(.failure(.badUrlError))
            return
        }
        
        var resource = Resource<Country>(url: url)
        resource.httpMethod = .get
        
        dataFetcher.fetchGenericJsonData(resource: resource) { (result) in
            completion(result)
        }
    }
    
}
