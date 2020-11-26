//
//  DetailViewController.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 26.11.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var tempLblArray: [UILabel]!
    
    // MARK: - Public Properties
    
    var presenter: DetailViewPresenterProtocol!

    // MARK: - Private Properties
    // MARK: - Initializers
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let code = presenter.requestedCountryCode {
            presenter.getCountryFor(code: code)
        } else {
            presenter.getCountry()
        }
    }
    
    // MARK: - Public Methods
    // MARK: - Private Methods
    // MARK: - IBActions
    
}
extension DetailViewController: DetailViewProtocol {
    func updateView() {
        
        let country = presenter.country
        tempLblArray[0].text = country?.countryFlag
        tempLblArray[1].text = country?.countryNativeName
        tempLblArray[2].text = country?.countryLanguages.description
        tempLblArray[3].text = country?.countryCurrencies.description
        tempLblArray[4].text = country?.countryBorders.description 
    }
    
    func showError(_ error: NetworkError) {
        // TODO: Create allert view
        #warning("TODO: Create allert view")
        print(error)
    }
    
     
}
