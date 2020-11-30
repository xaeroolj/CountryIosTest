//
//  NetworkErrors.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import Foundation

enum NetworkError: Error{
    case decodingError
    case domainError
    case notFound
    case badUrlError
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodingError:
            return NSLocalizedString("decodingError", comment: "")
        case .domainError:
            return NSLocalizedString("domainError", comment: "")
        case .notFound:
            return NSLocalizedString("noFoundError", comment: "")
        case .badUrlError:
            return NSLocalizedString("badUrlError", comment: "")
        }
    }
}
