//
//  BoardCollectionViewCell.swift
//  piccollage-minesweeper
//
//  Created by Eugene Lu on 2021-03-05.
//

import UIKit

class BoardCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        updateConstraints()
    }
    
    // Label which indicates the status of that cell (# - number, M - mine, F - flag)
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Setup
extension BoardCollectionViewCell {
    fileprivate func setupViews() {
        addSubview(statusLabel)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        statusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        statusLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
}
