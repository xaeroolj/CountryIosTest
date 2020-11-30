//
//  NetworkErrorTests.swift
//  CountryTestTests
//
//  Created by Roman Trekhlebov on 30.11.2020.
//

import XCTest
import Foundation
@testable import CountryTest

class NetworkErrorTests: XCTestCase {

    func testNetworkErrorGetterPositive() throws {
        
        var decodingError: NetworkError { .decodingError }
        var domainError: NetworkError { .domainError }
        var notFound: NetworkError { .notFound }
        var badUrlError: NetworkError { .badUrlError }
        
        let decodingResult = NSLocalizedString("decodingError", comment: "")
        let domainResult = NSLocalizedString("domainError", comment: "")
        let notFoundResult = NSLocalizedString("noFoundError", comment: "")
        let badUrlResult = NSLocalizedString("badUrlError", comment: "")
        
        XCTAssertEqual(decodingError.localizedDescription, decodingResult)
        XCTAssertEqual(domainError.localizedDescription, domainResult)
        XCTAssertEqual(notFound.localizedDescription, notFoundResult)
        XCTAssertEqual(badUrlError.localizedDescription, badUrlResult)

    }
    
    func testNetworkErrorGetterNegative() throws {
        
        var decodingError: NetworkError { .decodingError }
        var domainError: NetworkError { .domainError }
        var notFound: NetworkError { .notFound }
        var badUrlError: NetworkError { .badUrlError }
        
        
        XCTAssertNotEqual(decodingError.localizedDescription, "foo")
        XCTAssertNotEqual(domainError.localizedDescription, "foo")
        XCTAssertNotEqual(notFound.localizedDescription, "foo")
        XCTAssertNotEqual(badUrlError.localizedDescription, "foo")

    }
}
