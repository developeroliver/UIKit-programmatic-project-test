//
//  ViewController.swift
//  BullsEye
//
//  Created by olivier geiger on 26/04/2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    // MARK: - UI
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Put the Bull's Eye as close as you can to: "
        return label
    }()
    
    lazy var goalLabel: UILabel = {
        let label = UILabel()
        label.text = "100"
        return label
    }()
    
    lazy var leadingSliderLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        return label
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.value = 60
        return slider
    }()
    
    lazy var trailingSliderLabel: UILabel = {
        let label = UILabel()
        label.text = "100"
        return label
    }()
    
    private lazy var sliderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            leadingSliderLabel,
            slider,
            trailingSliderLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = 18
        return stackView
    }()
    
    lazy var showAlertButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Hit me", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Start Over", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score: "
        return label
    }()
    
    lazy var roundLabel: UILabel = {
        let label = UILabel()
        label.text = "Round: "
        return label
    }()
    
    lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            startButton,
            scoreLabel,
            roundLabel,
            infoImageView
        ])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    }()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        setup()
        layout()
    }
}

// MARK: - @objc & Functions
extension ViewController {
    
    @objc func showAlert() {
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        score += points
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(
            title: "Hello world",
            message: message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: "OK",
            style: .default) {_ in 
                self.startNewRound()
            }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        currentValue = lround(Double(slider.value))
    }
    
    @objc func restartGame() {
        score = 0
        round = 0
        startNewRound()
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels() {
        goalLabel.text = "\(targetValue)"
        scoreLabel.text = "Score: \(score)"
        roundLabel.text = "Round: \(round)"
    }
}

// MARK: - Helpers
extension ViewController {
    
    private func setup() {
        view.backgroundColor = .systemBackground
        
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(goalLabel)
        view.addSubview(sliderStackView)
        view.addSubview(showAlertButton)
        view.addSubview(infoImageView)
        view.addSubview(hStackView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        goalLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
        }
        
        sliderStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(100)
            make.leading.equalTo(view.snp.leading).offset(80)
            make.trailing.equalTo(view.snp.trailing).offset(-80)
        }
        
        showAlertButton.snp.makeConstraints { make in
            make.top.equalTo(sliderStackView.snp.bottom).offset(50)
            make.leading.equalTo(view.snp.leading).offset(80)
            make.trailing.equalTo(view.snp.trailing).offset(-80)
        }
        
        infoImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
        
        hStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.leading.equalTo(view.snp.leading).offset(80)
            make.trailing.equalTo(view.snp.trailing).offset(-80)
        }
    }
}

