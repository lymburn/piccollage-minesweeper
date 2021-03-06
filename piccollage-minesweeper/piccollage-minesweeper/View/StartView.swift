//
//  StartView.swift
//  piccollage-minesweeper
//
//  Created by Eugene Lu on 2021-03-05.
//

import Foundation
import UIKit

class StartView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let easyDifficultyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Easy 5x5 board, 5 mines", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    let mediumDifficultyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Medium 10x6 board, 15 mines", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        return button
    }()
    
    let hardDifficultyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hard 14x7 board, 30 mines", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .red
        return button
    }()
}

// MARK: Setup
extension StartView {
    fileprivate func setupViews() {
        addSubview(easyDifficultyButton)
        addSubview(mediumDifficultyButton)
        addSubview(hardDifficultyButton)
    }
    
    fileprivate func setupConstraints() {
        easyDifficultyButton.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        easyDifficultyButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        easyDifficultyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        easyDifficultyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        mediumDifficultyButton.topAnchor.constraint(equalTo: easyDifficultyButton.bottomAnchor, constant: 16).isActive = true
        mediumDifficultyButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        mediumDifficultyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        mediumDifficultyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        hardDifficultyButton.topAnchor.constraint(equalTo: mediumDifficultyButton.bottomAnchor, constant: 16).isActive = true
        hardDifficultyButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        hardDifficultyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        hardDifficultyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
}
