//
//  ListSvetcuTableViewCell.swift
//  Svati
//
//  Created by Petr Hracek on 20.07.2023.
//

import Foundation
import UIKit

class ListSvetcuTableViewCell: UITableViewCell {
    static let cellId = "ListSvetcuTableViewCell"
    
    var title: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.lineBreakMode = .byWordWrapping
        l.numberOfLines = 0
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var popis: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.lineBreakMode = .byWordWrapping
        l.numberOfLines = 0
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var datum: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.lineBreakMode = .byWordWrapping
        l.numberOfLines = 0
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
           
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var stackTextView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    var backColor = UIColor.SvatiColor.backLightColor()
    var labelColor = UIColor.SvatiColor.textLightColor()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setupUI()
    }
    
    func setupUI() {
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        //stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        stackView.addSubview(datum)
        stackView.addSubview(stackTextView)
        stackTextView.addSubview(title)
        stackTextView.addSubview(popis)
        stackView.addConstraintsWithFormat(format: "V:|-5-[v0]-10-|", views: datum)
        stackView.addConstraintsWithFormat(format: "V:|-5-[v0]-10-|", views: stackTextView)
        stackView.addConstraintsWithFormat(format: "H:|-5-[v0(40)]-10-[v1]-10-|", views: datum, stackTextView)
        stackTextView.addConstraintsWithFormat(format: "H:|-5-[v0]-10-|", views: title)
        stackTextView.addConstraintsWithFormat(format: "H:|-5-[v0]-10-|", views: popis)
        stackTextView.addConstraintsWithFormat(format: "V:|-5-[v0]-10-[v1]-10-|", views: title, popis)

    }
    func configureCell(name: String, desc:String, date: String, id: Int, cellWidth: CGFloat) {
        self.backColor = UIColor.SvatiColor.backLightColor()
        self.labelColor = UIColor.SvatiColor.textLightColor()
        title.textColor = self.labelColor
        title.textAlignment = .left
        title.attributedText = generateContent(text: "<b>\(name)</b>")
        popis.text = desc
        datum.attributedText = generateContent(text: "<b>\(date)</b>")
        popis.textColor = self.labelColor
        popis.textAlignment = .left
        datum.textColor = self.labelColor
        datum.textAlignment = .left
        self.backgroundColor = self.backColor
        selectionStyle = .gray
    }
    
}
