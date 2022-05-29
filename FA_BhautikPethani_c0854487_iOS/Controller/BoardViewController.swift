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
    
    var player1 = true
    var player2 = false
    
    var board = [[0,0,0],[0,0,0],[0,0,0]]
    var counter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        turnChangeBackgroundColor()
        // Do any additional setup after loading the view.
    }
    
    func turnChangeBackgroundColor(){
        if(counter % 2 == 1){
            player1Img.backgroundColor = UIColor(red: 0.875, green: 0.800, blue: 0.902, alpha: 1.0);
            player2Img.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0);
        }else{
            player2Img.backgroundColor = UIColor(red: 0.706, green: 0.753, blue: 0.961, alpha: 1.0);
            player1Img.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0);
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
        
        player1 = !player1
        player2 = !player2
        sender.isUserInteractionEnabled = false
        counter+=1
        
        turnChangeBackgroundColor()
    }
    
}
