//
//  RouterTests.swift
//  CountryTestTests
//
//  Created by Roman Trekhlebov on 26.11.2020.
//

import XCTest
@testable import CountryTest

class RouterTests: XCTestCase {
    var router: RouterProtocol!
    var navigatioController: UINavigationController!
    var assembly: AssemblyModuleBuilder!

    override func setUpWithError() throws {
        
        navigatioController = UINavigationController()
        assembly = AssemblyModuleBuilder()
        router = Router(navigationController: navigatioController, assemblyBuilder: assembly)
    }
     

    override func tearDownWithError() throws {
        router = nil
        navigatioController = nil
        assembly = nil
    }

    func testInitialViewController() throws {
        router.initialViewController()
        let rootVC = navigatioController.viewControllers.first
        XCTAssertTrue(rootVC is MainViewController)
    }
    
    func testShowDetail() {
        
        let country = Country(countryName: "foo",
                              countryCode: "baz",
                              countryFlag: "bar",
                              countryNativeName: "фоо",
                              countryLanguages: [],
                              countryCurrencies: [],
                              countryBorders: [])
        router.showDetail(country: country)
        
        let visibleVC = navigatioController.visibleViewController
        XCTAssertNotNil(visibleVC)
        XCTAssertTrue(visibleVC is DetailViewController)
    }

    func testShowNewDetail() {
        
        router.showNewCountryDetail(code: "Foo")
        
        let visibleVC = navigatioController.visibleViewController
        XCTAssertNotNil(visibleVC)
        XCTAssertTrue(visibleVC is DetailViewController)
    }
    
    func testPopToRoot() {
        router.initialViewController()
        router.popToRoot()
        let visibleVC = navigatioController.visibleViewController
        XCTAssertNotNil(visibleVC)
        XCTAssertTrue(visibleVC is MainViewController)
    }
    

}
