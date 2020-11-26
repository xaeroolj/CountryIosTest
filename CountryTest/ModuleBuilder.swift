//
//  ModuleBuilder.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import UIKit

protocol BuilderProtocol {
    static func createMainModule() -> UIViewController
    static func createDetailModule(countryCode: String) -> UIViewController
}


class ModuleBuilder: BuilderProtocol {
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let dataService = CountryServise()
        let presenter = MainPresenter(view: view, dataService: dataService)
        view.presenter = presenter
        
        presenter.getCountry(for: "ru"); #warning("only for test")
        
        return view
    }
    
    static func createDetailModule(countryCode: String) -> UIViewController {
        let view = DetailViewController()
        let dataService = CountryServise()
        let presenter = DetailPresenter(view: view,
                                        dataService: dataService,
                                        countryCode: countryCode)
        view.presenter = presenter
        
        presenter.getCountry(for: countryCode); #warning("only for test")
        
        return view
        
    }
    
}
