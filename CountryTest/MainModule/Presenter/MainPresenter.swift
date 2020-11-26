//
//  MainPresenter.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func updateView()
    func showError(_ error: NetworkError)
}

protocol MainViewPresenterProtocol: AnyObject  {
    init(view: MainViewProtocol, dataService: CountryServiceForMainViewProtocol, router: RouterProtocol)
    
    func getCountry(for name: String)
    func tapOnCountry(country: CountryMainViewProtocol)
    
    var countryArray: [CountryMainViewProtocol]? { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    
    

    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    let dataService: CountryServiceForMainViewProtocol!
    
    var countryArray: [CountryMainViewProtocol]?

    required init(view: MainViewProtocol, dataService: CountryServiceForMainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.dataService = dataService
        self.router = router
        
    }
    
    func getCountry(for name: String) {
        dataService.getCountryBy(name: name) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                do {
                    self.countryArray = try result.get()
                    self.view?.updateView()
                } catch { self.view?.showError(error as! NetworkError) }
            }
        }
    }
    
    func tapOnCountry(country: CountryMainViewProtocol) {
        router?.showDetail(country: country)
    }
    
    
}
