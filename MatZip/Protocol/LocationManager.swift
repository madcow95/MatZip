//
//  LocationManager.swift
//  MatZip
//
//  Created by MadCow on 2024/12/12.
//

import CoreLocation
import Combine

protocol LocationManager {
    var locationAuthStatus: CLAuthorizationStatus { get }
    var movingCurrentLocation: AnyPublisher<CLLocation?, Never> { get }
    func requestLocationAuth(completion: @escaping (Bool) -> Void)
}
