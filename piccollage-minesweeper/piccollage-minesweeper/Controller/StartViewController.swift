//
//  StartViewController.swift
//  piccollage-minesweeper
//
//  Created by Eugene Lu on 2021-03-05.
//

import Foundation
import UIKit

class StartViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(title: "Select Difficulty", barColor: .systemBlue, titleColor: .white)
    }
    
    // Game settings for the 3 possible game levels
    let gameSettingsByLevel: [GameLevel: GameSettings] = [.easy : GameSettings(boardRows: 5, boardColumns: 5, numberOfMines: 5),
                                                         .medium : GameSettings(boardRows: 10, boardColumns: 6, numberOfMines: 15),
                                                         .hard : GameSettings(boardRows: 14, boardColumns: 7, numberOfMines: 30)]
    
    lazy var startView: StartView = {
        let view = StartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.easyDifficultyButton.addTarget(self, action: #selector(StartViewController.easyButtonPressed), for: .touchDown)
        view.mediumDifficultyButton.addTarget(self, action: #selector(StartViewController.mediumButtonPressed), for: .touchDown)
        view.hardDifficultyButton.addTarget(self, action: #selector(StartViewController.hardButtonPressed), for: .touchDown)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        view.backgroundColor = .white
        view.addSubview(startView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        startView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        startView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ScreenSize.width * 0.1).isActive = true
        startView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ScreenSize.width * 0.1).isActive = true
        startView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

// MARK: Touch events
extension StartViewController {
    @objc func easyButtonPressed() {
        guard let gameSetting = gameSettingsByLevel[.easy] else { return }
        
        navigateToGameScreen(gameSetting: gameSetting)
    }
    
    @objc func mediumButtonPressed() {
        guard let gameSetting = gameSettingsByLevel[.medium] else { return }
        navigateToGameScreen(gameSetting: gameSetting)
    }
    
    @objc func hardButtonPressed() {
        guard let gameSetting = gameSettingsByLevel[.hard] else { return }
        navigateToGameScreen(gameSetting: gameSetting)
    }
}

// MARK: Helpers
extension StartViewController {
    fileprivate func navigateToGameScreen(gameSetting: GameSettings) {
        let mainController = MainViewController()
        mainController.gameSetting = gameSetting
        navigationController?.pushViewController(mainController, animated: true)
    }
}
