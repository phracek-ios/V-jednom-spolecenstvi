//
//  VyhledavaniViewController.swift
//  Svati
//
//  Created by Petr Hracek on 17.07.2023.
//

import Foundation
import UIKit

class VyhledavaniViewController: UIViewController, UITextFieldDelegate {
    
    var findString: String = ""
    
    fileprivate var svatiStructure: SvatiStructure?
    var backColor = UIColor.SvatiColor.backLightColor()
    var textColor = UIColor.SvatiColor.textLightColor()
    
    lazy var staticLabel: UILabel = {
        let l = UILabel()
        l.lineBreakMode = .byWordWrapping
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var ok_button: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.lightGray
        b.setTitle("Vyhledat text", for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    lazy var labelForNoneResults: UILabel = {
        let l = UILabel()
        l.lineBreakMode = .byWordWrapping
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var findTextField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .left
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.autocapitalizationType = .none
        tf.layer.borderColor = UIColor.black.cgColor
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var subsectionLabel: UILabel = {
        let l = UILabel()
        l.lineBreakMode = .byWordWrapping
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        svatiStructure = SvatiDataService.shared.svatiStructure
        findTextField.delegate = self
        setupView()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Zpět", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.barStyle = UIBarStyle.black;
        self.tabBarController?.tabBar.backgroundColor = UIColor.SvatiColor.darkGreenColor()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.parent?.title = "Vyhledávání"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Zpět", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.barStyle = UIBarStyle.black;
    }

    private func setupView() {
        self.view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        //stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true

        stackView.addSubview(staticLabel)
        stackView.addSubview(findTextField)
        stackView.addSubview(ok_button)
        stackView.addSubview(labelForNoneResults)
        stackView.addConstraintsWithFormat(format: "V:|-15-[v0]-20-[v1]-20-[v2]-20-[v3]", views: staticLabel, findTextField, ok_button, labelForNoneResults)
//        stackView.addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: staticLabel)
//        stackView.addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: findTextField)
//        stackView.addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: labelForNoneResults)
        findTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        findTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        ok_button.widthAnchor.constraint(equalToConstant: 250).isActive = true
        ok_button.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        staticLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        findTextField.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        labelForNoneResults.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true

        title = "Vyhledávání"
//        findTextField.addTarget(self, action: #selector(self.textFieldShouldReturn), for: .editingDidEndOnExit)
        staticLabel.text = "Zadejte hledaný text"
        findTextField.returnKeyType = .done
        labelForNoneResults.isEnabled = false
        labelForNoneResults.text = ""
        self.view.backgroundColor = self.backColor
        self.labelForNoneResults.backgroundColor = self.backColor
        self.labelForNoneResults.textColor = self.textColor
        self.ok_button.setTitleColor(self.textColor, for: .normal)
        self.staticLabel.backgroundColor = self.backColor
        self.staticLabel.textColor = self.textColor
        self.ok_button.addTarget(self, action: #selector(button_pressed), for: .touchUpInside)
        self.findTextField.backgroundColor = self.backColor
        self.findTextField.textColor = self.textColor
        self.findTextField.layer.borderColor = UIColor.black.cgColor
        findTextField.attributedPlaceholder = NSAttributedString(
            string: "Zadejte hledaný text",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.SvatiColor.inActiveColor()]
            )
    }
    
    @objc func button_pressed(_ sender: UIButton) {
        guard let svatiStructure = svatiStructure else { return }
        var contSearchData = [String]()
        self.findString = findTextField.text!
        debugPrint(findString)
        for svati in svatiStructure.svati {
            if svati.jmeno.range(of: findString) != nil {
                contSearchData.append(svati.jmeno)
            }
            if svati.text.range(of: findString) != nil {
                contSearchData.append(svati.jmeno)
            }
        }

        if contSearchData.count != 0 {
            debugPrint(contSearchData.count)
            let lstvc = ListSvetcuTableViewController()
            lstvc.id = 2
            lstvc.findString = self.findString
            navigationController?.pushViewController(lstvc, animated: true)
            findTextField.resignFirstResponder()
        }
        else {
            labelForNoneResults.isEnabled = true
            labelForNoneResults.text = "Hledaný výraz nebyl nalezen"
        }

    }
}

extension VyhledavaniViewController {

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let svatiStructure = svatiStructure else { return false }
        var stringToFind: String = findTextField.text! + string

        labelForNoneResults.text = ""
//        if stringToFind.count < 3 {
//            labelForNoneResults.isEnabled = true
//            return true
//        }
//
//        print("ShouldChangeCharactersIn text : \(findTextField.text!)")
//        print("ShouldChangeCharactersIn replacement: \(string)")
//        var contSearchData = [String]()
//        for svati in svatiStructure.svati {
//            if svati.jmeno.range(of: stringToFind) != nil {
//                contSearchData.append(String(svati.jmeno))
//            }
//            if svati.text.range(of: stringToFind) != nil {
//                contSearchData.append(String(svati.jmeno))
//            }
//        }
//        if contSearchData.count != 0 {
//            labelForNoneResults.isEnabled = false
//            let textWithSep = contSearchData.joined(separator: "\n")
//            labelForNoneResults.attributedText = generateContent(text: "Hledaný výraz <b>\(stringToFind)</b> byl nalezen u následujících světců:\n\n" + textWithSep)
//            return true
//        }
//        else {
//            labelForNoneResults.isEnabled = true
//            labelForNoneResults.text = "Hledaný výraz nebyl nalezen"
//            return false
//        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let svatiStructure = svatiStructure else { return false }
        var contSearchData = [String]()
        self.findString = findTextField.text!
        print(findString)
        for svati in svatiStructure.svati {
            if svati.jmeno.range(of: findString) != nil {
                contSearchData.append(svati.jmeno)
            }
            if svati.text.range(of: findString) != nil {
                contSearchData.append(svati.jmeno)
            }
        }

        if contSearchData.count != 0 {
            print(contSearchData.count)
            let lstvc = ListSvetcuTableViewController()
            lstvc.id = 2
            lstvc.findString = self.findString
            navigationController?.pushViewController(lstvc, animated: true)
            findTextField.resignFirstResponder()
        }
        else {
            labelForNoneResults.isEnabled = true
            labelForNoneResults.text = "Hledaný výraz nebyl nalezen"
        }

        return true
    }
}

