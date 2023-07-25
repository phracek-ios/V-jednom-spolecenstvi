//
//  OAplikaciViewController.swift
//  Svati
//
//  Created by Petr Hracek on 17.07.2023.
//

import Foundation
import UIKit

class OAplikaciViewController: UIViewController, UITextViewDelegate {
    //MARK: Properties

    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let text1 = "V jednom společenství verze 1.0<br>Offline mobilní verze pro zařízení Apple.<br><br>Autor mobilní aplikace tr. jáhen Petr Hráček.<br>Vydáno podle knihy Mons. prof. PhDr. ThDr. Karla Vrány.<br><br>Digitalizaci textů zajišťovala Lucie Smětáková.<br><br>Případné chyby, připomínky, či postřehy, prosím, zašlete na adresu phracek@gmail.com"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.view.backgroundColor = UIColor.SvatiColor.backLightColor()
        //self.contentView.backgroundColor = KKCBackgroundLightMode
        self.textView.backgroundColor = UIColor.SvatiColor.backLightColor()
        self.textView.textColor = UIColor.SvatiColor.textLightColor()
        title = "O aplikaci"
        //let textAttachment = NSTextAttachment()
        let attributedText = NSMutableAttributedString(attributedString: generateContent(text: text1))
//        textAttachment.image = UIImage(named: "delpsys")
//        attributedText.append(NSAttributedString(attachment: textAttachment))
//        attributedText.append(NSAttributedString(string: "\n"))
//        attributedText.append(NSMutableAttributedString(attributedString: generateContent(text: text2)))
        textView.attributedText = attributedText
        navigationController?.navigationBar.barStyle = UIBarStyle.black;
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Zpět", style: .plain, target: nil, action: nil)
        self.tabBarController?.tabBar.backgroundColor = UIColor.SvatiColor.darkGreenColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.parent?.title = "O aplikaci"

    }
    
}
extension OAplikaciViewController {
    private func setupView() {
        self.view.addSubview(stackView)
        stackView.addSubview(textView)
        stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 5).isActive = true
        //stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -10).isActive = true
        textView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        textView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }
}
