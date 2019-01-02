//
//  ViewController.swift
//  Bout Time
//
//  Created by Stephen McMillan on 29/12/2018.
//  Copyright © 2018 Stephen McMillan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum NextRoundButtonSate: String {
        case success = "next_round_success"
        case failure = "next_round_fail"
        case playAgain = "play_again"
    }
    
    @IBOutlet var eventLabels: [UILabel]!
    @IBOutlet var eventViews: [UIView]!
    
    // Arrow / Shift Buttons
    @IBOutlet weak var firstPositionArrow: UIButton!
    @IBOutlet weak var secondPositionUpArrow: UIButton!
    @IBOutlet weak var secondPositionDownArrow: UIButton!
    @IBOutlet weak var thirdPositionUpArrow: UIButton!
    @IBOutlet weak var thirdPositionDownArrow: UIButton!
    @IBOutlet weak var fourthPositionArrow: UIButton!
    
    // Additional Outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var nextRoundButton: UIButton!
    
    @IBOutlet weak var eventContainer: UIStackView!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var scoreDescriptionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var gameManager: ChronoGameManager
    
    // Timer
    var gameTimer: Timer?
    var timeRemaining: Int = 60
    
    var webURL: String = ""
    
    // MARK: - Setup
    required init?(coder aDecoder: NSCoder) {
        gameManager = AviationChronoGame(numberOfRounds: 6)!
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
    }
    
    func setup() {
        updateDisplay()
        displayGameOverState(false)
        updateNextRoundButton(hidden: true)
        configureTimer()
    }
    
    // MARK: - Countdown Timer
    
    func configureTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        timeRemaining = 11 // 1 higher than time allowed otherwise the highest time never displays.. weird.
        gameTimer?.fire()
    }
    
    @objc func timerFired() {
        // Called every 1s
        timeRemaining -= 1
        timerLabel.text = (timeRemaining < 10 ? "0:0\(timeRemaining)" : "0:\(timeRemaining)")
        
        if timeRemaining == 0 {
            nextRound()
        }
    }
    
    // MARK: - Display Methods
    func updateDisplay() {
        for (index, event) in gameManager.eventsInPlay.enumerated() {
            eventLabels[index].text = event.description
            print("[\(index)] \(event.description) /n")
        }
    }
    
    func updateNextRoundButton(hidden: Bool, withState state: NextRoundButtonSate = .success ) {
        nextRoundButton.isHidden = hidden
        promptLabel.text = (hidden ? "Shake to complete" : "Tap events to learn more")
        nextRoundButton.setBackgroundImage(UIImage(named: state.rawValue), for: .normal)
    }
    
    func displayGameOverState(_ gameOverState: Bool) {
            eventContainer.isHidden = gameOverState
            promptLabel.isHidden = gameOverState
            nextRoundButton.isHidden = gameOverState
            timerLabel.isHidden = gameOverState
        
            scoreDescriptionLabel.isHidden = !gameOverState
            scoreLabel.isHidden = !gameOverState
            scoreLabel.text = "\(gameManager.score)/\(gameManager.maxRounds)"
            playAgainButton.isHidden = !gameOverState
    }

    // MARK - Button Actions
    @IBAction func shiftItemPressed(_ sender: UIButton) {
        
        var shiftInstructions: (EventPosition, Direction) = (.first, .down)
        
        switch sender {
        case firstPositionArrow: shiftInstructions = (.first, .down)
        case secondPositionUpArrow: shiftInstructions = (.second, .up)
        case secondPositionDownArrow: shiftInstructions = (.second, .down)
        case thirdPositionUpArrow: shiftInstructions = (.third, .up)
        case thirdPositionDownArrow: shiftInstructions = (.third, .down)
        case fourthPositionArrow: shiftInstructions = (.fourth, .up)
            
        default:
            break
        }
        gameManager.shiftEvent(atPosition: shiftInstructions.0, inDirection: shiftInstructions.1)
        updateDisplay()
    }
    
    @IBAction func nextRoundPressed() {
        
        if gameManager.nextRound() {
            updateDisplay()
            updateNextRoundButton(hidden: true)
            configureTimer()
        } else {
            displayGameOverState(true)
        }
    }
    
    @IBAction func playAgainPressed() {
        gameManager = AviationChronoGame(numberOfRounds: 6)!
        setup()
    }
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        if gameTimer?.isValid ?? false {
            return // Stops the web view showing mid-game.
        }
        
        guard let parentViewOfTapGesture = sender.view else {
            return
        }
        
        webURL = ""
        switch parentViewOfTapGesture {
        case eventViews[0]:
            webURL = gameManager.eventsInPlay[0].infoURL
        case eventViews[1]:
            webURL = gameManager.eventsInPlay[1].infoURL
        case eventViews[2]:
            webURL = gameManager.eventsInPlay[2].infoURL
        case eventViews[3]:
            webURL = gameManager.eventsInPlay[3].infoURL
        default:
            break
        }
        
        performSegue(withIdentifier: "showInfo", sender: nil)
    }
    

    // MARK: - Shakey Shake
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        nextRound()
    }
    
    // MARK: - Next Round
    func nextRound() {
        gameTimer?.invalidate()
        guard nextRoundButton.isHidden else { return }
        
        let result = gameManager.checkOrder()
        updateNextRoundButton(hidden: false, withState: result ? .success : .failure)
    }
    
    // MARK: - Show Info view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WebDetailViewController {
            destination.urlString = webURL
        }
    }
}

