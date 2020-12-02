//
//  Constants.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import Foundation

struct Constants {
    struct UrlStrings {
        static let appBaseUrl = "https://restcountries.eu/rest/v2/"
        static let countryByNameUrl = appBaseUrl + "name/"
        static let countryByCodeUrl = appBaseUrl + "alpha/"
    }

    struct CellIdentifiers {
        static let mainModuleCell = "MainCell"
    }

    struct ConstantStrings {
        static let main = NSLocalizedString("Main", comment: "")
        static let backToMain = NSLocalizedString("BackToMain", comment: "")
        static let begin = NSLocalizedString("PleaseUseSearchTextField", comment: "")
        static let loading = NSLocalizedString("Loading...", comment: "")

        static let langLbl = NSLocalizedString("langLbl", comment: "")
        static let langPlaceholder = NSLocalizedString("langPlaceholder", comment: "")
        static let curencyLbl = NSLocalizedString("curencyLbl", comment: "")
        static let currPlaceholder = NSLocalizedString("currPlaceholder", comment: "")
        static let bordersLbl = NSLocalizedString("bordersLbl", comment: "")
        static let borderPlaceholder = NSLocalizedString("borderPlaceholder", comment: "")

        static let errorTitle = NSLocalizedString("Error", comment: "")
        static let returnAction = NSLocalizedString("Return", comment: "")
        static let againAction = NSLocalizedString("Again", comment: "")

    }
}
