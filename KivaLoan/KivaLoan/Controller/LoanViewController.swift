//
//  ViewController.swift
//  KivaLoan
//
//  Created by olivier geiger on 27/04/2024.
//

import UIKit

class LoanViewController: UITableViewController {
    
    // MARK: enum
    enum Section {
        case all
    }
    
    // MARK: - Properties
    var loans = [Loan]()
    lazy var dataSource = configureDataSource()
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        style()
        tableView.dataSource = dataSource
        fetchLoans()
    }
}

// MARK: - Helpers
extension LoanViewController {
    private func fetchLoans() {
        LoanManager.shared.getLatestLoans { [weak self] loans in
            guard let self = self, let loans = loans else { return }
            self.loans = loans
            DispatchQueue.main.async {
                self.updateSnapshot(animatingChange: true)   
            }
        }
    }
    
    private func style() {
        title = "Latest Loans"
        
        tableView.estimatedRowHeight = 92.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(LoanTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Loan> {
        
        let dataSource = UITableViewDiffableDataSource<Section, Loan>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, loan in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LoanTableViewCell
                cell.titleLabel.text = loan.name
                cell.countryLabel.text = loan.country
                cell.useLabel.text = loan.use
                cell.amountLabel.text = "$\(loan.amount)"
                return cell
            }
        )
        
        return dataSource
    }
    
    func updateSnapshot(animatingChange: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Loan>()
        snapshot.appendSections([.all])
        snapshot.appendItems(loans, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: animatingChange)
    }
}
