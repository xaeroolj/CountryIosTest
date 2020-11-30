//
//  CountryServiseTests.swift
//  CountryTestTests
//
//  Created by Roman Trekhlebov on 30.11.2020.
//

import XCTest
@testable import CountryTest

class CountryServiseTests: XCTestCase {
    
    var dataService: CountryServise!

    override func setUpWithError() throws {
        dataService = CountryServise()
    }

    override func tearDownWithError() throws {
        dataService = nil
    }

    func testGetCountryBySpain() throws {
        let expectation = XCTestExpectation(description: "datarecived and checked")
        dataService.getCountryBy(name: "spain") { (result) in
            do {
               let resultArray =  try result.get().map {$0.countryName}
                if resultArray.count == 1 && resultArray.first == "Spain" {
                    expectation.fulfill()
                }
            } catch {return}
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testGetCountryForSpain() throws {
        let expectation = XCTestExpectation(description: "datarecived and checked")
        dataService.getCountryFor(code: "RUS") { (result) in
            do {
                let result =  try result.get()
                if result.countryName == "Russian Federation" {
                    expectation.fulfill()
                }
            } catch {return}
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
