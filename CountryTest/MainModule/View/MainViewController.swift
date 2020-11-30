//
//  MainViewController.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func updateView()
    func showError(_ error: NetworkError)
    func initState()
    func viewLoading()
}

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
        setupUI()
        
        updateBackground(with: K.ConstantStrings.begin)
    }
    
    // MARK: - Public Methods
    // MARK: - Private Methods
    private func setupUI() {
        title = K.ConstantStrings.main
        searchTextField.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: K.CellIdentifiers.mainModuleCell)
        self.hideKeyboardWhenTappedAround()
    }
    
    private func updateBackground(with message: String?) {
        
        guard let message = message else {
            tableView.backgroundView  = nil
            tableView.separatorStyle  = .singleLine
            return
        }
        
        let backgroundLbl: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        backgroundLbl.text          = message
        backgroundLbl.textColor     = UIColor.black
        backgroundLbl.textAlignment = .center
        backgroundLbl.numberOfLines = 0
        tableView.backgroundView  = backgroundLbl
        tableView.separatorStyle  = .none
    }
    // MARK: - IBActions
    
}

extension MainViewController: MainViewProtocol {
    
    func updateView() {
        updateBackground(with: nil)
        tableView.reloadData()
    }
    
    func showError(_ error: NetworkError) {
        
        updateBackground(with: error.localizedDescription)
        tableView.reloadData()
        
    }
    
    func initState() {
        tableView.reloadData()
        updateBackground(with: K.ConstantStrings.begin)
    }
    
    func viewLoading() {
        tableView.reloadData()
        updateBackground(with: K.ConstantStrings.loading)
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
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.tapOnCountry(country: country as! CountryDetailViewProtocol)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        let newString = string
        let oldString = searchTextField.text ?? ""
        var finalString = ""
        
        if string.count > 0 {
            finalString = oldString + newString
        }else if oldString.count > 0 {
            finalString = String(oldString.dropLast())
        }
        
        print("SEARCH FOR:\(finalString)")// pass the search String in this method
        
        presenter.getCountry(for: finalString)
        return true
    }
}
