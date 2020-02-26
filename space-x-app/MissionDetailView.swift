//
//  MissionDetailView.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 25/02/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

class MissionDetailView: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDetailView(spaceShip: tv.spaceShips[3])
    }
    
    let tv = TableViewController()
    
    func configDetailView(spaceShip: SpaceShip) {
        launchMission.text = "Mission:"
        launchMission.lineBreakMode = .byClipping
        missionName.text = spaceShip.missionName
        missionName.lineBreakMode = .byClipping
        
        launchYear.text = "Year:"
        launchYear.lineBreakMode = .byClipping
        year.text = spaceShip.launchYear
        year.lineBreakMode = .byClipping
        
        rocketNameTitle.text = "Rocket Name:"
        rocketNameTitle.lineBreakMode = .byClipping
        rocketName.text = spaceShip.rocketName
        rocketName.lineBreakMode = .byClipping
        
        launchDate.text = "Launch Date:"
        launchDate.lineBreakMode = .byClipping
        date.text = spaceShip.launchDate
        date.lineBreakMode = .byClipping
        
        launchSite.text = "Lauch Site:"
        launchSite.lineBreakMode = .byClipping
        site.text = spaceShip.launchSite
        site.lineBreakMode = .byClipping
    }

}
