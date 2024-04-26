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
    var score = 1884
    var round = 999
    
    // MARK: - UI
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Put the Bull's Eye as close as you can to: "
        return label
    }()
    
    lazy var goalLabel: UILabel = {
        let label = UILabel()
        label.text = "25"
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
        slider.value = 50
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
    
    lazy var startLabel: UILabel = {
        let label = UILabel()
        label.text = "Start Over"
        return label
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
            startLabel,
            scoreLabel,
            roundLabel,
            infoImageView
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
}

// MARK: - @objc Functions
extension ViewController {
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "Fonctionnalité non disponible", message: "Cette fonctionnalité n'est pas encore disponible.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
           print("Nouvelle valeur du slider : \(sender.value)")
       }
}

// MARK: - Helpers
extension ViewController {
    
    private func setup() {
        view.backgroundColor = .systemBackground
        
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        scoreLabel.text = "Score: \(score)"
        roundLabel.text = "Round: \(round)"
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(sliderStackView)
        view.addSubview(showAlertButton)
        view.addSubview(infoImageView)
        view.addSubview(hStackView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
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

