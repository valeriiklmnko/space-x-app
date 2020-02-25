//
//  ViewController.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 24/02/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var spaceShips: [SpaceShip] = [
        SpaceShip(
            rocketName: "Falcon 1",
            launchDate: "2006-03-24T22:30:00.000Z",
            launchYear: "2006",
            missionName: "FalconSat",
            launchSite: "Kwajalein Atoll Omelek Island"
        ),
        SpaceShip(
            rocketName: "Falcon 1",
            launchDate: "2007-03-21T01:10:00.000Z",
            launchYear: "2007",
            missionName: "DemoSat",
            launchSite: "Kwajalein Atoll Omelek Island"
        ),
        SpaceShip(
            rocketName: "Falcon 1",
            launchDate: "2008-08-02T03:34:00.000Z",
            launchYear: "2008",
            missionName: "Trailblazer",
            launchSite: "Kwajalein Atoll Omelek Island"
        ),
        SpaceShip(
            rocketName: "Falcon 1",
            launchDate: "2008-09-28T23:15:00.000Z",
            launchYear: "2008",
            missionName: "RatSat",
            launchSite: "Kwajalein Atoll Omelek Island"
        )
    ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spaceShips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpaceShipCell", for: indexPath) as! SpaceShipTableViewCell
        
        cell.cellMissionLabel.text = "Mission: \(spaceShips[indexPath.row].missionName)"
        cell.cellYearLabel.text = "Year: \(spaceShips[indexPath.row].launchYear)"
        cell.cellImageView.image = UIImage(named: "rocket-logo")
        
        
//        if let label = cell.viewWithTag(1) as? UILabel {
//            switch indexPath.row {
//            case 0:
//                label.text = "Mission: \(spaceShips[0].missionName), Year: \(spaceShips[0].launchYear)"
//            case 1:
//                label.text = "Mission: \(spaceShips[1].missionName), Year: \(spaceShips[1].launchYear)"
//            case 2:
//                label.text = "Mission: \(spaceShips[2].missionName), Year: \(spaceShips[2].launchYear)"
//            case 3:
//                label.text = "Mission: \(spaceShips[3].missionName), Year: \(spaceShips[3].launchYear)"
//            default:
//                label.text = "Correct Space Ship not found"
//            }
//        }
        
        return cell
    }
}
