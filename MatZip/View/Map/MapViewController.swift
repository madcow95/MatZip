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
    private lazy var naverMapView = NMFNaverMapView(frame: view.frame)
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "검색어를 입력해주세요."
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.backgroundColor = .white
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.isEnabled = true
        textField.isUserInteractionEnabled = true
        
        return textField
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapViewModel.requestLocationAuth { [weak self] result in
            guard let self = self else { return }
            if result {
                self.setLocationInfo()
                self.mapViewModel.updateLocation()
            } else {
                self.showAlert(title: "위치 권한 필요", msg: "사용자의 위치 확인을 위해 위치 권한이 필요합니다.\n설정화면에서 위치 권한을 허용해주세요.")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        configureMap()
        configureTextField()
    }
    
    func configureMap() {
        naverMapView.mapView.setLayerGroup(NMF_LAYER_GROUP_BUILDING, isEnabled: true)
        naverMapView.mapView.isIndoorMapEnabled = true
        naverMapView.mapView.positionMode = .compass
        naverMapView.showLocationButton = true
        view.addSubview(naverMapView)
    }
    
    func configureTextField() {
        naverMapView.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(60)
            $0.left.equalTo(view.snp.left).offset(10)
            $0.right.equalTo(view.snp.right).offset(-10)
        }
    }
    
    func setLocationInfo() {
        mapViewModel.movedCurrentLocation.sink { [weak self] location in
            guard let self = self, let location = location else { return }
            
            let cameraInfo = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
            cameraInfo.animation = .easeIn
            naverMapView.mapView.moveCamera(cameraInfo)
            
//            let marker = NMFMarker()
//            marker.position = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
//            marker.mapView = self.naverMapView.mapView
        }
        .store(in: &cancellables)
    }
}
