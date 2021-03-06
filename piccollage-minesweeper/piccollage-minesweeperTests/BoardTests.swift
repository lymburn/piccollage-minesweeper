//
//  BoardTests.swift
//  piccollage-minesweeperTests
//
//  Created by Eugene Lu on 2021-03-05.
//

import XCTest
@testable import piccollage_minesweeper

class BoardTests: XCTestCase {
    var board: Board!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBoardContainsNoMines() {
        // Test a board initialized without mines
        board = Board(rows: 5, cols: 5, numberOfMines: 0)
        
        // Ensure no cell has mines
        for row in 0..<5 {
            for col in 0..<5 {
                XCTAssertFalse(board.cellHasMine(row: row, col: col))
            }
        }
    }
    
    func testBoardContainsCorrectNumberOfMines() {
        // Test a board initialized with all mines to ensure no spot is missed because of duplicate
        
        board = Board(rows: 5, cols: 5, numberOfMines: 25)
        var mineCount = 0
        let expectedMineCount = 25
        
        for row in 0..<5 {
            for col in 0..<5 {
                if board.cellHasMine(row: row, col: col) {
                    mineCount += 1
                }
            }
        }
        
        XCTAssertEqual(mineCount, expectedMineCount)
    }
    
    func testBoardRevealsCell() {
        // Test if the board reveals a cell when function called
        
        board = Board(rows: 5, cols: 5, numberOfMines: 5)
        
        board.revealCell(row: 0, col: 0)
        
        XCTAssertTrue(board.cellIsRevealed(row: 0, col: 0))
    }
    
    func testSetFlagRevealsCell() {
        // Test if setting a flag reveals the cell
        
        board = Board(rows: 5, cols: 5, numberOfMines: 5)
        
        board.setFlag(row: 0, col: 0)
        
        XCTAssertTrue(board.cellIsRevealed(row: 0, col: 0))
    }
    
    func testSetFlagUnrevealsCell() {
        // Test if setting a flag twice unreveals the cell
        
        board = Board(rows: 5, cols: 5, numberOfMines: 5)
        
        board.setFlag(row: 0, col: 0)
        board.setFlag(row: 0, col: 0)
        
        XCTAssertFalse(board.cellIsRevealed(row: 0, col: 0))
    }
    
    func testFloodFill() {
        // Test if all the cells are revealed after flood filling a board without mines
        board = Board(rows: 5, cols: 5, numberOfMines: 0)
        
        board.revealCell(row: 0, col: 0)
        
        for row in 0..<5 {
            for col in 0..<5 {
                XCTAssertTrue(board.cellIsRevealed(row: row, col: col))
            }
        }
    }
    
    func testGetStatusTextUnrevealed() {
        // Test the get status function for an unrevealed cell
        
        board = Board(rows: 5, cols: 5, numberOfMines: 0)
        
        let status = board.getStatusTextForCell(row: 0, col: 0)
        let expectedStatus = ""
        
        XCTAssertEqual(status, expectedStatus)
    }
    
    func testGetStatusTextMine() {
        // Test the get status function for a mine cell
        
        board = Board(rows: 5, cols: 5, numberOfMines: 25)
        board.revealCell(row: 0, col: 0)
        
        let status = board.getStatusTextForCell(row: 0, col: 0)
        let expectedStatus = "M"
        
        XCTAssertEqual(status, expectedStatus)
    }
    
    func testGetStatusTextFlag() {
        // Test the get status function for a flag cell
        
        board = Board(rows: 5, cols: 5, numberOfMines: 5)
        board.setFlag(row: 0, col: 0)
        
        let status = board.getStatusTextForCell(row: 0, col: 0)
        let expectedStatus = "F"
        
        XCTAssertEqual(status, expectedStatus)
    }
    
    func testStatusTextWithNeighbors() {
        // Test if the correct number of neighbors for a cell in a 2x2 board with 3 mines
        
        board = Board(rows: 2, cols: 2, numberOfMines: 3)
        
        // Cell should have 3 mines around it
        let expectedStatus = "3"
        
        // Find cell that's not mine
        for row in 0..<2 {
            for col in 0..<2 {
                if !board.cellHasMine(row: row, col: col) {
                    // Found cell that's not mine
                    board.revealCell(row: row, col: col)
                    let statusText = board.getStatusTextForCell(row: row, col: col)
                    XCTAssertEqual(statusText, expectedStatus)
                }
            }
        }
    }
    
    func testHandleFirstClick() {
        // Test if first click is prevented from hitting a mine
        
        // Create board with 1 open spot
        board = Board(rows: 3, cols: 3, numberOfMines: 8)
        
        // Store new location that mine should be moved to
        var newMineRow = 0
        var newMineCol = 0
        
        // Find cell that's not a mine and store location
        for row in 0..<3 {
            for col in 0..<3 {
                if !board.cellHasMine(row: row, col: col) {
                    // Found cell that's not mine
                    newMineRow = row
                    newMineCol = col
                }
            }
        }
        
        // Click on first mine
        var firstClick = true
        
        for row in 0..<3 {
            for col in 0..<3 {
                if board.cellHasMine(row: row, col: col) && firstClick {
                    board.revealCell(row: row, col: col)
                    firstClick = false
                    
                    // Check that the clicked cell is not a mine
                    XCTAssertFalse(board.cellHasMine(row: row, col: col))
                    
                    // Check that the new mine location now has a mine
                    XCTAssertTrue(board.cellHasMine(row: newMineRow, col: newMineCol))
                }
            }
        }
    }
}
