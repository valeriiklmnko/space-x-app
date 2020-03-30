//
//  ModalViewController.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 26/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
