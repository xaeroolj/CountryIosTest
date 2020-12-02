//
//  Router.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 26.11.2020.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(country: CountryDetailViewProtocol)
    func showNewCountryDetail(code: String)
    func popToRoot()
}

final class Router: RouterProtocol {

    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?

    init(navigationController: UINavigationController,
         assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }

    func showDetail(country: CountryDetailViewProtocol) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailModule(country: country,
                                                                                 router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }

    func showNewCountryDetail(code: String) {
        if let navigationController = navigationController {
            guard let detailViewController =
                    assemblyBuilder?.createNewDetailModule(code: code, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }

}
