//
//  LocationManager.swift
//  MatZip
//
//  Created by MadCow on 2024/11/27.
//

import CoreLocation
import Combine

protocol LocationManager {
    var locationAuthStatus: CLAuthorizationStatus { get }
    var currentLocation: AnyPublisher<CLLocation?, Never> { get }
    func requestLocationAuth()
}
