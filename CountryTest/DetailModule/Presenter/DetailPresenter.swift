//
//  DetailPresenter.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 26.11.2020.
//

import Foundation

protocol DetailViewPresenterProtocol: AnyObject  {
    init(view: DetailViewProtocol, dataService: CountryServiceForDetailViewProtocol,
         router: RouterProtocol,
         country: CountryDetailViewProtocol?)
    
    init(view: DetailViewProtocol, dataService: CountryServiceForDetailViewProtocol,
                     router: RouterProtocol,
                     countryCode: String?)
    
    var country: CountryDetailViewProtocol? { get set }
    var requestedCountryCode: String? { get}
    
    func getCountry()
    func getCountryFor(code: String)
    
    func backToRoot()
    func showNewCountryWith(code: String)
}


final class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    let dataService: CountryServiceForDetailViewProtocol!
    var requestedCountryCode: String?
    
    var country: CountryDetailViewProtocol?

    required init(view: DetailViewProtocol, dataService: CountryServiceForDetailViewProtocol,
                  router: RouterProtocol,
                  country: CountryDetailViewProtocol?) {
        self.view = view
        self.dataService = dataService
        self.router = router
        self.country = country
    }
    
    required convenience init(view: DetailViewProtocol, dataService: CountryServiceForDetailViewProtocol,
                     router: RouterProtocol,
                     countryCode: String?) {
        self.init(view: view,
                  dataService: dataService,
                  router: router, country: nil)
        self.requestedCountryCode = countryCode
    }
    
    func getCountry() {
        if self.country != nil {
            self.view?.updateView()
        }
    }
    
    func getCountryFor(code: String) {
        dataService.getCountryFor(code: code) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                do {
                    self.country = try result.get()
                    self.view?.showMainBtn()
                    self.view?.updateView()
                } catch { self.view?.showError(error as! NetworkError) }
            }
        }
    }
    
    func showNewCountryWith(code: String) {
        router?.showNewCountryDetail(code: code)
    }
    
    func backToRoot() {
        router?.popToRoot()
    }
}
