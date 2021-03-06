//
//  Board.swift
//  piccollage-minesweeper
//
//  Created by Eugene Lu on 2021-03-05.
//

import Foundation

struct Board {
    private var grid: [[BoardCell]]
    private var possibleMineLocations: [(Int, Int)] = []
    private let numberOfMines: Int
    let numberOfColumns: Int
    let numberOfRows: Int
    
    init (rows: Int, cols: Int, numberOfMines: Int) {
        // Assume rows & cols will be greater than 0
        self.numberOfRows = rows
        self.numberOfColumns = cols
        grid = Array(repeating: Array(repeating: BoardCell(), count: cols), count: rows)
        
        // Initialize mines
        self.numberOfMines = numberOfMines
        
        storePossibleMineLocations()
        initializeMines()
    }
    
    /* Public functions */
    func getStatusTextForCell(row: Int, col: Int) -> String {
        /*
            Function to get the status text for the board cell with the possible types:
                # (number) - cell with a number of mines greater than 0 around
                empty - cell with 0 mines around
                M - cell is a mine
        */
        
        let cell = grid[row][col]
        
        if !cell.revealed {
            return ""
        } else if cell.hasMine {
            return "M"
        } else {
            return ""
        }
    }
    
    /* Private functions */
    
    private mutating func storePossibleMineLocations() {
        // Function to store all the possible mine locations in an array with dictionary of (row, col) as the locations
        for row in 0..<grid.count {
            for col in 0..<grid[0].count {
                possibleMineLocations.append((row, col))
            }
        }
    }
    
    private mutating func initializeMines() {
        // Initialize all the mines randomly on the grid
        for _ in 0..<numberOfMines {
            let randomIndex = Int.random(in: 0..<possibleMineLocations.count)
            let mineLocation = possibleMineLocations[randomIndex]
            let row = mineLocation.0
            let col = mineLocation.1
            grid[row][col].hasMine = true
            
            // Prevent the mine location from being chosen again
            possibleMineLocations.remove(at: randomIndex)
            
        }
    }
}
