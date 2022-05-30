//
//  ViewController.swift
//  FA_BhautikPethani_c0854487_iOS
//
//  Created by Bhautik Pethani on 2022-05-27.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var continueBtn: UIButton!
    
    var gameState:GameState? = nil;
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        managedContext = appDelegate.persistentContainer.viewContext
        
        if(checkState()){
            continueBtn.isHidden = false
        }else{
            continueBtn.isHidden = true
        }
        
    }
    
    func checkState() -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameStateDB")
        do {
            let results = try managedContext.fetch(fetchRequest)
            if results is [NSManagedObject] {
                for result in (results as! [NSManagedObject]) {
                    let player1Score = result.value(forKey: "player1Score") as! Int
                    let player2Score = result.value(forKey: "player2Score") as! Int
                    let board = result.value(forKey: "board") as! [[Int]]
                    let steps = result.value(forKey: "steps") as! Int
                    let player1Turn = result.value(forKey: "player1turn") as! Bool
                    let player2Turn = result.value(forKey: "player1turn") as! Bool
                    
                    gameState = GameState(player1Score: player1Score, player2Score: player2Score, board: board, steps: steps, player1Turn: player1Turn, player2Turn: player2Turn)
                    
                    return true
                }
            }
            return false
        } catch {
            print(error)
        }
        return false
    }
    
    @IBAction func newGame(_ sender: Any) {
        performSegue(withIdentifier: "boardView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as? BoardViewController
    }
    
}

