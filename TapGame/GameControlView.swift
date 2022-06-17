//
//  GameControlView.swift
//  TapGame
//
//  Created by Василий Буланов on 17.06.2022.
//

import Foundation
import UIKit

@IBDesignable
class GameControlView: UIView {
    private let timeLabel = UILabel()
    private let stepper = UIStepper()
    private let actionButton = UIButton()
    
    private let timeToStepperMargin: CGFloat = 8
    
    override var intrinsicContentSize: CGSize {
        let stepperSize = stepper.intrinsicContentSize
        let timeLabelSize = timeLabel.intrinsicContentSize
        let buttonSize = actionButton.intrinsicContentSize
        
        let width = timeLabelSize.width + timeToStepperMargin + stepperSize.width
        let height = stepperSize.height + actionButtonTopMargin + buttonSize.height
        
        return CGSize(width: width, height: height)
    }
    
    @IBInspectable var gameTimeLeft: Double = 7 {
        didSet {
            updateUI()
        }
    }
    @IBInspectable var isGameActive = false {
        didSet {
            updateUI()
        }
    }
    @IBInspectable var gameDuration: Double {
        get {
            return stepper.value
        }
        
        set {
            stepper.value = newValue
            updateUI()
        }
    }
    
    var startStopHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(timeLabel)
        addSubview(stepper)
        addSubview(actionButton)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = true
        stepper.translatesAutoresizingMaskIntoConstraints = true
        actionButton.translatesAutoresizingMaskIntoConstraints = true
        
        stepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        updateUI()
        
        actionButton.setTitleColor(actionButton.tintColor, for: .normal)
    }
    
    private let actionButtonTopMargin: CGFloat = 8
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let stepperSize = stepper.intrinsicContentSize
        stepper.frame = CGRect(
            origin: CGPoint(x: bounds.maxX - stepperSize.width, y: bounds.minY),
            size: stepperSize)
        let timeLabelSize = timeLabel.intrinsicContentSize
        timeLabel.frame = CGRect(
            origin: CGPoint(x: bounds.minX, y: bounds.minY + (stepperSize.height - timeLabelSize.height) / 2),
            size: timeLabelSize)
        let buttonSize = actionButton.intrinsicContentSize
        actionButton.frame = CGRect(
            origin: CGPoint(x: bounds.minX + (bounds.width - buttonSize.width) / 2, y: stepper.frame.maxY + actionButtonTopMargin),
            size: buttonSize)
    }
    
    @objc func stepperChanged() {
        updateUI()
    }
    
    @objc func actionButtonTapped() {
        startStopHandler?()
    }
    
    private func updateUI() {
        stepper.isEnabled = !isGameActive
        if isGameActive {
            actionButton.setTitle("Остановить", for: .normal)
            timeLabel.text = "Осталось \(Int(gameTimeLeft)) сек"
        } else {
            actionButton.setTitle("Начать", for: .normal)
            timeLabel.text = "Время \(Int(stepper.value)) сек"
        }
        setNeedsLayout()
    }
    
}

