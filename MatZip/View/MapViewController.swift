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
    
    lazy var mapView = NMFMapView(frame: view.frame)
    
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
