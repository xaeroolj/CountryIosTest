//
//  MainPresenterTests.swift
//  CountryTestTests
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import XCTest
@testable import CountryTest

class MockView: MainViewProtocol {
    
    var model: Country?
    
    func setSource(source: Country) {
        self.model = source
    }
    
    
}

class MainPresenterTests: XCTestCase {

    var view: MockView!
    var model: Country!
    var presenter: MainPresenter!
    
    override func setUpWithError() throws {
        view = MockView()
        model = Country(countryName: "Baz", countryCode: "Bar")
        presenter = MainPresenter(view: view, model: model)
    }
    
    override func tearDownWithError() throws {
        view = nil
        model = nil
        presenter = nil
    }
    
    func testModuleIsNotNil() throws {
        XCTAssertNotNil(view, "View is not nil")
        XCTAssertNotNil(model, "Model is not nil")
        XCTAssertNotNil(presenter, "Presenter is not nil")
    }
    
    func testView() throws {
        presenter.loadSource()
        
        XCTAssertEqual(view.model?.countryName, "Baz")
        XCTAssertEqual(view.model?.countryCode, "Bar")
    }
    
    func testModel() throws {
        
        XCTAssertEqual(model.countryName, "Baz")
        XCTAssertEqual(model.countryCode, "Bar")
        
    }
    

}
