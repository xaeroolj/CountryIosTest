//
//  DetailPresenter.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 26.11.2020.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func updateView()
    func showError(_ error: NetworkError)
}

protocol DetailViewPresenterProtocol: AnyObject  {
    init(view: DetailViewProtocol, dataService: CountryServiceForDetailViewProtocol,
         router: RouterProtocol,
         countryCode: String)
    
    var country: CountryDetailViewProtocol? { get set }
    
    func getCountry(for code: String)
    func backToRoot()
}


class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    let dataService: CountryServiceForDetailViewProtocol!
    var countryCode: String?
    
    var country: CountryDetailViewProtocol?

    required init(view: DetailViewProtocol, dataService: CountryServiceForDetailViewProtocol,
                  router: RouterProtocol,
                  countryCode: String) {
        self.view = view
        self.dataService = dataService
        self.router = router
        self.countryCode = countryCode
    }
    
    func getCountry(for code: String) {
        dataService.getCountryFor(code: code) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                do {
                    self.country = try result.get()
                    self.view?.updateView()
                } catch { self.view?.showError(error as! NetworkError) }
            }
        }
    }
    
    func backToRoot() {
        router?.popToRoot()
    }
}
