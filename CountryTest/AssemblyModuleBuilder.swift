//
//  AssemblyModuleBuilder.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(country: CountryDetailViewProtocol?, router: RouterProtocol) -> UIViewController
    func createNewDetailModule(code: String?, router: RouterProtocol) -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let dataService = CountryServise()
        let presenter = MainPresenter(view: view, dataService: dataService, router: router)
        view.presenter = presenter
        return view
    }
    func createDetailModule(country: CountryDetailViewProtocol?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let dataService = CountryServise()
        let presenter = DetailPresenter(view: view,
                                        dataService: dataService,
                                        router: router,
                                        country: country)
        view.presenter = presenter
        return view
    }

    func createNewDetailModule(code: String?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let dataService = CountryServise()

        let presenter = DetailPresenter(view: view,
                                        dataService: dataService,
                                        router: router,
                                        countryCode: code)
        view.presenter = presenter

        return view
    }

}
