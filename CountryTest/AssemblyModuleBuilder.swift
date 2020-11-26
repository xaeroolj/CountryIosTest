//
//  AssemblyModuleBuilder.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(countryCode: String, router: RouterProtocol) -> UIViewController
}


class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let dataService = CountryServise()
        let presenter = MainPresenter(view: view, dataService: dataService, router: router)
        view.presenter = presenter
        
        presenter.getCountry(for: "ru"); #warning("only for test")
        
        return view
    }
    
    func createDetailModule(countryCode: String, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let dataService = CountryServise()
        let presenter = DetailPresenter(view: view,
                                        dataService: dataService,
                                        router: router,
                                        countryCode: countryCode)
        view.presenter = presenter
        
        presenter.getCountry(for: countryCode); #warning("only for test")
        
        return view
    }
    
}
