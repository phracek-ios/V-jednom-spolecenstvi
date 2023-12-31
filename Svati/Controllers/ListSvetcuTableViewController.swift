//
//  ListSvetcuTableViewController.swift
//  Svati
//
//  Created by Petr Hracek on 20.07.2023.
//

import Foundation
import XLPagerTabStrip
import FirebaseAnalytics
import FirebaseDatabase

class ListSvetcuTableViewController: UITableViewController {
    
    var backColor = UIColor.SvatiColor.backLightColor()
    var textColor = UIColor.SvatiColor.textLightColor()
    var popis: String = ""
    var text: String = ""
    var findString: String = ""
    var id: Int = 0
    var indexList: String = ""
    var pagerTabTitle: String = ""
    fileprivate var svatiStructure: SvatiStructure?
    fileprivate var indexCalendar = ["Leden", "Únor", "Březen", "Duben", "Květen", "Červen", "Červenec", "Srpen", "Září", "Říjen", "Listopad", "Prosinec"]
    
    struct ListSvetcuRowData {
        let name: String
        let date: String
        let popis: String
        let text: String
    }
    
    fileprivate var rowData = [ListSvetcuRowData] ()
    
    var className: String {
        return String(describing: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        svatiStructure = SvatiDataService.shared.svatiStructure
        loadData()
        setupSettingsTable()
        Analytics.logEvent(AnalyticsEventScreenView,
                           parameters:[AnalyticsParameterScreenName: "ListSvetcuTableViewController \(id):\(indexList)",
                                      AnalyticsParameterScreenClass: className])
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.SvatiColor.backLightColor()
    }
    
    func loadData() {
        debugPrint("\(id): \(indexList) \(findString)")
        for svati in (svatiStructure?.svati)! {
            // Abeceda
            if id == 0 {
                if svati.jmeno.count < 5 {
                    print(svati.jmeno[0])
                    if String(svati.jmeno[0]) != String(indexList) {
                        continue
                    }
                    rowData.append(ListSvetcuRowData(name: svati.jmeno, date: "\(svati.den).\(svati.mesic)", popis: svati.popis, text: svati.text))
                }
                else {
                    if String(svati.jmeno[4]) != String(indexList) {
                        continue
                    }
                    rowData.append(ListSvetcuRowData(name: svati.jmeno, date: "\(svati.den).\(svati.mesic)", popis: svati.popis, text: svati.text))
                }
            }
            // Kalendar
            else if id == 1 {
                let month_index = indexCalendar.firstIndex(of: indexList)!
                if svati.mesic != (month_index+1) {
                    continue
                }
                rowData.append(ListSvetcuRowData(name: svati.jmeno, date: "\(svati.den).\(svati.mesic)", popis: svati.popis, text: svati.text))

            }
            // Vyhledavani
            else if id == 2 {
                if svati.jmeno.range(of: findString) != nil {
                    rowData.append(ListSvetcuRowData(name: svati.jmeno, date: "\(svati.den).\(svati.mesic)", popis: svati.popis, text: svati.text))
                }
                if svati.text.range(of: findString) != nil {
                    rowData.append(ListSvetcuRowData(name: svati.jmeno, date: "\(svati.den).\(svati.mesic)", popis: svati.popis, text: svati.text))
                }
            }
        }
    }

    func setupSettingsTable() {
        tableView.register(ListSvetcuTableViewCell.self, forCellReuseIdentifier: ListSvetcuTableViewCell.cellId)
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension ListSvetcuTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListSvetcuTableViewCell.cellId, for: indexPath) as! ListSvetcuTableViewCell
        let data = rowData[indexPath.row]
        cell.configureCell(name: data.name, desc: data.popis, date: data.date, id: id, cellWidth: tableView.frame.width)
        cell.accessoryType = .disclosureIndicator
        cell.layer.borderColor = UIColor.SvatiColor.darkGreenColor().cgColor
        cell.clipsToBounds = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = rowData[indexPath.row]
        let svatyViewController = SvatyViewController()
        svatyViewController.id = 9999
        svatyViewController.jmeno = data.name
        svatyViewController.popis = data.popis
        svatyViewController.text = data.text
        navigationController?.pushViewController(svatyViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
