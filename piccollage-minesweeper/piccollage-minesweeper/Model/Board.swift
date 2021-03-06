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
    var firstClick = true
    
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
                F - cell has a flag
                M - cell has a mine
        */
        
        let cell = grid[row][col]
        
        if !cell.revealed {
            return ""
        } else if cell.hasFlag {
            return "F"
        } else if cell.hasMine {
            return "M"
        } else if cell.numberOfNeighborMines > 0 {
            return "\(cell.numberOfNeighborMines)"
        } else {
            return ""
        }
    }
    
    func cellHasMine(row: Int, col: Int) -> Bool {
        return grid[row][col].hasMine
    }
    
    func cellIsRevealed(row: Int, col: Int) -> Bool {
        return grid[row][col].revealed
    }
    
    mutating func revealCell(row: Int, col: Int) {
        handleFirstClickEvent(row: row, col: col)
        
        grid[row][col].revealed = true
        
        if grid[row][col].numberOfNeighborMines == 0 {
            // If no mines nearby, recursively flood fill
            floodFill(row: row, col: col)
        }
    }
    
    mutating func setFlag(row: Int, col: Int) {
        // Set flag if it's not already set. Otherwise, remove flag
        if grid[row][col].revealed && grid[row][col].hasFlag {
            grid[row][col].hasFlag = false
            grid[row][col].revealed = false
        } else if !grid[row][col].revealed && !grid[row][col].hasFlag {
            grid[row][col].hasFlag = true
            grid[row][col].revealed = true
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
            setRandomMine()
        }
    }
    
    private mutating func setRandomMine() {
        let randomIndex = Int.random(in: 0..<possibleMineLocations.count)
        let mineLocation = possibleMineLocations[randomIndex]
        let row = mineLocation.0
        let col = mineLocation.1
        grid[row][col].hasMine = true
        
        // Prevent the mine location from being chosen again
        possibleMineLocations.remove(at: randomIndex)
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
    
    private mutating func handleFirstClickEvent(row: Int, col: Int) {
        // Handle rule that first click cannot hit a mine.
        if firstClick && possibleMineLocations.count > 0 {
            firstClick = false
            
            // If the first click is a mine, move it to a new location
            if grid[row][col].hasMine {
                setRandomMine()
                
                // Reset cell to a normal one
                grid[row][col].hasMine = false
                grid[row][col].numberOfNeighborMines = countNeighborMines(row: row, col: col)
            }
        }
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
