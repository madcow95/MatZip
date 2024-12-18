//
//  PlaceModel.swift
//  MatZip
//
//  Created by MadCow on 2024/12/18.
//

import Foundation
import CoreLocation

struct Place: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [PlaceInfo]
}

struct PlaceInfo: Codable, Hashable {
    let title: String
    let link: String
    let category, description, telephone, address: String
    let roadAddress, mapx, mapy: String
    var coordinate: CLLocationCoordinate2D {
        get {
            guard let mapX = Double(mapx),
                  let mapY = Double(mapy) else {
                return CLLocationCoordinate2D(latitude: 0, longitude: 0)
            }
            
            let latitude = mapY / 10000000.0
            let longitude = mapX / 10000000.0
            
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
}
