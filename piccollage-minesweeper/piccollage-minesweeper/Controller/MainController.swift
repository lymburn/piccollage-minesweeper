//
//  MainController.swift
//  piccollage-minesweeper
//
//  Created by Eugene Lu on 2021-03-05.
//

import UIKit

class MainController: UIViewController {
    private var board = Board(rows: 5, cols: 5, numberOfMines: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        registerCell()
    }
    
    let boardCellIdentifier = "BoardCellIdentifier"

    lazy var boardCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .gray
        collectionView.layer.borderWidth = 4
        collectionView.layer.borderColor = UIColor.black.cgColor
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
}

// MARK: Setup
extension MainController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(boardCollectionView)
    }
    
    fileprivate func setupConstraints() {
        boardCollectionView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        boardCollectionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        boardCollectionView.widthAnchor.constraint(equalToConstant: 40 * 5).isActive = true
        boardCollectionView.heightAnchor.constraint(equalToConstant: 40 * 5).isActive = true
    }
    
    fileprivate func registerCell() {
        boardCollectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: boardCellIdentifier)
    }
}

// MARK: Collection view delegate & data source functions
extension MainController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Represents rows
        return board.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Represents columns
        return board.numberOfColumns
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: boardCellIdentifier, for: indexPath) as! BoardCollectionViewCell
        
        // Cell aesthetics
        cell.backgroundColor = .clear
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        
        // Set label depending on the cell's status
        cell.statusLabel.text = board.getStatusTextForCell(row: indexPath.section, col: indexPath.row)
        
        return cell
    }
}

