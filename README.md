# piccollage-minesweeper

## Intro
This repo is a basic implementation of Minesweeper in iOS. It includes 3 game levels with varying board sizes and number of mines. 

The player can either tap a cell to reveal it or hold down on a cell to place a flag. The possible labels for a cell are as follows:
* Number (#) - The cell has # of mines around it.
* M - The cell is a mine. The game is lost and must be restarted.
* F - A flag was placed on the cell.
* Empty - No mines are around this cell. All adjacent cells are clicked with and flood filled recursively.

## How to Run & Play

1. Clone the repo and open the project in XCode.
2. Build and run in a simulator or device that is **at least as large as the iPhone 6**. I did not dynamically size the board by device so the minimum device size for optimal gameplay is the iPhone 6.
3. Select a level in the start screen.
4. Click/tap the tiles until a mine is hit or victory achieved. Remember, holding down is the method to place a flag. Press the restart button or choose a new difficulty to keep playing!

## Tests
Note that unit tests for the Board.swift functionalities are also included with 98% coverage. 
