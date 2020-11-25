//
//  UrlConstructor.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 26.11.2020.
//

import Foundation
//MARK: - URLConstructor
final class UrlConstructor {

    static func getCountryByNameUrl(name: String) -> URL? {
        return URL(string: K.UrlStrings.countryByNameUrl.appending("\(name)"))
    }
    
    static func getCountryByCodeUrl(code: String) -> URL? {
        return URL(string: K.UrlStrings.countryByCodeUrl.appending("\(code)"))
    }
}
