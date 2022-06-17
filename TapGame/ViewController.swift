//
//  ViewController.swift
//  TapGame
//
//  Created by Василий Буланов on 01.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var shapeX: NSLayoutConstraint!
    @IBOutlet weak var shapeY: NSLayoutConstraint!
    @IBOutlet weak var gameObject: UIImageView!
    
    private var isGameActive = false
    private var gameTimeLeft: TimeInterval = 0
    private var gameTimer: Timer?
    private var objectMovingTime: TimeInterval = 2
    private var objectTimer: Timer?
    private var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.layer.borderWidth = 1
        gameView.layer.borderColor = UIColor.gray.cgColor
        gameView.layer.cornerRadius = 5
        updateUI()
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isGameActive {
            stopGame()
        } else {
            startGame()
        }
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        updateUI()
    }
    
    @IBAction func objectTapped(_ sender: UITapGestureRecognizer) {
        if isGameActive {
            repositionImageWithTimer()
            score += 1
        }
    }
    
    private func repositionImageWithTimer() {
        objectTimer?.invalidate()
        objectTimer = Timer.scheduledTimer(timeInterval: objectMovingTime, target: self, selector: #selector(moveGameObject), userInfo: nil, repeats: true)
        objectTimer?.fire()
    }
    
    private func startGame() {
        score = 0
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeTick), userInfo: nil, repeats: true)
        repositionImageWithTimer()
        gameTimeLeft = stepper.value
        isGameActive = true
        updateUI()
    }
    
    private func stopGame() {
        isGameActive = false
        updateUI()
        gameTimer?.invalidate()
        objectTimer?.invalidate()
        scoreLabel.text = "Последний счет: \(score)"
    }
    
    private func updateUI() {
        gameObject.isHidden = !isGameActive
        stepper.isEnabled = !isGameActive
        if isGameActive {
            startButton.setTitle("Остановить", for: .normal)
            timeLabel.text = "Осталось \(Int(gameTimeLeft)) сек"
        } else {
            startButton.setTitle("Начать", for: .normal)
            timeLabel.text = "Время \(Int(stepper.value)) сек"
        }
    }
    
    @objc private func timeTick() {
        if gameTimeLeft <= 0 {
            stopGame()
        } else {
            gameTimeLeft -= 1
            updateUI()
        }
    }
    
    @objc private func moveGameObject() {
        let maxX = gameView.bounds.maxX - gameObject.frame.width
        let maxY = gameView.bounds.maxY - gameObject.frame.height
        shapeX.constant = CGFloat(arc4random_uniform(UInt32(maxX)))
        shapeY.constant = CGFloat(arc4random_uniform(UInt32(maxY)))
    }
}

