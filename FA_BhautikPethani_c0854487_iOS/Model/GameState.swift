//
//  GameState.swift
//  FA_BhautikPethani_c0854487_iOS
//
//  Created by Bhautik Pethani on 2022-05-30.
//

import Foundation

class GameState {
    var player1Score: Int
    var player2Score: Int
    var board: [[Int]]
    var steps: Int
    var player1Turn: Bool
    var player2Turn: Bool
    
    init(player1Score: Int, player2Score: Int, board: [[Int]], steps: Int, player1Turn: Bool, player2Turn: Bool){
        self.player1Score = player1Score
        self.player2Score = player2Score
        self.board = board
        self.steps = steps
        self.player1Turn = player1Turn
        self.player2Turn = player2Turn
    }
}
