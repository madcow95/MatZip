//
//  MapView.swift
//  MatZip
//
//  Created by MadCow on 2024/11/27.
//

import UIKit
import SnapKit
import NMapsMap

class MapViewController: UIViewController {
    
    private let mapViewModel = MapViewModel(locationService: LocationService())
    
    lazy var mapView = NMFMapView(frame: view.frame)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapViewModel.requestLocationAuth { [weak self] result in
            guard let self = self else { return }
            if !result {
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
        view.addSubview(mapView)
    }
}
