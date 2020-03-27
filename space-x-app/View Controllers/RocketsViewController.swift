//
//  RocketsViewController.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 26/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

class RocketsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showModal(_ sender: Any) {
        let modalStoryboard = UIStoryboard(name: "Modal", bundle: nil)
        if let modalVC = modalStoryboard.instantiateViewController(identifier: "Modal") as? ModalViewController {
            let navController = UINavigationController(rootViewController: modalVC)
            self.navigationController?.present(navController, animated: true, completion: nil)
        }
    }
}
