//
//  MapView.swift
//  MatZip
//
//  Created by MadCow on 2024/11/27.
//

import UIKit
import SnapKit
import NMapsMap
import Combine

class MapViewController: UIViewController {
    
    private let mapViewModel = MapViewModel(locationService: LocationService())
    private var cancellables = Set<AnyCancellable>()
    
    lazy var mapView = NMFMapView(frame: view.frame)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapViewModel.requestLocationAuth { [weak self] result in
            guard let self = self else { return }
            if result {
                self.setLocationInfo()
                self.mapViewModel.updateLocation()
            } else {
                self.showAlert(title: "위치 권한 필요", msg: "사용자의 위치 확인을 위해 위치 권한이 필요합니다.")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
//        setCombineData()
    }
    
    func configureUI() {
        configureMap()
    }
    
    func configureMap() {
        view.addSubview(mapView)
    }
    
    func setLocationInfo() {
        mapViewModel.currentLocation.sink { [weak self] location in
            guard let self = self, let location = location else { return }
            
            let cameraInfo = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
            self.mapView.moveCamera(cameraInfo)
            
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            marker.mapView = self.mapView
        }
        .store(in: &cancellables)
    }
}
