//
//  ViewController.swift
//  Svati
//
//  Created by Petr Hracek on 17.07.2023.
//

import UIKit
import FirebaseAnalytics
import FirebaseDatabase
import Tabman
import Pageboy

class DnesniSvetciViewController: TabmanViewController {

    fileprivate var svatiStructure: SvatiStructure?
    fileprivate var svatiList = [Svati]()
    var viewControllers: [UIViewController] = []
    
    var className: String {
        return String(describing: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        svatiStructure = SvatiDataService.shared.svatiStructure
        // Do any additional setup after loading the view.
        get_svati_list()
        self.viewControllers = self.loadViewControllers()
        loadTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.parent?.title = "V jednom společenství"
        self.title = "Dnešní svědci"
//        let nextItem = UIBarButtonItem(title: "ZÍTRA", style: .plain, target: self, action: #selector(nextBtn_pressed))
//        let prevItem = UIBarButtonItem(title: "VČERA", style: .plain, target: self, action: #selector(prevBtn_pressed))
//        nextItem.tintColor = UIColor.SvatiColor.mainTextColor()
//        prevItem.tintColor = UIColor.SvatiColor.mainTextColor()
//        self.parent?.navigationItem.rightBarButtonItems = [nextItem, prevItem ]
        self.parent?.navigationController?.navigationBar.barStyle = UIBarStyle.black
        Analytics.logEvent(AnalyticsEventScreenView,
                           parameters:[AnalyticsParameterScreenName: self.className,
                                       AnalyticsParameterScreenClass: className])

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
        print("loadViewControllers: \(svatiList.count)")
        for i in 0..<svatiList.count {
            let vc = SvatyViewController()
            vc.id = i
            vc.jmeno = svatiList[i].jmeno
            vc.text = svatiList[i].text
            vc.popis = svatiList[i].popis
            vc.pagerTabTitle = svatiList[i].jmeno
            controllers.append(vc)
        }
        return controllers
    }
    
    func get_svati_list() {
        svatiList.removeAll()
        let day = get_day()
        for svati in (svatiStructure?.svati)! {
            if svati.mesic != get_month() {
                continue
            }
            if svati.den != day - 1 {
                continue
            }
            svatiList.append(svati)
        }
        for svati in (svatiStructure?.svati)! {
            if svati.mesic != get_month() {
                continue
            }
            if svati.den != day {
                continue
            }
            svatiList.append(svati)
        }
        for svati in (svatiStructure?.svati)! {
            if svati.mesic != get_month() {
                continue
            }
            if svati.den != day + 1 {
                continue
            }
            svatiList.append(svati)
        }
        print(svatiList)
    }
    
}

// MARK: - Private
extension DnesniSvetciViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .at(index: 1)
    }
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        title = ""
        for i in 0..<svatiList.count {
            if i != index {
                continue
            }
            if i == 0 {
                title = "VČERA"
            } else if i == svatiList.count - 1 {
                title = "ZÍTRA"
            }
            else {
                title = "DNES"
            }
        }
        return TMBarItem(title: title!)
    }
}
