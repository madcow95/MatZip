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
    
    lazy var naverMapView = NMFNaverMapView(frame: view.frame)
    
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
    }
    
    func configureUI() {
        configureMap()
    }
    
    func configureMap() {
        naverMapView.mapView.setLayerGroup(NMF_LAYER_GROUP_BUILDING, isEnabled: true)
        naverMapView.mapView.isIndoorMapEnabled = true
        naverMapView.mapView.positionMode = .compass
        naverMapView.showLocationButton = true
        view.addSubview(naverMapView)
    }
    
    func setLocationInfo() {
        mapViewModel.movedCurrentLocation.sink { [weak self] location in
            guard let self = self, let location = location else { return }
            
            let cameraInfo = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
            naverMapView.mapView.moveCamera(cameraInfo)
            
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            marker.mapView = self.naverMapView.mapView
        }
        .store(in: &cancellables)
    }
}
