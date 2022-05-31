//
//  ResultViewController.swift
//  FA_BhautikPethani_c0854487_iOS
//
//  Created by Bhautik Pethani on 2022-05-30.
//

import UIKit

class ResultViewController: UIViewController {

    var gameState: GameState? = nil
    var winnerBackground: UIColor? = nil
    var winner: Int? = nil
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var winnerImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isModalInPresentation = true
        
        popUpView.backgroundColor = winnerBackground
        if winner == 1{
            winnerImg.image = UIImage(named: "Player1Win")
        }else if winner == 2{
            winnerImg.image = UIImage(named: "Player2Win")
        }else{
            winnerImg.image = UIImage(named: "draw")
        }
            
        
    }
    @IBAction func newGame(_ sender: Any) {
        performSegue(withIdentifier: "newGame", sender: self)
    }
    
    @IBAction func home(_ sender: Any) {
        performSegue(withIdentifier: "home", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newGame"{
            let bvc = segue.destination as? BoardViewController
            bvc?.gameState = gameState
        }else if segue.identifier == "home"{
            _ = segue.destination as? ViewController
        }
    }
}
