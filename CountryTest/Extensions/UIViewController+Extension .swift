//
//  UIViewController+Extension .swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 27.11.2020.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func showAlert(title: String, message: String, actions: [UIAlertAction]? = nil ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
            actions.forEach { (action) in
                alert.addAction(action)
            }
        } else {
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                          style: .default, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)

    }
}
