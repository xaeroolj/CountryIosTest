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
    func initState()
    func viewLoading()
}

protocol MainViewPresenterProtocol: AnyObject  {
    init(view: MainViewProtocol, dataService: CountryServiceForMainViewProtocol, router: RouterProtocol)
    
    func getCountry(for name: String)
    func tapOnCountry(country: CountryDetailViewProtocol)
    
    var countryArray: [CountryMainViewProtocol]? { get set }
}

class MainPresenter: NSObject, MainViewPresenterProtocol  {
    
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
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        if name.isEmpty {
            self.countryArray?.removeAll()
            self.view?.initState()
            return
        }
        self.countryArray?.removeAll()
        self.view?.viewLoading()
        
        perform(#selector(delayedRequest(_:)), with: name, afterDelay: 0.5)

    }
    
    @objc private func delayedRequest(_ name: String) {
        dataService.getCountryBy(name: name) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                do {
                    self.countryArray = try result.get()
                    self.view?.updateView()
                } catch {
                    self.countryArray?.removeAll()
                    self.view?.showError(error as! NetworkError)
                    
                }
            }
        }
    }
    
    func tapOnCountry(country: CountryDetailViewProtocol) {
        router?.showDetail(country: country)
    }
    
    
}
