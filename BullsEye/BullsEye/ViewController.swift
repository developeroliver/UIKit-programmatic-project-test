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
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Put the Bull's Eye as close as you can to: "
        label.textColor = .white
        return label
    }()
    
    lazy var goalLabel: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.textColor = .white
        return label
    }()
    
    lazy var leadingSliderLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .white
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
        label.textColor = .white
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
        button.setBackgroundImage(UIImage(named: "Button-Normal"), for: .normal)
        button.setBackgroundImage(UIImage(named: "Button-Highlighted"), for: .highlighted)
        button.setTitle("Hit Me", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    lazy var contentStartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "SmallButton"), for: .normal)
        return button
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "StartOverIcon"), for: .normal)
        return button
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score: "
        label.textColor = .white
        return label
    }()
    
    lazy var roundLabel: UILabel = {
        let label = UILabel()
        label.text = "Round: "
        label.textColor = .white
        return label
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            contentStartButton,
            scoreLabel,
            roundLabel
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
        setupSlider()
    }
}

// MARK: - @objc & Functions
extension ViewController {
    
    @objc func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
          title = "Perfect!"
          points += 100
        } else if difference < 5 {
          title = "You almost had it!"
          if difference == 1 {
            points += 50
          }
        } else if difference < 10 {
          title = "Pretty good!"
        } else {
          title = "Not even close..."
        }
        score += points
        let message = "You scored \(points) points"

        let alert = UIAlertController(
          title: title,
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
        print("ok")
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
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        contentStartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
    }
    
    private func setupSlider() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
        trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
        trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    private func layout() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(goalLabel)
        view.addSubview(sliderStackView)
        view.addSubview(showAlertButton)
        view.addSubview(contentStartButton)
        view.addSubview(startButton)
        view.addSubview(hStackView)
        
        startButton.layer.zPosition = 1
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalTo(view.snp.centerX)
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
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(38)
        }
        
        contentStartButton.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        
        startButton.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.top.equalTo(contentStartButton.snp.top).offset(5)
            make.bottom.equalTo(contentStartButton.snp.bottom).offset(-5)
            make.leading.equalTo(contentStartButton.snp.leading).offset(5)
            make.trailing.equalTo(contentStartButton.snp.trailing).offset(-5)
        }
        
        hStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.leading.equalTo(view.snp.leading).offset(80)
            make.trailing.equalTo(view.snp.trailing).offset(-80)
        }
    }
}



