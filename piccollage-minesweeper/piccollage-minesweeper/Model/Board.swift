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
        // Simply assume rows & cols will be a valid number for this quiz
        self.numberOfRows = rows
        self.numberOfColumns = cols
        grid = Array(repeating: Array(repeating: BoardCell(), count: cols), count: rows)
        
        // Initialize mines
        self.numberOfMines = numberOfMines
        
        storePossibleMineLocations()
        initializeMines()
        setNeighborMinesCount()
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
        } else if cell.numberOfNeighborMines > 0{
            return "\(cell.numberOfNeighborMines)"
        } else {
            return ""
        }
    }
    
    func cellIsRevealed(row: Int, col: Int) -> Bool {
        return grid[row][col].revealed
    }
    
    mutating func revealCell(row: Int, col: Int) {
        grid[row][col].revealed = true
        
        if grid[row][col].numberOfNeighborMines == 0 {
            floodFill(row: row, col: col)
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
    
    private mutating func setNeighborMinesCount() {
        // Count the number of neighbouring mines for each non-mine cell and set it in the grid
        for row in 0..<grid.count {
            for col in 0..<grid[0].count {
                grid[row][col].numberOfNeighborMines = countNeighborMines(row: row, col: col)
            }
        }
    }
    
    private func countNeighborMines(row: Int, col: Int) -> Int {
        // Function to count the number of neighbor mines for a cell at row,col
        var neighboringMinesCount: Int = 0
        
        for xoff in -1...1 {
            for yoff in -1...1 {
                let rowToCheck = row + xoff
                let colToCheck = col + yoff
                
                // Boundary check
                if rowToCheck > -1 && rowToCheck < grid.count && colToCheck > -1 && colToCheck < grid[0].count {
                    let neighbor = grid[rowToCheck][colToCheck]
                    
                    if neighbor.hasMine {
                        neighboringMinesCount += 1
                    }
                }
            }
        }
        
        return neighboringMinesCount
    }
    
    private mutating func floodFill(row: Int, col: Int) {
        // Flood fill neighbours that aren't mines & aren't already revealed
        for xoff in -1...1 {
            for yoff in -1...1 {
                let rowToCheck = row + xoff
                let colToCheck = col + yoff
                
                // Boundary check
                if rowToCheck > -1 && rowToCheck < grid.count && colToCheck > -1 && colToCheck < grid[0].count {
                    let neighbor = grid[rowToCheck][colToCheck]
                    
                    if !neighbor.hasMine && !neighbor.revealed {
                        revealCell(row: rowToCheck, col: colToCheck)
                    }
                }
            }
        }
    }
}
