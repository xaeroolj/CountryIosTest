//
//  ModuleBuilder.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import UIKit

protocol BuilderProtocol {
    static func createMain() -> UIViewController
}


class ModuleBuilder: BuilderProtocol {
    static func createMain() -> UIViewController {
        let view = MainViewController()
        let dataService = CountryServise()
        let presenter = MainPresenter(view: view, dataService: dataService)
        view.presenter = presenter
        
        presenter.getCountry(for: "ru"); #warning("only for test")
        return view
    }
    
}
