//
//  Country.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import Foundation

protocol CountryCellProtocol {
    var countryName: String {get}
    var countryCode: String {get}
}

struct Country: Codable, CountryCellProtocol {
    let countryName: String
    let countryCode: String
    
    private enum CodingKeys : String, CodingKey {
        case countryName = "name", countryCode = "alpha3Code"
    }
}
