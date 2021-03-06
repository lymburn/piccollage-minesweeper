//
//  MainController.swift
//  piccollage-minesweeper
//
//  Created by Eugene Lu on 2021-03-05.
//

import UIKit

class MainController: UIViewController {
    // Private properties
    private var board = Board(rows: 5, cols: 5, numberOfMines: 5)
    private var gameState: GameState = .running
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        registerCell()
        registerLongPressGesture()
    }
    
    let boardCellIdentifier = "BoardCellIdentifier"
    
    lazy var restartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Restart", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(MainController.resetPressed), for: .touchDown)
        return button
    }()

    lazy var boardCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
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
        view.addSubview(restartButton)
        view.addSubview(boardCollectionView)
    }
    
    fileprivate func setupConstraints() {
        restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        restartButton.widthAnchor.constraint(equalToConstant: ScreenSize.width * 0.3).isActive = true
        restartButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        
        boardCollectionView.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: 16).isActive = true
        boardCollectionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        boardCollectionView.widthAnchor.constraint(equalToConstant: 40 * 5).isActive = true
        boardCollectionView.heightAnchor.constraint(equalToConstant: 40 * 5).isActive = true
    }
    
    fileprivate func registerCell() {
        boardCollectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: boardCellIdentifier)
    }
    
    fileprivate func registerLongPressGesture() {
        // Register long pressure gesture recognizer on collection view cell
        let gestureRecognizer: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                                                           action: #selector(MainController.handleLongPress))
        gestureRecognizer.minimumPressDuration = 0.5
        self.boardCollectionView.addGestureRecognizer(gestureRecognizer)
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
        
        let row = indexPath.section
        let col = indexPath.row
        
        // Cell aesthetics
        cell.backgroundColor = board.cellIsRevealed(row: row, col: col) ? .lightGray : .white
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        
        // Set label depending on the cell's status
        cell.statusLabel.text = board.getStatusTextForCell(row: indexPath.section, col: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Only reveal if game is not done
        if gameState != .finished {
            let row = indexPath.section
            let col = indexPath.row
            
            board.revealCell(row: row, col: col)
            collectionView.reloadData()
            
            // Set game state to finished if hit mine
            if board.cellIsMine(row: row, col: col) {
                self.gameState = .finished
            }
        }
    }
}

// Touch events
extension MainController {
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        // Function to add a flag after long press on a cell
        if gestureRecognizer.state != .began {
            return
        }

        let point = gestureRecognizer.location(in: self.boardCollectionView)

        if let indexPath = (self.boardCollectionView.indexPathForItem(at: point)) {
            board.setFlag(row: indexPath.section, col: indexPath.row)
            self.boardCollectionView.reloadData()
        }
    }
    
    @objc func resetPressed() {
        // Create new board, reset game state, and reload collection view
        self.gameState = .running
        board = Board(rows: 5, cols: 5, numberOfMines: 5)
        self.boardCollectionView.reloadData()
    }
}

