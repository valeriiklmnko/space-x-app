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
    @IBOutlet weak var rocketImage: UIImageView!
    @IBOutlet weak var rocketNameCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var rocketImageCenterConstraint: NSLayoutConstraint!
    
    var selectedRocket: Rocket?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showRocket()
        self.showTitle()
        self.animateRocket()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureRocketDetailView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rocketImageCenterConstraint.constant -= view.bounds.width
        self.rocketNameCenterConstraint.constant -= view.bounds.width
    }
    
    func configureRocketDetailView() {
        self.title = self.selectedRocket?.rocketName
        self.rocketName.text = self.selectedRocket?.rocketName
    }
    
    func showRocket() {
        self.rocketImageCenterConstraint.constant = 0
        UIView.animate(
             withDuration: 0.5,
             delay: 0,
             options: [.curveEaseInOut],
             animations: { [weak self] in
                 self?.view.layoutIfNeeded()
             },
             completion: nil
         )
    }
    
    func animateRocket() {
        let options: UIView.AnimationOptions = [
            .curveEaseInOut,
            .repeat,
            .autoreverse
        ]
        UIView.animate(
            withDuration: 3.0,
            delay: 0.3,
            options: options,
            animations: { [weak self] in
                self?.rocketImage.frame.size.height *= 1.18
                self?.rocketImage.frame.size.width *= 1.18
            },
            completion: nil
        )
    }
    
    func showTitle() {
        self.rocketNameCenterConstraint.constant = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0.3,
            options: [.curveEaseInOut],
            animations: { [weak self] in
                self?.view.layoutIfNeeded()
            },
            completion: nil
        )
    }
}
