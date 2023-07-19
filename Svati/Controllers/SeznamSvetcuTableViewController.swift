//
//  SeznamSvetcuTableViewController.swift
//  Svati
//
//  Created by Petr Hracek on 17.07.2023.
//

import Foundation
import UIKit
import FirebaseAnalytics

class SeznamSvetcuTableViewController: UITableViewController {

    struct SeznamRowData {
        let name: String
        let id: Int
    }
    
    var className: String {
        return String(describing: self)
    }
    
    fileprivate var rowData = [SeznamRowData] ()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Seznam světců"
        rowData.append(SeznamRowData(name: "Abecední seznam", id: 0))
        rowData.append(SeznamRowData(name: "Kalendář", id: 1))
        setupSettingsTable()
        Analytics.logEvent(AnalyticsEventScreenView,
                           parameters:[AnalyticsParameterScreenName: "Seznam svetcu",
                                       AnalyticsParameterScreenClass: className])
        self.tableView.tableFooterView = UIView()
    }

    func setupSettingsTable() {
        tableView.register(SeznamSvetcuTableViewCell.self, forCellReuseIdentifier: SeznamSvetcuTableViewCell.cellId)
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
extension SeznamSvetcuTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SeznamSvetcuTableViewCell.cellId, for: indexPath) as! SeznamSvetcuTableViewCell
        let data = rowData[indexPath.row]
        cell.configureCell(name: data.name, cellWidth: tableView.frame.width)
        cell.accessoryType = .disclosureIndicator
        cell.layer.borderColor = UIColor.SvatiColor.darkGreenColor().cgColor
//        cell.layer.borderWidth = 1
//        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = rowData[indexPath.row]
        let alphaViewController = AlphabetViewController()
        alphaViewController.id = data.id
        navigationController?.pushViewController(alphaViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
