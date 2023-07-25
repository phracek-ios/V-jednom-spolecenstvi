//
//  SvatiTabBarController.swift
//  Svati
//
//  Created by Petr Hracek on 17.07.2023.
//

import Foundation
import UIKit

class SvatiTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "V jednom společenství"
        let dnesniSvetciTableViewController = DnesniSvetciViewController()
        dnesniSvetciTableViewController.tabBarItem = UITabBarItem(title: "Dnešní světci", image: UIImage(named: "ic_priest"), tag: 0)

        let seznamSvetcuTableViewController = SeznamSvetcuTableViewController()
        seznamSvetcuTableViewController.tabBarItem = UITabBarItem(title: "Seznam světců", image: UIImage(named: "ic_book"), tag: 1)

        let vyhledavaniTableViewController = VyhledavaniViewController()
        vyhledavaniTableViewController.tabBarItem = UITabBarItem(title: "Vyhledávání", image: UIImage(named: "ic_search"), tag: 2)

        let oAplikaciViewController = OAplikaciViewController()
        oAplikaciViewController.tabBarItem = UITabBarItem(title: "O aplikaci", image: UIImage(named: "ic_info"), tag: 3)

        let tabBarList = [dnesniSvetciTableViewController, seznamSvetcuTableViewController, vyhledavaniTableViewController, oAplikaciViewController]
        
        viewControllers = tabBarList
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.SvatiColor.mainTextColor()]
        navigationController?.navigationBar.barTintColor = UIColor.SvatiColor.darkGreenColor()
        navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.tabBarController?.tabBar.backgroundColor = UIColor.SvatiColor.darkGreenColor()

    }
    
    // MARK: - Navigation

}
