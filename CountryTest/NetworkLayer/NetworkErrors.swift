//
//  NetworkErrors.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case notFound
    case badUrlError
}
