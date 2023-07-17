//
//  SvatiStructure.swift
//  Svati
//
//  Created by Petr Hracek on 17.07.2023.
//

import Foundation

struct SvatiStructure: Decodable {
    var svati: [Svati]
}

struct Svati: Decodable {
    var jmeno: String
    var popis: String
    var den: Int
    var mesic: Int
    var text: String
}
