//
//  ViewController.swift
//  Bout Time
//
//  Created by Stephen McMillan on 29/12/2018.
//  Copyright © 2018 Stephen McMillan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Event Labels
    @IBOutlet weak var firstPositionLabel: UILabel!
    @IBOutlet weak var secondPositionLabel: UILabel!
    @IBOutlet weak var thirdPositionLabel: UILabel!
    @IBOutlet weak var fourthPositionLabel: UILabel!
    
    // Arrow / Shift Buttons
    @IBOutlet weak var firstPositionArrow: UIButton!
    
    @IBOutlet weak var secondPositionUpArrow: UIButton!
    @IBOutlet weak var secondPositionDownArrow: UIButton!
    
    @IBOutlet weak var thirdPositionUpArrow: UIButton!
    @IBOutlet weak var thirdPositionDownArrow: UIButton!
    
    @IBOutlet weak var fourthPositionArrow: UIButton!
    
    // Additional Labels
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func shiftItemPressed(_ sender: UIButton) {
        switch sender {
        case firstPositionArrow:
            print("FIRST ARROW PRESSED.")
            
        default: print("Im so lazy lol")
            
            
            
            
        }
        
    }
    

}

