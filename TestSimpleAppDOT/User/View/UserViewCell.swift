//
//  UserViewCell.swift
//  TestSimpleAppDOT
//
//  Created by Sayyid Maulana Khakul Yakin on 25/05/21.
//

import UIKit

class UserViewCell: UITableViewCell {
    
    
    lazy var img: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 20
        img.clipsToBounds = true
        return img
    }()
    
    let label: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 12)
        text.numberOfLines = 2
        return text
    }()

    let labelLogin: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 12)
        text.numberOfLines = 2
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(img)
        addSubview(label)
        addSubview(labelLogin)
        img.setAnchor(top: topAnchor, left: leadingAnchor, bottom: bottomAnchor, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 0, width: 180, height: 150)
        label.setAnchor(top: topAnchor, left: img.trailingAnchor, bottom: nil, right: trailingAnchor, paddingTop: 70, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        labelLogin.setAnchor(top: label.bottomAnchor, left: img.trailingAnchor, bottom: nil, right: trailingAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
    }
}
