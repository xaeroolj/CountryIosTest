//
//  DetailViewController.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 26.11.2020.
//

import UIKit
import SDWebImageSVGKitPlugin

protocol DetailViewProtocol: AnyObject {
    func updateView()
    func showMainBtn()
    func showError(_ error: NetworkError)
}

final class DetailViewController: UIViewController {

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
    private lazy var activityIndicator = UIActivityIndicatorView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        localizeUI()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        showActivityIndicator()

        if let code = presenter.requestedCountryCode {
            presenter.getCountryFor(code: code)
        } else {
            presenter.getCountry()
        }

    }
}

extension DetailViewController: DetailViewProtocol {

    func updateView() {

        guard let country = presenter.country else { return }

        if let url = URL(string: country.countryFlag) {
            countryFlag.sd_setImage(with: url)
        }

        title = country.countryCode.uppercased()
        countryNameLbl.text = country.countryName
        nativeCountryNameLbl.text = country.countryNativeName

        self.populateLang()
        self.populateCurrency()
        self.populateBoarders()

        self.activityIndicator.stopAnimating()

        fade(alpha: 1.0)
    }

    func showError(_ error: NetworkError) {

        var actionArray = [UIAlertAction]()

        let returnAlert = UIAlertAction(title: Constants.ConstantStrings.returnAction, style: .destructive) { (_) in
            self.navigationController?.popViewController(animated: true)
        }

        actionArray.append(returnAlert)

        if error == .domainError {
            let reloadAlert = UIAlertAction(title: Constants.ConstantStrings.againAction, style: .cancel) { (_) in
                let countryCode = self.presenter.requestedCountryCode!
                self.presenter.getCountryFor(code: countryCode)
            }

            actionArray.append(reloadAlert)
        }

        self.activityIndicator.stopAnimating()

        self.showAlert(title: Constants.ConstantStrings.errorTitle,
                       message: error.localizedDescription,
                       actions: actionArray)
    }

    func showMainBtn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.ConstantStrings.backToMain,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(mainTapped))
    }

    @objc private func mainTapped() {
        presenter.backToRoot()
    }
}

// MARK: - Setup UI
extension DetailViewController {

    private func showActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }

    private func fade(alpha: Double, time: Double = 1.5) {
        let cgAlpha = CGFloat(alpha)
        UIView.animate(withDuration: time) {
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

    private func localizeUI() {

        fade(alpha: 0.0, time: 0.0)

        languageLbl.text = Constants.ConstantStrings.langLbl
        if let langPlaceHolder = langStackView.arrangedSubviews[0] as? UILabel {
            langPlaceHolder.text = Constants.ConstantStrings.langPlaceholder
        }
        currencyLbl.text = Constants.ConstantStrings.curencyLbl
        if let currPlaceHolder = currencyStackView.arrangedSubviews[0] as? UILabel {
            currPlaceHolder.text = Constants.ConstantStrings.currPlaceholder
        }
        borderslbl.text = Constants.ConstantStrings.bordersLbl
        if let borderPlaceHolder = bordersStackView.arrangedSubviews[0] as? UILabel {
            borderPlaceHolder.text = Constants.ConstantStrings.borderPlaceholder
        }
    }

    private func populateLang() {
        guard let country = presenter.country else { return }
        if !country.countryLanguages.isEmpty {
            langStackView.arrangedSubviews[0].removeFromSuperview()

            let countryLangStrings = country.countryLanguages.map {"\($0.name ?? "None") (\($0.nativeName ?? "None"))"}
            countryLangStrings.forEach { (item) in
                let lbl = UILabel()
                lbl.numberOfLines = 0
                lbl.text = item
                self.langStackView.addArrangedSubview(lbl)
            }
        }
    }

    private func populateCurrency() {
        guard let country = presenter.country else { return }
        if !country.countryCurrencies.isEmpty {
            currencyStackView.arrangedSubviews[0].removeFromSuperview()

            let countryCurStrings = country.countryCurrencies.map {"\($0.code ?? "None") (\($0.name ?? "None"))"}
            countryCurStrings.forEach { (item) in
                let lbl = UILabel()
                lbl.numberOfLines = 0
                lbl.text = item
                self.currencyStackView.addArrangedSubview(lbl)
            }
        }
    }

    private func populateBoarders() {
        guard let country = presenter.country else { return }
        if !country.countryBorders.isEmpty {
            bordersStackView.arrangedSubviews[0].removeFromSuperview()

            country.countryBorders.forEach({ (border) in
                addBorderBtn(border)
            })
        }
    }

    private func addBorderBtn(_ str: String) {

        let btn = UIButton()
        btn.contentHorizontalAlignment = .left
        btn.setTitle(str, for: .normal)
        if #available(iOS 13.0, *) {
            btn.setTitleColor(.label, for: .normal)
        } else {
            btn.setTitleColor(.black, for: .normal)
        }

        btn.addTarget(self, action: #selector(self.action(sender:)), for: .touchUpInside)

        bordersStackView.addArrangedSubview(btn)
    }

    @objc private func action(sender: UIButton!) {

        presenter.showNewCountryWith(code: sender.currentTitle!)

    }
}
