//
//  BoardViewController.swift
//  FA_BhautikPethani_c0854487_iOS
//
//  Created by Bhautik Pethani on 2022-05-28.
//

import UIKit
import AVFoundation
import CoreData

class BoardViewController: UIViewController {

    @IBOutlet weak var player2ScoreLabel: UILabel!
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player1Img: UIImageView!
    @IBOutlet weak var player2Img: UIImageView!
    @IBOutlet weak var audioBtn: UIButton!
    @IBOutlet var boardBox: [UIButton]!
    
    var player1WinColor = UIColor(red: 1.000, green: 0.228, blue: 0.599, alpha: 1.0)
    var player2WinColor = UIColor(red: 0.078, green: 0.067, blue: 1.000, alpha: 0.7)
    
    var boardColor1 = UIColor(red: 0.875, green: 0.800, blue: 0.902, alpha: 1.0)
    var boardColor2 = UIColor(red: 0.706, green: 0.753, blue: 0.961, alpha: 1.0)
    
    var audioPlayer = AVAudioPlayer()
    var audioFile = Bundle.main.path(forResource: "background_music", ofType: "mp3")
    
    var gameState:GameState? = nil;
    var lastPosition: [Any] = [];
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        managedContext = appDelegate.persistentContainer.viewContext
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioFile!))
        } catch{
            print(error)
        }
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        if(gameState != nil){
            setCurrentStateInTheView()
        }else{
            gameState = GameState(player1Score: 0, player2Score: 0, board: [[0,0,0],[0,0,0],[0,0,0]], steps: 1, player1Turn: false, player2Turn: true, gameOver: false)
            turnChange()
            saveState()
        }
        resetBoardBackground()
    }
    
    func setCurrentStateInTheView(){
        player1ScoreLabel.text = "Player 1 : " + String(gameState!.player1Score);
        player2ScoreLabel.text = "Player 2 : " + String(gameState!.player2Score);
        
        if gameState!.gameOver{
            lastPosition = []
            gameState!.board = [[0,0,0],[0,0,0],[0,0,0]]
            gameState!.steps = 1
            gameState!.player1Turn = false
            gameState!.player2Turn = true
            gameState!.gameOver = false
            turnChange()
            saveState()
        }
        
        var counter = 0
        for i in 0...2{
            for j in 0...2{
                if gameState!.board[i][j] == 1{
                    boardBox[counter].isUserInteractionEnabled = false
                    boardBox[counter].setBackgroundImage(UIImage(named: "cross"), for: .normal)
                }else if gameState!.board[i][j] == 2{
                    boardBox[counter].isUserInteractionEnabled = false
                    boardBox[counter].setBackgroundImage(UIImage(named: "noughtSign"), for: .normal)
                }else{
                    boardBox[counter].isUserInteractionEnabled = true
                    boardBox[counter].setBackgroundImage(UIImage(named: ""), for: .normal)
                }
                counter+=1
            }
        }
    }
    
    func saveState() {
        clearState()
        let stateEntity = NSEntityDescription.insertNewObject(forEntityName: "GameStateDB", into: managedContext)
        stateEntity.setValue(gameState!.board, forKey: "board")
        stateEntity.setValue(gameState!.player1Score, forKey: "player1Score")
        stateEntity.setValue(gameState!.player1Turn, forKey: "player1Turn")
        stateEntity.setValue(gameState!.player2Score, forKey: "player2Score")
        stateEntity.setValue(gameState!.player2Turn, forKey: "player2Turn")
        stateEntity.setValue(gameState!.steps, forKey: "steps")
        stateEntity.setValue(gameState!.gameOver, forKey: "gameOver")
        
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    func clearState() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameStateDB")
        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results {
                if let managedObject = result as? NSManagedObject {
                    managedContext.delete(managedObject)
                }
            }
        } catch {
            print("Error deleting records \(error)")
        }
    }
    
    func changeAudioState(){
        if(audioPlayer.isPlaying){
            audioPlayer.stop()
            audioBtn.setBackgroundImage(UIImage(named: "music"), for: .normal)
        }else{
            audioPlayer.play()
            audioBtn.setBackgroundImage(UIImage(named: "noMusic"), for: .normal)
        }
    }
    
    func turnChange(){
        gameState!.player1Turn = !gameState!.player1Turn
        gameState!.player2Turn = !gameState!.player2Turn
        if(gameState!.steps % 2 == 1){
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
                gameState!.board[0][0] = (gameState!.player1Turn) ? 1 : 2
                lastPosition = [0, 0, sender]
                break
            case boardBox[1]:
                gameState!.board[0][1] = (gameState!.player1Turn) ? 1 : 2
                lastPosition = [0, 1, sender]
                break
            case boardBox[2]:
                gameState!.board[0][2] = (gameState!.player1Turn) ? 1 : 2
                lastPosition = [0, 2, sender]
                break
            case boardBox[3]:
                gameState!.board[1][0] = (gameState!.player1Turn) ? 1 : 2
                lastPosition = [1, 0, sender]
                break
            case boardBox[4]:
                gameState!.board[1][1] = (gameState!.player1Turn) ? 1 : 2
                lastPosition = [1, 1, sender]
                break
            case boardBox[5]:
                gameState!.board[1][2] = (gameState!.player1Turn) ? 1 : 2
                lastPosition = [1, 2, sender]
                break
            case boardBox[6]:
                gameState!.board[2][0] = (gameState!.player1Turn) ? 1 : 2
                lastPosition = [2, 0, sender]
                break
            case boardBox[7]:
                gameState!.board[2][1] = (gameState!.player1Turn) ? 1 : 2
                lastPosition = [2, 1, sender]
                break
            case boardBox[8]:
                gameState!.board[2][2] = (gameState!.player1Turn) ? 1 : 2
                lastPosition = [2, 2, sender]
                break
            default:
                break
        }
        
        (gameState!.player1Turn) ? sender.setBackgroundImage(UIImage(named: "cross"), for: .normal) : sender.setBackgroundImage(UIImage(named: "noughtSign"), for: .normal)
        
        
        if(gameState!.steps>=5){
            if(checkResult()){
                gameState!.gameOver = true
                (gameState!.player1Turn) ? (gameState!.player1Score+=1) : (gameState!.player2Score+=1)
                disableAllButtons()
            }
        }
        
        sender.isUserInteractionEnabled = false
        gameState!.steps+=1
        turnChange()
        
        saveState()
    }
    
    func changeWinColor(button: [Int], boxColor: UIColor){
        boardBox[button[0]].backgroundColor = boxColor;
        boardBox[button[1]].backgroundColor = boxColor;
        boardBox[button[2]].backgroundColor = boxColor;
    }
    
    func checkResult() -> Bool{
        if(gameState!.board[0][0] == gameState!.board[0][1] && gameState!.board[0][1] == gameState!.board[0][2] && gameState!.board[0][0] != 0){
            changeWinColor(button: [0,1,2], boxColor: (gameState!.board[0][0] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        else if(gameState!.board[1][0] == gameState!.board[1][1] && gameState!.board[1][1] == gameState!.board[1][2] && gameState!.board[1][0] != 0){
            changeWinColor(button: [3,4,5], boxColor: (gameState!.board[1][0] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        else if(gameState!.board[2][0] == gameState!.board[2][1] && gameState!.board[2][1] == gameState!.board[2][2] && gameState!.board[2][0] != 0){
            changeWinColor(button: [6,7,8], boxColor: (gameState!.board[2][0] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        else if(gameState!.board[0][0] == gameState!.board[1][0] && gameState!.board[1][0] == gameState!.board[2][0] && gameState!.board[0][0] != 0){
            changeWinColor(button: [0,3,6], boxColor: (gameState!.board[0][0] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        else if(gameState!.board[0][1] == gameState!.board[1][1] && gameState!.board[1][1] == gameState!.board[2][1] && gameState!.board[0][1] != 0){
            changeWinColor(button: [1,4,7], boxColor: (gameState!.board[0][1] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        else if(gameState!.board[0][2] == gameState!.board[1][2] && gameState!.board[1][2] == gameState!.board[2][2] && gameState!.board[0][2] != 0){
            changeWinColor(button: [2,5,8], boxColor: (gameState!.board[0][2] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        else if(gameState!.board[0][0] == gameState!.board[1][1] && gameState!.board[1][1] == gameState!.board[2][2] && gameState!.board[0][0] != 0){
            changeWinColor(button: [0,4,8], boxColor: (gameState!.board[0][0] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        else if(gameState!.board[0][2] == gameState!.board[1][1] && gameState!.board[1][1] == gameState!.board[2][0] && gameState!.board[0][2] != 0){
            changeWinColor(button: [2,4,6], boxColor: (gameState!.board[0][2] == 1) ? player1WinColor : player2WinColor)
            return true
        }
        return false
    }
    
    func resetBoardBackground(){
        for i in 0...8{
            if(i % 2 == 0){
                boardBox[i].backgroundColor = boardColor1
            }else{
                boardBox[i].backgroundColor = boardColor2
            }
        }
    }
    
    @IBAction func newGame(_ sender: Any) {
        gameState!.gameOver = true
        setCurrentStateInTheView()
        resetBoardBackground()
    }
    
    @IBAction func goBackToHome(_ sender: Any) {
        performSegue(withIdentifier: "home", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let hvc = segue.destination as? ViewController
    }
    
    @IBAction func audioStateChanged(_ sender: UIButton) {
        changeAudioState()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if (lastPosition as AnyObject).count == 3{
                if gameState!.steps != 0{
                    if !gameState!.gameOver{
                        gameState!.steps -= 1
                        gameState!.board[lastPosition[0] as! Int][lastPosition[1] as! Int] = 0;
                        (lastPosition[2] as! UIButton).setBackgroundImage(UIImage(named: ""), for: .normal)
                        (lastPosition[2] as! UIButton).isUserInteractionEnabled = true
                        turnChange()
                        saveState()
                    }
                }
            }
        }
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
            
        gameState!.gameOver = true
        setCurrentStateInTheView()
        resetBoardBackground()
    }
    
    func disableAllButtons(){
        for i in 0...8{
            boardBox[i].isUserInteractionEnabled = false
        }
    }
    
    func enableAllButtons(){
        for i in 0...8{
            boardBox[i].isUserInteractionEnabled = true
        }
    }
    
}
