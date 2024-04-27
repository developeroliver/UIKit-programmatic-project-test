//
//  ViewController.swift
//  We Split
//
//  Created by olivier geiger on 27/04/2024.
//

import UIKit

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    var segmentedArray = ["10%", "15%", "20%", "25%", "30%"]
    var amount: Double = 0.0
    var numberOfPeople: Int = 0
    
    
    // MARK: - UI Declarations
    lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Amount"
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    
    lazy var numberOfPeopleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Number of people"
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    lazy var segmentedLabel: UILabel = {
        let label = UILabel()
        label.text = "How much tip do you want to leave?"
        label.textColor = .secondaryLabel
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        return label
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: segmentedArray)
        segment.tintColor = .label
        
        return segment
    }()
    
    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total amount"
        label.textColor = .secondaryLabel
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        return label
    }()
    
    lazy var totalAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .label
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.layer.cornerRadius = 8
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount per person"
        label.textColor = .secondaryLabel
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        return label
    }()
    
    lazy var amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .label
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.layer.cornerRadius = 8
        return label
    }()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
        amountTextField.delegate = self
        numberOfPeopleTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        segmentedControl.addTarget(self, action: #selector(countSplit(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentedControl.alpha = 0
        segmentedLabel.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(-view.bounds.width)
        }
        totalLabel.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(-view.bounds.width)
        }
        totalAmountLabel.alpha = 0
        amountLabel.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(-view.bounds.width)
        }
        amountPerPersonLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, delay: 0.6, options: .curveEaseOut) {
            self.segmentedControl.alpha = 1.0
            self.totalAmountLabel.alpha = 1.0
            self.amountPerPersonLabel.alpha = 1.0
        }
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut) {
            self.segmentedLabel.snp.updateConstraints { make in
                make.leading.equalToSuperview().offset(20)
            }
            self.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.7, delay: 0.4, options: .curveEaseInOut) {
            self.totalLabel.snp.updateConstraints { make in
                make.leading.equalToSuperview().offset(20)
            }
            self.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.9, delay: 0.6, options: .curveEaseInOut) {
            self.amountLabel.snp.updateConstraints { make in
                make.leading.equalToSuperview().offset(20)
            }
            self.view.layoutIfNeeded()
        }   
    }
}

// MARK: - @objc Functions
extension ViewController {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func countSplit(_ sender: UISegmentedControl) {
        guard let amountText = amountTextField.text, let amount = Double(amountText) else {
            print("Veuillez entrer un montant valide.")
            return
        }
        
        guard let numberOfPeopleText = numberOfPeopleTextField.text, let numberOfPeople = Int(numberOfPeopleText) else {
            print("Veuillez entrer un nombre de personnes valide.")
            return
        }
        
        let selectedIndex = sender.selectedSegmentIndex
        guard let selectedAmountString = sender.titleForSegment(at: selectedIndex),
              let percentage = Double(selectedAmountString.dropLast()) else {
            print("Le montant sélectionné n'est pas valide.")
            return
        }
        
        let total = (amount * (1 + percentage / 100))
        let totalPerPerson = total / Double(numberOfPeople)
        
        totalAmountLabel.text = String(format: "$%.2f", total)
        amountPerPersonLabel.text = String(format: "$%.2f", totalPerPerson)
    }
}

// MARK: - Helpers
extension ViewController {
    
    private func setup() {
        view.backgroundColor = .secondarySystemGroupedBackground
        title = "WeSplit"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func layout() {
        view.addSubview(amountTextField)
        view.addSubview(dividerView)
        view.addSubview(numberOfPeopleTextField)
        view.addSubview(segmentedLabel)
        view.addSubview(segmentedControl)
        view.addSubview(totalLabel)
        view.addSubview(totalAmountLabel)
        view.addSubview(amountLabel)
        view.addSubview(amountPerPersonLabel)
        
        amountTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(160)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
        
        dividerView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(amountTextField.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        numberOfPeopleTextField.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.top).offset(1)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
        
        segmentedLabel.snp.makeConstraints { make in
            make.top.equalTo(numberOfPeopleTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(segmentedLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        totalAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(totalAmountLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        amountPerPersonLabel.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        amountTextField.endEditing(true)
        numberOfPeopleTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
