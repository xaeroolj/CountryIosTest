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
        tableView.dataSource = self
//        tableView.delegate = self
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: K.CellIdentifiers.mainModuleCell)
        
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

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier: K.CellIdentifiers.mainModuleCell)

        cell.textLabel?.text = "test"
        
        cell.detailTextLabel?.text = "detail"
        return cell
    }
    
    
}
