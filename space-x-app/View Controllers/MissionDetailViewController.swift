//
//  MissionDetailView.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 25/02/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

class MissionDetailViewController: UIViewController {
    
    @IBOutlet weak var launchMission: UILabel!
    @IBOutlet weak var missionName: UILabel!
    @IBOutlet weak var launchYear: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var rocketNameTitle: UILabel!
    @IBOutlet weak var rocketName: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var launchSite: UILabel!
    @IBOutlet weak var site: UILabel!
    
    var selectedSpaceShip: SpaceShip?
    let dateFormatter = DateFormatter.iso8601Custom
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configDetailView()
    }
    
    func configDetailView() {
        self.title = self.selectedSpaceShip?.missionName
        self.launchMission.text = "Mission:"
        self.missionName.text = self.selectedSpaceShip?.missionName
        self.launchYear.text = "Year:"
        self.year.text = self.selectedSpaceShip?.launchYear
        self.rocketNameTitle.text = "Rocket Name:"
        self.rocketName.text = self.selectedSpaceShip?.rocket.rocketName
        self.launchDate.text = "Launch Date:"
        self.date.text = self.dateFormatter.string(
            from: self.selectedSpaceShip?.launchDate ?? Date.distantPast
        )
        self.launchSite.text = "Lauch Site:"
        self.site.text = self.selectedSpaceShip?.launchSite.siteName
    }
}
