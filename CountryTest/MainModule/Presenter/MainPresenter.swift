//
//  MainPresenter.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import Foundation

protocol MainViewProtocol: class {
    func setSource(source: Country)
}

protocol MainViewPresenterProtocol: class  {
    init(view: MainViewProtocol, model: Country)
    
    func loadSource()
}

class MainPresenter: MainViewPresenterProtocol {
    
    let view: MainViewProtocol
    let model: Country
    
    required init(view: MainViewProtocol, model: Country) {
        self.view = view
        self.model = model
        
    }
    
    func loadSource() {
        //set someshing
        self.view.setSource(source: self.model)
    }
    
    
}
