//
//  RocketDetailViewController.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 26/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

class RocketDetailViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var rocketName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Rocket Name"
        self.rocketName.text = "Name"
    }
}
