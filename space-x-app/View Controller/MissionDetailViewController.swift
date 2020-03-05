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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDetailView()
    }
    
    func configDetailView() {
        launchMission.text = "Mission:"
        missionName.text = selectedSpaceShip?.missionName
        
        launchYear.text = "Year:"
        year.text = selectedSpaceShip?.launchYear
        
        rocketNameTitle.text = "Rocket Name:"
        rocketName.text = selectedSpaceShip?.rocket.rocketName
        
        launchDate.text = "Launch Date:"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"
        let formattedLaunchDate: Date? = dateFormatter.date(from: selectedSpaceShip?.launchDate ?? "Date not found")
        date.text = dateFormatter.string(from: formattedLaunchDate ?? Date())
//        date.text = selectedSpaceShip?.launchDate
        
        launchSite.text = "Lauch Site:"
        site.text = selectedSpaceShip?.launchSite.siteName
    }
}

