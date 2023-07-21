//
//  SvatyViewController.swift
//  Svati
//
//  Created by Petr Hracek on 18.07.2023.
//

import Foundation
import XLPagerTabStrip
import FirebaseAnalytics
import FirebaseDatabase

class SvatyViewController: UIViewController {
    var backColor = UIColor.SvatiColor.backLightColor()
    var textColor = UIColor.SvatiColor.textLightColor()
    var jmeno: String = ""
    var popis: String = ""
    var text: String = ""
    var id: Int = 0
    var pagerTabTitle: String = ""
    
    var className: String {
        return String(describing: self)
    }
    
    lazy var scrollView: UIScrollView = {
        let scv = UIScrollView()
        scv.translatesAutoresizingMaskIntoConstraints = false
        scv.backgroundColor = UIColor.SvatiColor.backLightColor()
        return scv
    }()
    
    lazy var scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.contentMode = UIView.ContentMode.scaleToFill
        view.backgroundColor = UIColor.SvatiColor.backLightColor()
        return view
    }()
    
    lazy var svatyJmenoLabel : UILabel = {
        let b = UILabel()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.font = UIFont.systemFont(ofSize: 12.0)
        b.numberOfLines = 0
        b.lineBreakMode = .byWordWrapping
        b.backgroundColor = UIColor.SvatiColor.backLightColor()
        b.textColor = UIColor.SvatiColor.textLightColor()
        return b
    }()
    
    lazy var svatyTextLabel : UILabel = {
        let b = UILabel()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.font = UIFont.systemFont(ofSize: 12.0)
        b.numberOfLines = 0
        b.lineBreakMode = .byWordWrapping
        b.backgroundColor = UIColor.SvatiColor.backLightColor()
        b.textColor = UIColor.SvatiColor.textLightColor()
        return b
    }()

    lazy var svatyPopisLabel : UILabel = {
        let b = UILabel()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.font = UIFont.systemFont(ofSize: 12.0)
        b.numberOfLines = 0
        b.lineBreakMode = .byWordWrapping
        b.backgroundColor = UIColor.SvatiColor.backLightColor()
        b.textColor = UIColor.SvatiColor.textLightColor()
        return b
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        setupView()

        setupUI()
        popis = "<center><b>" + popis + "</b></center>"
        print(popis)
        svatyPopisLabel.attributedText = generateContent(text: popis, color: self.textColor)
        svatyTextLabel.attributedText = generateContent(text: text, color: self.textColor)
        print(id)
        if id == 9999 {
            self.title = jmeno
        }
        else {
            svatyJmenoLabel.attributedText = generateContent(text: "<center><b>" + jmeno + "</b></center>", color: self.textColor)
        }
        Analytics.logEvent(AnalyticsEventScreenView,
                           parameters:[AnalyticsParameterScreenName: "DnesniSvati",
                                      AnalyticsParameterScreenClass: className])
    }
    func setupUI() {
        self.view.backgroundColor = self.backColor
        self.scrollView.backgroundColor = self.backColor
        self.scrollViewContainer.backgroundColor = self.backColor
        self.svatyJmenoLabel.backgroundColor = self.backColor
        self.svatyJmenoLabel.textColor = self.textColor
        self.svatyPopisLabel.backgroundColor = self.backColor
        self.svatyPopisLabel.textColor = self.textColor
        self.svatyTextLabel.textColor = self.textColor
        self.svatyTextLabel.backgroundColor = self.backColor
        
    }
    func setupView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        scrollView.addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: scrollViewContainer)
        
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -12-12).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: +10).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -25).isActive = true
        
        if id != 9999 {
            scrollViewContainer.addSubview(svatyJmenoLabel)
        }
        scrollViewContainer.addSubview(svatyPopisLabel)
        scrollViewContainer.addSubview(svatyTextLabel)
        if id != 9999 {
            scrollViewContainer.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: svatyJmenoLabel)

        }
        scrollViewContainer.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: svatyPopisLabel)
        scrollViewContainer.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: svatyTextLabel)
        var constr: Int = 20
        if #available(iOS 15.0, *) {
            constr = 10
        }
        if id != 9999 {
            scrollViewContainer.addConstraintsWithFormat(format: "V:|-\(constr)-[v0]-10-[v1]-10-[v2]-10-|", views: svatyJmenoLabel, svatyPopisLabel, svatyTextLabel)
        } else {
            scrollViewContainer.addConstraintsWithFormat(format: "V:|-\(constr)-[v0]-10-[v1]-10-|", views: svatyPopisLabel, svatyTextLabel)
        }
    }
}

//// MARK: - IndicatorInfoProvider
extension SvatyViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: pagerTabTitle)
    }
}

