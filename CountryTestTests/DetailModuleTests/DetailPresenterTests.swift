//
//  DetailPresenterTests.swift
//  CountryTestTests
//
//  Created by Roman Trekhlebov on 26.11.2020.
//

import XCTest
@testable import CountryTest

class MockDetailView: DetailViewProtocol {

    let showMainBtnExpectation = XCTestExpectation(description: "showMainBtn called")
    let updateViewExpectation = XCTestExpectation(description: "updateView called")
    let showErrorExpectation = XCTestExpectation(description: "showError called")

    func showMainBtn() {
        showMainBtnExpectation.fulfill()
    }

    func updateView() {
        updateViewExpectation.fulfill()
    }

    func showError(_ error: NetworkError) {
        showErrorExpectation.fulfill()
    }
}

class MockDetailDataService: CountryServiceForDetailViewProtocol {

    var country: Country!

    init() { }
    convenience init(country: Country?) {
        self.init()
        self.country = country
    }

    func getCountryFor(code: String, completion: @escaping (Result<Country, NetworkError>) -> Void) {
        if let country = country {
            completion(.success(country))
        } else {
            completion(.failure(.domainError))
        }
    }
}

class DetailPresenterTests: XCTestCase {

    var view: MockDetailView!
    var presenter: DetailPresenter!
    var dataService: CountryServiceForDetailViewProtocol!
    var router: RouterProtocol!

    let expectedCountry = Country(countryName: "foo",
                                  countryCode: "baz",
                                  countryFlag: "bar",
                                  countryNativeName: "фоо",
                                  countryLanguages: [],
                                  countryCurrencies: [],
                                  countryBorders: [])

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

    func testGetCountryByCodeSuccess() throws {

        view = MockDetailView()
        dataService = MockDetailDataService(country: expectedCountry)
        presenter = DetailPresenter(view: view, dataService: dataService, router: router, countryCode: "baz")

        var catchCountry: Country?

        presenter.getCountryFor(code: expectedCountry.countryCode)

        dataService.getCountryFor(code: expectedCountry.countryCode) { result in
            switch result {
            case .success(let country ):
                catchCountry = country
            case .failure(let error):
                print(error)
            }
        }

        XCTAssertEqual(expectedCountry.countryFlag, catchCountry?.countryFlag)

    }

    func testGetCountryByCodeFailure() throws {

        view = MockDetailView()
        dataService = MockDetailDataService()
        presenter = DetailPresenter(view: view, dataService: dataService, router: router, countryCode: "baz")

        var catchError: NetworkError?

        dataService.getCountryFor(code: expectedCountry.countryCode) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                catchError = error
            }
        }

        XCTAssertNotNil(catchError)

    }

    func testGetCountrySuccess() throws {

        view = MockDetailView()
        dataService = MockDetailDataService(country: expectedCountry)
        presenter = DetailPresenter(view: view, dataService: dataService, router: router, country: expectedCountry)

        presenter.getCountry()

        XCTAssertEqual(expectedCountry.countryFlag, presenter.country?.countryFlag)

    }

    func testPopToRoot() {

        view = MockDetailView()
        dataService = MockDetailDataService(country: expectedCountry)
        router.initialViewController()
        presenter = DetailPresenter(view: view, dataService: dataService, router: router, country: expectedCountry)
        presenter.backToRoot()
        let visibleVC = router.navigationController?.visibleViewController
        XCTAssertNotNil(visibleVC)
        XCTAssertTrue(visibleVC is MainViewController)
    }
    // here
    func testPeresenterInitWithCountry() throws {

        let country = Country(countryName: "foo",
                              countryCode: "baz",
                              countryFlag: "bar",
                              countryNativeName: "фоо",
                              countryLanguages: [],
                              countryCurrencies: [],
                              countryBorders: [])

        view = MockDetailView()
        dataService = MockDetailDataService(country: country)
        presenter = DetailPresenter(view: view, dataService: dataService, router: router, country: country)

        presenter.getCountry()
        //positive
        wait(for: [view.updateViewExpectation], timeout: 1.0)
    }

    func testPeresenterInitWithCountryNegative() throws {

        view = MockDetailView()
        dataService = MockDetailDataService(country: nil)
        presenter = DetailPresenter(view: view, dataService: dataService, router: router, country: nil)
        presenter.getCountry()
        //negative
        view.updateViewExpectation.isInverted = true
        wait(for: [view.updateViewExpectation], timeout: 1.0)
    }

    func testPeresentergetCountryForCode() throws {

        let country = Country(countryName: "foo",
                              countryCode: "baz",
                              countryFlag: "bar",
                              countryNativeName: "фоо",
                              countryLanguages: [],
                              countryCurrencies: [],
                              countryBorders: [])

        view = MockDetailView()
        dataService = MockDetailDataService(country: country)
        presenter = DetailPresenter(view: view, dataService: dataService, router: router, countryCode: "baz")
        //positive
        presenter.getCountryFor(code: "baz")
        wait(for: [
                view.showMainBtnExpectation,
                view.updateViewExpectation], timeout: 2.0)
    }

    func testPeresentergetCountryForCodeErrorCalled() throws {

        view = MockDetailView()
        dataService = MockDetailDataService(country: nil)
        presenter = DetailPresenter(view: view, dataService: dataService, router: router, countryCode: "baz")
        //negative
        presenter.getCountryFor(code: "baz")
        wait(for: [view.showErrorExpectation], timeout: 2.0)
    }

}
