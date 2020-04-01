//
//  AlertVC.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 31/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    func showAlert(message: String?) {
        let alertMessage = message ?? "Default"
        let alert = UIAlertController(
            title: "Error",
            message: alertMessage,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "Close",
            style: .cancel,
            handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }
        ))
        self.present(
            alert,
            animated: true,
            completion: nil
        )
    }
    
    // MARK: Spinner Methods
    func showLoadingHUD(view: UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "Loading..."
    }

    func hideLoadingHUD(view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
