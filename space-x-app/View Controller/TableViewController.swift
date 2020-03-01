//
//  ViewController.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 24/02/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {
    var ships: [SpaceShip] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchShips()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ships.count
//        return ships.count - 103
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SpaceShipCell", for: indexPath) as? SpaceShipTableViewCell {
            cell.configSpaceShipCell(spaceShip: ships[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = mainStoryboard.instantiateViewController(identifier: "MissionDetailViewController") as? MissionDetailViewController {
            detailViewController.selectedSpaceShip = ships[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TableViewController {
    func fetchShips() {
        AF.request("https://api.spacexdata.com/v3/launches")
            .validate()
            .responseDecodable(of: [SpaceShip].self) { (response) in
                guard let repuestedShips = response.value else { return }
                self.ships = repuestedShips
//                print(self.ships)
                self.tableView.reloadData()
                
        }
        
    }
}
