//
//  Constants.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import Foundation


struct K {
    struct UrlStrings {
        static let appBaseUrl = "https://restcountries.eu/rest/v2/"
        static let countryByNameUrl = appBaseUrl + "name/"
        static let countryByCodeUrl = appBaseUrl + "alpha/"
    }
    
    struct CellIdentifiers {
        static let mainModuleCell = "MainCell"
    }
    
    struct ConstantStrings {
        static let begin = "Use search textField"
        static let loading = "Loading..."
    }
}
