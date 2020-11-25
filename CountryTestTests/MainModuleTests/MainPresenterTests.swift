//
//  MainPresenterTests.swift
//  CountryTestTests
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import XCTest
@testable import CountryTest

class MockView: MainViewProtocol {
    
    func updateView() {
        
    }
    
    func showError(_ error: NetworkError) {
        
    }
    
}

class MockDataService: CountryServiseProtocol {
    func getCountryFor(code: String, completion: @escaping (Result<Country, NetworkError>) -> Void) {
        
    }
    
    func getCountryBy(name: String, completion: @escaping (Result<[Country], NetworkError>) -> Void) {
        
    }
    
}

class MainPresenterTests: XCTestCase {

    var view: MockView!
    var presenter: MainPresenter!
    var dataService: CountryServiseProtocol!
    
    override func setUpWithError() throws {
        view = MockView()
        dataService = MockDataService()
        presenter = MainPresenter(view: view, dataService: dataService)
    }
    
    override func tearDownWithError() throws {
        view = nil
        dataService = nil
        presenter = nil
    }
    
    func testModuleIsNotNil() throws {
        XCTAssertNotNil(view, "View is not nil")
        XCTAssertNotNil(dataService, "dataService is not nil")
        XCTAssertNotNil(presenter, "Presenter is not nil")
    }
    
    func testView() throws {
        presenter.dataService.getCountryBy(name: "ru") { [weak self] result in
            guard let self = self else { return }
        }
        
//        XCTAssertEqual(view.model?.countryName, "Baz")
        
    }
    
//    func testModel() throws {
//
//        XCTAssertEqual(model.countryName, "Baz")
//        XCTAssertEqual(model.countryCode, "Bar")
//
//    }
    

}
