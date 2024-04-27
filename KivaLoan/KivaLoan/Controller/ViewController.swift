//
//  ViewController.swift
//  KivaLoan
//
//  Created by olivier geiger on 27/04/2024.
//

import UIKit

class ViewController: UITableViewController {
    
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
extension ViewController {
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
        title = ""
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.estimatedRowHeight = 92.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Loan> {
        
        let dataSource = UITableViewDiffableDataSource<Section, Loan>(
            tableView: tableView,
            cellProvider: { [self]  tableView, indexPath, loan in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                let loan = loans[indexPath.row]
                cell.textLabel?.text = loan.name
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
