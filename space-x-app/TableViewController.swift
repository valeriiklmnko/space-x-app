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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SpaceShipCell", for: indexPath) as? SpaceShipTableViewCell {
            cell.configSpaceShipCell(spaceShip: spaceShips[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
