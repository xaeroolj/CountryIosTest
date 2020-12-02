//
//  UrlConstructorTests.swift
//  CountryTestTests
//
//  Created by Roman Trekhlebov on 30.11.2020.
//

import XCTest
@testable import CountryTest

class UrlConstructorTests: XCTestCase {

    func testConstructPositive() throws {

        let codeResult = UrlConstructor.getCountryByCodeUrl(code: "Foo")?.absoluteString
        let nameResult = UrlConstructor.getCountryByNameUrl(name: "Foo")?.absoluteString

        XCTAssertNotNil(codeResult)
        XCTAssertNotNil(nameResult)

        XCTAssertEqual(codeResult!, Constants.UrlStrings.countryByCodeUrl + "Foo")
        XCTAssertEqual(nameResult!, Constants.UrlStrings.countryByNameUrl + "Foo")
    }

    func testConstructNegative() throws {

        let codeResult = UrlConstructor.getCountryByCodeUrl(code: "Foo")?.absoluteString
        let nameResult = UrlConstructor.getCountryByNameUrl(name: "Foo")?.absoluteString

        XCTAssertNotNil(codeResult)
        XCTAssertNotNil(nameResult)

        XCTAssertNotEqual(codeResult!, Constants.UrlStrings.countryByCodeUrl + "Bar")
        XCTAssertNotEqual(nameResult!, Constants.UrlStrings.countryByNameUrl + "Bar")
    }

}
