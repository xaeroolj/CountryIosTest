//
//  Country.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import Foundation

typealias CountryViewProtocol = CountryMainViewProtocol & CountryDetailViewProtocol

protocol CountryMainViewProtocol {
    var countryName: String {get}
    var countryCode: String {get}
}

protocol CountryDetailViewProtocol: CountryMainViewProtocol {
    var countryFlag: String {get}
    var countryNativeName: String {get}
    var countryLanguages: [Language] {get}
    var countryCurrencies: [Currency] {get}
    var countryBorders: [String] {get}
}

struct Country: Codable, CountryViewProtocol {
    let countryName: String
    let countryCode: String

    let countryFlag: String
    let countryNativeName: String
    let countryLanguages: [Language]
    let countryCurrencies: [Currency]
    let countryBorders: [String]

    private enum CodingKeys: String, CodingKey {
        case countryName = "name",
             countryCode = "alpha3Code",
             countryFlag = "flag",
             countryNativeName = "nativeName",
             countryLanguages = "languages",
             countryCurrencies = "currencies",
             countryBorders = "borders"
    }
}

struct Currency: Codable {
    let code: String?
    let name: String?
    let symbol: String?
}

struct Language: Codable {
    let name: String?
    let nativeName: String?
}
