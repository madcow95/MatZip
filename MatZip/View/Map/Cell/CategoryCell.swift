//
//  CategoryCell.swift
//  MatZip
//
//  Created by MadCow on 2024/12/1.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .systemGreen
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    func configureUI(text: String) {
        self.titleLabel.text = text
    }
}
