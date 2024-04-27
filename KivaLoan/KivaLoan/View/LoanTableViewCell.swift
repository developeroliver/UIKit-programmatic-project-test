//
//  LoanTableViewCell.swift
//  KivaLoan
//
//  Created by olivier geiger on 27/04/2024.
//

import UIKit
import SnapKit

class LoanTableViewCell: UITableViewCell {
    // MARK: - UI
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .label
        label.font =  UIFont(name: "AvenirNext-Medium", size: 20)
        return label
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .secondaryLabel
        label.font =  UIFont(name: "AvenirNext-Medium", size: 17)
        return label
    }()
    
    lazy var useLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .secondaryLabel
        label.font =  UIFont(name: "AvenirNext-Medium", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 4
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            countryLabel,
            useLabel
        ])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .label
        label.font =  UIFont(name: "AvenirNext-Medium", size: 29)
        return label
    }()
    
    //MARK: - LifeCycle Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension LoanTableViewCell {
    
    private func setup() {
        
    }
    
    private func layout() {
        addSubview(stackView)
        addSubview(amountLabel)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(250)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
