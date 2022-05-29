//
//  BoardViewController.swift
//  FA_BhautikPethani_c0854487_iOS
//
//  Created by Bhautik Pethani on 2022-05-28.
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var player1Img: UIImageView!
    @IBOutlet weak var player2Img: UIImageView!
    
    @IBOutlet var boardBox: [UIButton]!
    
    var player1 = false
    var player2 = true
    
    var player1WinColor = UIColor(red: 1.000, green: 0.228, blue: 0.599, alpha: 1.0)
    var player2WinColor = UIColor(red: 0.078, green: 0.067, blue: 1.000, alpha: 0.7)
    
    var boardColor1 = UIColor(red: 0.875, green: 0.800, blue: 0.902, alpha: 1.0)
    var boardColor2 = UIColor(red: 0.706, green: 0.753, blue: 0.961, alpha: 1.0)
    
    var board = [[0,0,0],[0,0,0],[0,0,0]]
    var counter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        turnChange()
        resetBoard()
        // Do any additional setup after loading the view.
    }
    
    func turnChange(){
        player1 = !player1
        player2 = !player2
        if(counter % 2 == 1){
            player1Img.backgroundColor = boardColor1
            player2Img.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        }else{
            player2Img.backgroundColor = boardColor2
            player1Img.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        }
    }
    
    @IBAction func boardTapped(_ sender: UIButton) {
        switch(sender){
            case boardBox[0]:
                board[0][0] = (player1) ? 1 : 2
                break
            case boardBox[1]:
                board[0][1] = (player1) ? 1 : 2
                break
            case boardBox[2]:
                board[0][2] = (player1) ? 1 : 2
                break
            case boardBox[3]:
                board[1][0] = (player1) ? 1 : 2
                break
            case boardBox[4]:
                board[1][1] = (player1) ? 1 : 2
                break
            case boardBox[5]:
                board[1][2] = (player1) ? 1 : 2
                break
            case boardBox[6]:
                board[2][0] = (player1) ? 1 : 2
                break
            case boardBox[7]:
                board[2][1] = (player1) ? 1 : 2
                break
            case boardBox[8]:
                board[2][2] = (player1) ? 1 : 2
                break
            default:
                break
        }
        
        (player1) ? sender.setBackgroundImage(UIImage(named: "cross"), for: .normal) : sender.setBackgroundImage(UIImage(named: "noughtSign"), for: .normal)
        
        
        if(checkResult()){
            print ("Win");
            disableAllButtons()
        }
        
        sender.isUserInteractionEnabled = false
        counter+=1
        
        turnChange()
    }
    
    func changeWinColor(button: [Int], boxColor: UIColor){
        boardBox[button[0]].backgroundColor = boxColor;
        boardBox[button[1]].backgroundColor = boxColor;
        boardBox[button[2]].backgroundColor = boxColor;
    }
    
    func checkResult() -> Bool{
        if(board[0][0] == board[0][1] && board[0][1] == board[0][2] && board[0][0] != 0){
            changeWinColor(button: [0,1,2], boxColor: (board[0][0] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        else if(board[1][0] == board[1][1] && board[1][1] == board[1][2] && board[1][0] != 0){
            changeWinColor(button: [3,4,5], boxColor: (board[0][0] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        else if(board[2][0] == board[2][1] && board[2][1] == board[2][2] && board[2][0] != 0){
            changeWinColor(button: [6,7,8], boxColor: (board[0][0] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        else if(board[0][0] == board[1][0] && board[1][0] == board[2][0] && board[0][0] != 0){
            changeWinColor(button: [0,3,6], boxColor: (board[0][0] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        else if(board[0][1] == board[1][1] && board[1][1] == board[2][1] && board[0][1] != 0){
            changeWinColor(button: [1,4,7], boxColor: (board[0][0] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        else if(board[0][2] == board[1][2] && board[1][2] == board[2][2] && board[0][2] != 0){
            changeWinColor(button: [2,5,8], boxColor: (board[0][0] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        else if(board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != 0){
            changeWinColor(button: [0,4,8], boxColor: (board[0][0] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        else if(board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != 0){
            changeWinColor(button: [2,4,6], boxColor: (board[0][0] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        return false
    }
    
    func resetBoard(){
        for i in 0...8{
            if(i % 2 == 0){
                boardBox[i].backgroundColor = boardColor1
            }else{
                boardBox[i].backgroundColor = boardColor2
            }
        }
    }
    
    func disableAllButtons(){
        for i in 0...8{
            boardBox[i].isUserInteractionEnabled = false
        }
    }
    
}
