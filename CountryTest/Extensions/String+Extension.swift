//
//  String+Extension.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 27.11.2020.
//

import UIKit

extension String {
    func removeWhiteSpaces() -> String {
        return self.filter { !$0.isWhitespace }
    }
}
