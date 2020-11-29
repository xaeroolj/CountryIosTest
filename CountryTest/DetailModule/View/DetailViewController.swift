//
//  DetailViewController.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 26.11.2020.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func updateView()
    func showMainBtn()
    func showError(_ error: NetworkError)
}

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var countryNameLbl: UILabel!
    @IBOutlet private weak var nativeCountryNameLbl: UILabel!
    @IBOutlet private weak var countryFlag: UIImageView!
    @IBOutlet private weak var languageLbl: UILabel!
    @IBOutlet private weak var currencyLbl: UILabel!
    @IBOutlet private weak var borderslbl: UILabel!
    
    @IBOutlet private weak var langStackView: UIStackView!
    @IBOutlet private weak var currencyStackView: UIStackView!
    @IBOutlet private weak var bordersStackView: UIStackView!
    
    
    // MARK: - Public Properties
    
    var presenter: DetailViewPresenterProtocol!
    
    // MARK: - Private Properties
        
    // MARK: - Initializers
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        fade(alpha: 0.0)

        if let code = presenter.requestedCountryCode {
            presenter.getCountryFor(code: code)
        } else {
            presenter.getCountry()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    // MARK: - IBActions
    
}

extension DetailViewController: DetailViewProtocol {
    
    func updateView() {
        
        guard let country = presenter.country else { return }


        title = country.countryCode.uppercased()
        countryNameLbl.text = country.countryName
        nativeCountryNameLbl.text = country.countryNativeName
        
        self.populateLang()
        self.populateCurrency()
        self.populateBoarders()
        
        fade(alpha: 1.0)
        
    }
    
    func showError(_ error: NetworkError) {
        

        // TODO: Create allert view
        #warning("TODO: Create allert view")
        print(error)
    }
    
    func showMainBtn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Main", style: .plain, target: self, action: #selector(mainTapped))
    }
    
    @objc private func mainTapped() {
        presenter.backToRoot()
    }
}

// MARK: - PopulateUI
extension DetailViewController {
    
    private func fade(alpha: Double) {
        let cgAlpha = CGFloat(alpha)
        UIView.animate(withDuration: 1.5) {
            self.countryNameLbl.alpha = cgAlpha
            self.nativeCountryNameLbl.alpha = cgAlpha
            self.countryFlag.alpha = cgAlpha
            self.languageLbl.alpha = cgAlpha
            self.currencyLbl.alpha = cgAlpha
            self.borderslbl.alpha = cgAlpha
            
            self.langStackView.alpha = cgAlpha
            self.currencyStackView.alpha = cgAlpha
            self.bordersStackView.alpha = cgAlpha
        }
    }
    
    private func populateLang() {
        guard let country = presenter.country else { return }
        if !country.countryLanguages.isEmpty {
            langStackView.removeArrangedSubview(langStackView.arrangedSubviews[0])
            
            let countryLangStrings = country.countryLanguages.map {"\($0.name ?? "None") (\($0.nativeName ?? "None"))"}
            countryLangStrings.forEach { (item) in
                let lbl = UILabel()
                lbl.text = item
                self.langStackView.addArrangedSubview(lbl)
            }
        }
    }
    
    private func populateCurrency() {
        guard let country = presenter.country else { return }
        if !country.countryCurrencies.isEmpty {
            currencyStackView.removeArrangedSubview(currencyStackView.arrangedSubviews[0])
            
            let countryCurStrings = country.countryCurrencies.map {"\($0.code ?? "None") (\($0.name ?? "None"))"}
            countryCurStrings.forEach { (item) in
                let lbl = UILabel()
                lbl.text = item
                self.currencyStackView.addArrangedSubview(lbl)
            }
        }
    }
    
    private func populateBoarders() {
        guard let country = presenter.country else { return }
        if !country.countryBorders.isEmpty {
            bordersStackView.removeArrangedSubview(bordersStackView.arrangedSubviews[0])
            
            country.countryBorders.forEach({ (border) in
                addBorderBtn(border)
            })
        }
    }
    
    private func addBorderBtn(_ str: String) {
        
        let btn = UIButton()
        
        btn.setTitle(str, for: .normal)
        btn.setTitleColor(.black, for: .normal)
//        btn.layer.borderWidth = 2
//        btn.layer.borderColor = UIColor.black.cgColor
//        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(self.action(sender:)), for: .touchUpInside)
        
        bordersStackView.addArrangedSubview(btn)
    }
    
    @objc private func action(sender: UIButton!) {
        presenter.showNewCountryWith(code: sender.currentTitle!)
        
    }
}
