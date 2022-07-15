//
//  OverviewTableViewController.swift
//  SDK iOS I
//
//  Created by Miqueias Maia on 15/07/22.
//  Copyright © 2022 SAP. All rights reserved.
//

import UIKit
import SAPFiori
import SAPFoundation
import SAPOData
import SAPFioriFlows
import SAPCommon
import ESPMContainerFmwk

class OverviewTableViewController: UITableViewController {
    
    private var products = [Product()]
    private let logger = Logger.shared(named: "OverviewTableViewController")
    private var customers = [Customer()]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1: if products.count >= 3 {return 3}
        case 3: if products.count >= 1 {return 1}
        default:
            return 0
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UITableViewHeaderFooterView()
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UITableViewHeaderFooterView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          return UITableViewCell()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
