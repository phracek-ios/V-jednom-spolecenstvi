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
        title = ""
        let dnesniSvetciTableViewController = DnesniSvetciViewController()
        dnesniSvetciTableViewController.tabBarItem = UITabBarItem(title: "Dnešní světci", image: UIImage(named: "ic_priest"), tag: 0)

        let seznamSvetcuTableViewController = SeznamSvetcuTableViewController()
        seznamSvetcuTableViewController.tabBarItem = UITabBarItem(title: "Seznam světců", image: UIImage(named: "ic_book"), tag: 0)

        let vyhledavaniTableViewController = VyhledavaniViewController()
        vyhledavaniTableViewController.tabBarItem = UITabBarItem(title: "Vyhledávání", image: UIImage(named: "ic_search"), tag: 1)

        let oAplikaciViewController = OAplikaciViewController()
        oAplikaciViewController.tabBarItem = UITabBarItem(title: "O aplikaci", image: UIImage(named: "ic_info"), tag: 1)

        let tabBarList = [dnesniSvetciTableViewController, seznamSvetcuTableViewController, vyhledavaniTableViewController, oAplikaciViewController]
        
        viewControllers = tabBarList
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.SvatiColor.mainTextColor()]
        navigationController?.navigationBar.barStyle = UIBarStyle.black;
        navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
    
    // MARK: - Navigation

}
