//
//  AlphabetViewController.swift
//  Svati
//
//  Created by Petr Hracek on 19.07.2023.
//

import Foundation
import UIKit
import FirebaseAnalytics
import FirebaseDatabase
import Tabman
import Pageboy

class AlphabetViewController: TabmanViewController {
    
    fileprivate var svatiStructure: SvatiStructure?
    var id = 0
    fileprivate var indexAlphabet = ["A", "B", "C", "Č", "D", "E", "F", "G", "H", "CH", "I", "J", "K", "L", "M", "N", "O", "P", "R", "Ř", "S", "Š", "T", "U", "V", "Z", "Ž"]
    fileprivate var indexCalendar = ["Leden", "Únor", "Březen", "Duben", "Květen", "Červen", "Červenec", "Srpen", "Září", "Říjen", "Listopad", "Prosinec"]

    private var viewControllers: [UIViewController] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        svatiStructure = SvatiDataService.shared.svatiStructure
        // Do any additional setup after loading the view.
        self.viewControllers = self.loadViewControllers()
        loadTabBar()
        
        navigationController?.navigationBar.barStyle = UIBarStyle.default
    }
    func loadTabBar() {
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .flat(color: UIColor.SvatiColor.lightGreenColor())
        //bar.backgroundView.style = .blur(style: .light)
        bar.backgroundColor = UIColor.SvatiColor.lightGreenColor()
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 30.0, bottom: 0.0, right: 30.0)
        bar.layout.contentMode = .fit
        bar.layout.transitionStyle = .progressive
        bar.layout.interButtonSpacing = 10
        bar.fadesContentEdges = true
        bar.layout.separatorInset = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        bar.indicator.weight = .medium
        bar.buttons.customize{ (button) in
            button.selectedTintColor = UIColor.SvatiColor.mainTextColor()
            button.backgroundColor = UIColor.SvatiColor.lightGreenColor()
            button.tintColor = UIColor.SvatiColor.inActiveColor()
        }
        bar.indicator.cornerStyle = .rounded
        bar.indicator.tintColor = UIColor.SvatiColor.yellowColor()
        
        addBar(bar, dataSource: self, at: .top)
    }
    func loadViewControllers() -> [UIViewController] {
        var controllers: [UIViewController] = []
        if id == 0 {
            print("loadViewControllers: \(indexAlphabet.count)")
            for alpha in indexAlphabet {
                print(alpha)
                //            let vc = DnesniSvatyViewController()
                //            vc.id = i
                //            vc.text = svatiList[i].text
                //            vc.popis = svatiList[i].popis
                //            vc.pagerTabTitle = svatiList[i].jmeno
                //            controllers.append(vc)
            }
        }
        else {
            print("loadViewControllers: \(indexCalendar.count)")
            for alpha in indexCalendar {
                print(alpha)
                //            let vc = DnesniSvatyViewController()
                //            vc.id = i
                //            vc.text = svatiList[i].text
                //            vc.popis = svatiList[i].popis
                //            vc.pagerTabTitle = svatiList[i].jmeno
                //            controllers.append(vc)
            }
        }
        return controllers
    }
}

// MARK: - Private
extension AlphabetViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        print(viewControllers.count)
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .at(index: 0)
    }
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        if id == 0 {
            return TMBarItem(title: indexAlphabet[index])
        }
        else {
            return TMBarItem(title: indexCalendar[index])
        }
    }
}
