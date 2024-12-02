//
//  Place.swift
//  MatZip
//
//  Created by MadCow on 2024/12/2.
//

import Foundation

struct Place: Codable {
    let places: [PlaceInfo]
    let total: Int
    let start: Int
    let display: Int
}

struct PlaceInfo: Codable {
    let title: String
    let link: String
    let category: String
    let description: String
    let telephone: String
    let address: String
    let roadAddress: String
    let mapx: String
    let mapy: String
}
