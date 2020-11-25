//
//  AppDelegate.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainViewController = ModuleBuilder.createMain()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

    

}

