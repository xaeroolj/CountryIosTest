//
//  Resource.swift
//  CountryTest
//
//  Created by Roman Trekhlebov on 25.11.2020.
//

import Foundation

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
}

extension Resource {
    init(url: URL) {
        self.url = url
    }
}
