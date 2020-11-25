//
//  MainViewController.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak private var searchTextField: UITextField!
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: - Public Properties
    var presenter: MainViewPresenterProtocol!
    
    // MARK: - Private Properties
    private var source: Country?
    
    // MARK: - Initializers
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Public Methods
    // MARK: - Private Methods
    // MARK: - IBActions
    
}

extension MainViewController: MainViewProtocol {
    func setSource(source: Country) {
        self.source = source
        
    }
    
    
}
