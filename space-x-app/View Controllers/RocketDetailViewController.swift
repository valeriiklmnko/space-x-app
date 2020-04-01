//
//  RocketDetailViewController.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 26/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

class RocketDetailViewController: UIViewController {
    
    @IBOutlet weak var rocketName: UILabel!
    
    var selectedRocket: Rocket?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureRocketDetailView()
    }
    
    func configureRocketDetailView() {
        self.title = selectedRocket?.rocketName
        self.rocketName.text = selectedRocket?.rocketName
    }
}
