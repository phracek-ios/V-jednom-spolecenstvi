//
//  SeznamSvetcuTableViewCell.swift
//  Svati
//
//  Created by Petr Hracek on 19.07.2023.
//

import Foundation
import UIKit

class SeznamSvetcuTableViewCell: UITableViewCell {
    static let cellId = "SeznamSvetcuTableViewCell"
    
    var title: UILabel = {
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
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        //stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        stackView.addSubview(title)
        stackView.addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: title)
        stackView.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: title)
        
    }
    func configureCell(name: String, cellWidth: CGFloat) {
        self.backColor = UIColor.SvatiColor.backLightColor()
        self.labelColor = UIColor.SvatiColor.textLightColor()
        title.text = name
        title.textColor = self.labelColor
        title.textAlignment = .left
        self.backgroundColor = self.backColor
        selectionStyle = .gray
    }
    
}
