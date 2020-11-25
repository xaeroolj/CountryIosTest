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
        let model = Country(countryName: "MotherRussia", countryCode: "rus")
        let view = MainViewController()
        let presenter = MainPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
    
}
