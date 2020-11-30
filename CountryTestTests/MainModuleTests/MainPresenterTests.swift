//
//  MainPresenterTests.swift
//  CountryTestTests
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import XCTest
@testable import CountryTest

class MockMainView: MainViewProtocol {
    
    let viewLoadingExpectation = XCTestExpectation(description: "viewLoading called")
    let initStateExpectation = XCTestExpectation(description: "viewInit called")
    let viewUpdateExpectation = XCTestExpectation(description: "viewUpdate called")
    let viewShowErrorExpectation = XCTestExpectation(description: "viewError called")
    
    func initState() {
        initStateExpectation.fulfill()
    }
    
    func viewLoading() {
        viewLoadingExpectation.fulfill()
    }
    
    
    func updateView() {
        viewUpdateExpectation.fulfill()
    }
    
    func showError(_ error: NetworkError) {
        viewShowErrorExpectation.fulfill()
    }
    
}

class MockMainDataService: CountryServiceForMainViewProtocol {
    
    var countryes: [Country]!
    
    init() { }
    convenience init(countryes: [Country]?) {
        self.init()
        self.countryes = countryes
    }
    
    func getCountryBy(name: String, completion: @escaping (Result<[Country], NetworkError>) -> Void) {
        if let countryes = countryes {
            completion(.success(countryes ))
            
        } else {
            completion(.failure(.domainError))
        }
    }
    
}

class MainPresenterTests: XCTestCase {

    var view: MockMainView!
    var presenter: MainPresenter!
    var dataService: CountryServiceForMainViewProtocol!
    var router: RouterProtocol!
//    var countryes = [Country]()
    
    override func setUpWithError() throws {
        let navC = UINavigationController()
        let assamblyB = AssemblyModuleBuilder()
        router = Router(navigationController: navC, assemblyBuilder: assamblyB)
    }
    
    override func tearDownWithError() throws {
        view = nil
        dataService = nil
        presenter = nil
        router = nil
    }
    
    func testGetCountryBySuccess() throws {
        let country = Country(countryName: "foo",
                              countryCode: "baz",
                              countryFlag: "bar",
                              countryNativeName: "фоо",
                              countryLanguages: [],
                              countryCurrencies: [],
                              countryBorders: [])
        
        view = MockMainView()
        dataService = MockMainDataService(countryes: [country])
        presenter = MainPresenter(view: view, dataService: dataService, router: router)
        var catchCountryes: [Country]?
        
        dataService.getCountryBy(name: "foo") { result in
            switch result {
            case .success(let countryes ):
                catchCountryes = countryes
            case .failure(let error):
                print(error)
            }
        }
        XCTAssertNotEqual(catchCountryes?.count, 0)
        XCTAssertEqual(catchCountryes?.first?.countryCode, "baz")
        
    }
    
    func testGetCountryByFalure() throws {
//        let country = Country(countryName: "foo",
//                              countryCode: "baz",
//                              countryFlag: "bar",
//                              countryNativeName: "фоо",
//                              countryLanguages: [],
//                              countryCurrencies: [],
//                              countryBorders: [])
        
        view = MockMainView()
        dataService = MockMainDataService()
        presenter = MainPresenter(view: view, dataService: dataService, router: router)
        
        var catchError: NetworkError?
        
        dataService.getCountryBy(name: "foo") { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                catchError = error
            }
        }
        
        XCTAssertNotNil(catchError)
        
    }
    
    func testPeresenterGetCountry() throws {
        
        let country = Country(countryName: "foo",
                              countryCode: "baz",
                              countryFlag: "bar",
                              countryNativeName: "фоо",
                              countryLanguages: [],
                              countryCurrencies: [],
                              countryBorders: [])
        
        view = MockMainView()
        dataService = MockMainDataService(countryes: [country])
        presenter = MainPresenter(view: view, dataService: dataService, router: router)
        
        
        //positive
        presenter.getCountry(for: "foo")
        wait(for: [
            view.viewUpdateExpectation,
            view.viewLoadingExpectation], timeout: 2.0)
    }
    
    func testPeresenterGetCountryNegative() throws {
        
        view = MockMainView()
        dataService = MockMainDataService()
        presenter = MainPresenter(view: view, dataService: dataService, router: router)
        //negative
        presenter.getCountry(for: "")
        view.viewUpdateExpectation.isInverted = true
        wait(for: [view.viewUpdateExpectation], timeout: 2.0)
    }
    
    func testPeresenterGetCountryErrorCalled() throws {
        
        view = MockMainView()
        dataService = MockMainDataService()
        presenter = MainPresenter(view: view, dataService: dataService, router: router)
        
        presenter.getCountry(for: "bar")
        wait(for: [view.viewShowErrorExpectation], timeout: 2.0)
    }


}
