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
    private var viewControllers: [UIViewController] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        svatiStructure = SvatiDataService.shared.svatiStructure
        // Do any additional setup after loading the view.
        get_svati()
        self.viewControllers = self.loadViewControllers()
        loadTabBar()
        
        let nextItem = UIBarButtonItem(image: UIImage(named: "ic_info"), style: .plain, target: self, action: #selector(nextBtn_pressed))
        let prevItem = UIBarButtonItem(title: "Včera", style: .plain, target: self, action: #selector(prevBtn_pressed))
        nextItem.tintColor = .blue
        navigationItem.rightBarButtonItem = nextItem
        navigationController?.navigationBar.barStyle = UIBarStyle.default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.parent?.title = "V jednom společenství"

    }

    // Svati na jeden den muzou byt i dva !!!!!
    // Ziskat den a nasledne najit v databazi odpovidajici svetce
    // Jeden nebo Dva Taby

    func get_svati() {
        for svati in (svatiStructure?.svati)! {
            if svati.den != get_day() || svati.mesic != get_month() {
                continue
            }
            svatiList.append(svati)
        }
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
            let vc = DnesniSvatyViewController()
            vc.id = i
            vc.text = svatiList[i].text
            vc.popis = svatiList[i].popis
            vc.pagerTabTitle = svatiList[i].jmeno
            controllers.append(vc)
        }
        return controllers
    }
    
    @objc func nextBtn_pressed() {
        debugPrint("Next Button clicked")
    }
    @objc func prevBtn_pressed() {
        debugPrint("Next Button clicked")
    }
}

// MARK: - Private
extension DnesniSvetciViewController: PageboyViewControllerDataSource, TMBarDataSource {
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
        title = ""
        for i in 0..<svatiList.count {
            if i != index {
                continue
            }
            title = svatiList[i].jmeno
        }
        return TMBarItem(title: title!)
    }
}
