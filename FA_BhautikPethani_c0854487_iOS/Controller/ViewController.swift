//
//  ViewController.swift
//  FA_BhautikPethani_c0854487_iOS
//
//  Created by Bhautik Pethani on 2022-05-27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var continueBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        continueBtn.isHidden = true
    }
    
    @IBAction func newGame(_ sender: Any) {
        performSegue(withIdentifier: "boardView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as? BoardViewController
    }
    
}

