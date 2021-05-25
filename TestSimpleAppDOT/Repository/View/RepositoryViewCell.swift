//
//  RepositoryViewCell.swift
//  TestSimpleAppDOT
//
//  Created by Sayyid Maulana Khakul Yakin on 25/05/21.
//

import UIKit

class RepositoryViewCell: UITableViewCell {
    
    let label: UILabel = {
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
        addSubview(label)
        label.setAnchor(top: topAnchor, left: leadingAnchor, bottom: nil, right: trailingAnchor, paddingTop: 70, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
    }

}
