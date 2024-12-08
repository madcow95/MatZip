//
//  MyPageTableCell.swift
//  MatZip
//
//  Created by MadCow on 2024/12/6.
//

import UIKit
import SnapKit

class MyPageTableCell: UITableViewCell {
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
    }
    
    func configureCell() {
        label.text = "TEST"
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
    }
}
