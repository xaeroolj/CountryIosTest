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
    init(view: MainViewProtocol, dataService: CountryServiceForMainViewProtocol)
    
    func getCountry(for name: String)
    
    var countryArray: [CountryCellProtocol]? { get set }
}

class MainPresenter: MainViewPresenterProtocol {

    weak var view: MainViewProtocol?
    let dataService: CountryServiceForMainViewProtocol!
    
    var countryArray: [CountryCellProtocol]?

    required init(view: MainViewProtocol, dataService: CountryServiceForMainViewProtocol) {
        self.view = view
        self.dataService = dataService
        
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
    
    
}
