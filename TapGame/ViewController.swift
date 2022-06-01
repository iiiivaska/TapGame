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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.layer.borderWidth = 1
        gameView.layer.borderColor = UIColor.gray.cgColor
        gameView.layer.cornerRadius = 5
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        timeLabel.text = "Время: \(sender.value) сек"
    }
}

