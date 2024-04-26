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
    
    // MARK: - UI
    lazy var showAlertButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Hit me", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
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
}

// MARK: - Helpers
extension ViewController {
    
    private func setup() {
        view.backgroundColor = .systemBackground
        
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubview(showAlertButton)
        showAlertButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

