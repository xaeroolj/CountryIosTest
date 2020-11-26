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
    
    // MARK: - Initializers
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: K.CellIdentifiers.mainModuleCell)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        presenter.getCountry(for: "ru")

    }
    
    // MARK: - Public Methods
    // MARK: - Private Methods
    // MARK: - IBActions
    
}

extension MainViewController: MainViewProtocol {
    func updateView() {
        tableView.reloadData()
    }
    
    func showError(_ error: NetworkError) {
        // TODO: Create allert view
        #warning("TODO: Create allert view")
        print(error)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countryArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier: K.CellIdentifiers.mainModuleCell)
        let country = presenter.countryArray?[indexPath.row ]

        cell.textLabel?.text = country?.countryName
        
        cell.detailTextLabel?.text = country?.countryCode
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = presenter.countryArray?[indexPath.row]
        presenter.tapOnCountry(country: country as! CountryDetailViewProtocol)
    }
}
