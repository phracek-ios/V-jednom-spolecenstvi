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
    }
    private func setupView() {
        self.view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true

        stackView.addSubview(staticLabel)
        stackView.addSubview(findTextField)
        stackView.addSubview(labelForNoneResults)
        staticLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 20).isActive = true
        staticLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -20).isActive = true
        staticLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 20).isActive = true
        findTextField.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 20).isActive = true
        findTextField.topAnchor.constraint(equalTo: staticLabel.bottomAnchor, constant: 40).isActive = true
        findTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true

        labelForNoneResults.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 20).isActive = true
        labelForNoneResults.topAnchor.constraint(equalTo: findTextField.bottomAnchor, constant: 20).isActive = true
        labelForNoneResults.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -20).isActive = true

        title = "Vyhledávání"
        findTextField.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -20).isActive = true
        findTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50).isActive = true
        findTextField.addTarget(self, action: #selector(self.textFieldShouldReturn), for: .editingDidEndOnExit)
        staticLabel.text = "Zadejte hledaný text"
        findTextField.returnKeyType = .done
        labelForNoneResults.isEnabled = false
        labelForNoneResults.text = ""
        self.view.backgroundColor = self.backColor
        self.labelForNoneResults.backgroundColor = self.backColor
        self.labelForNoneResults.textColor = self.textColor
        self.staticLabel.backgroundColor = self.backColor
        self.staticLabel.textColor = self.textColor
        self.findTextField.backgroundColor = self.backColor
        self.findTextField.textColor = self.textColor
        self.findTextField.layer.borderColor = UIColor.black.cgColor
        findTextField.attributedPlaceholder = NSAttributedString(
            string: " Vyhledejte slovo či část slova v katechismus",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.SvatiColor.inActiveColor()]
            )
    }
    
}

extension VyhledavaniViewController {

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let svatiStructure = svatiStructure else { return false }
        let stringToFind = findTextField.text! + string
        if stringToFind.count < 3 {
            labelForNoneResults.isEnabled = true
            labelForNoneResults.text = "Hledaný výraz musí mít alespoň 3 znaky."
            return true
        }
        print("ShouldChangeCharactersIn: \(stringToFind)")
        var contSearchData = [String]()
        for svati in svatiStructure.svati {
            if svati.jmeno.range(of: stringToFind) != nil {
                contSearchData.append(String(svati.jmeno))
            }
            if svati.text.range(of: stringToFind) != nil {
                contSearchData.append(String(svati.jmeno))
            }
        }
        if contSearchData.count != 0 {
            labelForNoneResults.isEnabled = false
            let textWithSep = contSearchData.joined(separator: "\n")
            labelForNoneResults.attributedText = generateContent(text: "Hledaný výraz <b>\(stringToFind)</b> byl nalezen u následujících světců:\n\n" + textWithSep)
            return true
        }
        else {
            labelForNoneResults.isEnabled = true
            labelForNoneResults.text = "Hledaný výraz nebyl nalezen"
            return false
        }
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
//            let pcvc = ParagraphTableViewController()
//            pcvc.kindOfSource = 2
//            pcvc.findString = self.findString
//            pcvc.findData = findData
//            navigationController?.pushViewController(pcvc, animated: true)
            findTextField.resignFirstResponder()
        }
        else {
            labelForNoneResults.isEnabled = true
            labelForNoneResults.text = "Hledaný výraz nebyl nalezen"
        }

        return true
    }
}

