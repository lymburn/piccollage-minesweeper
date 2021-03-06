//
//  BaseViewController.swift
//  piccollage-minesweeper
//
//  Created by Eugene Lu on 2021-03-05.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupNavigationBar(title: String?, barColor: UIColor, titleColor: UIColor) {
        self.navigationItem.title = title
        navigationController?.navigationBar.barTintColor = barColor
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = titleColor
    }
}
