//
//  UIViewController+Extension.swift
//  MatZip
//
//  Created by MadCow on 2024/11/28.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        // MARK: TODO - UIAlertAction을 parameter로 전달하도록 수정
        let alertAction = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let settingURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingURL)
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
