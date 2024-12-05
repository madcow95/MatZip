//
//  Place.swift
//  MatZip
//
//  Created by MadCow on 2024/12/2.
//

import Foundation

struct Place: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [PlaceInfo]
//    let places: [PlaceInfo]
//    let total: Int
//    let start: Int
//    let display: Int
}

struct PlaceInfo: Codable {
    let title: String
    let link: String
    let category, description, telephone, address: String
    let roadAddress, mapx, mapy: String
}
