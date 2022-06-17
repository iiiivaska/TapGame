//
//  ViewController.swift
//  TapGame
//
//  Created by Василий Буланов on 01.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameFieldView: GameFieldView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameControl: GameControlView!
    
    private var gameTimer: Timer?
    private var objectMovingTime: TimeInterval = 2
    private var objectTimer: Timer?
    private var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.cornerRadius = 5
        updateUI()
        gameFieldView.shapeHitHandler = { [weak self] in
            self?.objectTapped()
        }
        gameControl.startStopHandler = { [weak self] in
            self?.startButtonTapped()
        }
        gameControl.gameDuration = 20
    }

    func startButtonTapped() {
        if gameControl.isGameActive {
            stopGame()
        } else {
            startGame()
        }
    }
    
    func objectTapped() {
        if gameControl.isGameActive {
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
        gameControl.gameTimeLeft = gameControl.gameDuration
        gameControl.isGameActive = true
        updateUI()
    }
    
    private func stopGame() {
        gameControl.isGameActive = false
        updateUI()
        gameTimer?.invalidate()
        objectTimer?.invalidate()
        scoreLabel.text = "Последний счет: \(score)"
    }
    
    private func updateUI() {
        gameFieldView.isShapeHidden = !gameControl.isGameActive
        
    }
    
    @objc private func timeTick() {
        if gameControl.gameTimeLeft <= 0 {
            stopGame()
        } else {
            gameControl.gameTimeLeft -= 1
            updateUI()
        }
    }
    
    @objc private func moveGameObject() {
        gameFieldView.randomizeShape()
    }
}

