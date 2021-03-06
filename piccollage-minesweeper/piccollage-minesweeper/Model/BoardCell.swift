//
//  BoardCell.swift
//  piccollage-minesweeper
//
//  Created by Eugene Lu on 2021-03-05.
//

import Foundation

struct BoardCell {
    var revealed: Bool = false
    var hasMine: Bool = false
    var hasFlag: Bool = false
    var numberOfNeighborMines: Int = 0
}
