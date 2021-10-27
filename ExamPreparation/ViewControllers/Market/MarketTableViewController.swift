//
//  MarketTableViewController.swift
//  ExamPreparation
//
//  Created by Martin Kuvandzhiev on 27.10.21.
//

import UIKit

class MarketTableViewController: UITableViewController {
    
    var marketData = [Coin]()
    var favorites = [Coin]()
    
    
    let searchController = UISearchController()
    var currentSearchString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController.searchResultsUpdater = self
        navigationItem.searchController = self.searchController
        
        NotificationCenter.default.addObserver(forName: .marketDataLoaded, object: nil, queue: nil) { _ in
            DispatchQueue.main.async {
                self.loadData(searchString: self.currentSearchString)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData(searchString: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let coinDetailsController = segue.destination as? CoinDetailsTableViewController,
           let coinCell = sender as? CoinTableViewCell,
           let coin = coinCell.coin {
            coinDetailsController.coin = coin
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.favorites.count
        case 1:
            return self.marketData.count
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoinTableViewCell", for: indexPath) as? CoinTableViewCell else {
            return UITableViewCell()
        }

        switch indexPath.section {
        case 0:
            cell.coin = self.favorites[indexPath.row]
        case 1:
            cell.coin = self.marketData[indexPath.row]
        default:
            break
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var coin = Coin()
        switch indexPath.section {
        case 0:
            coin = self.favorites[indexPath.row]
        case 1:
            coin = self.marketData[indexPath.row]
        default:
            break
        }
        
        let isFavorite = self.favorites.contains(coin)
        
        let favoriteSwipeAction = UIContextualAction(style: .normal, title: isFavorite ? "Unfavorite" : "Favorite") { _, _, completionHandler in
            switch isFavorite {
            case true:
                if let indexOfFavorite = LocalDataManager.favorites.favoriteCoins.index(of: coin.id) {
                    try? LocalDataManager.realm.write({
                        LocalDataManager.favorites.favoriteCoins.remove(at: indexOfFavorite)
                    })
                }
            case false:
                try? LocalDataManager.realm.write({
                    LocalDataManager.favorites.favoriteCoins.append(coin.id)
                })
            }
            self.loadData(searchString: self.currentSearchString)
            completionHandler(true)
        }
        
        favoriteSwipeAction.backgroundColor = .systemYellow
        return UISwipeActionsConfiguration(actions: [favoriteSwipeAction])
    }

    private func loadData(searchString: String?) {
        DispatchQueue.main.async {
            self.marketData = [Coin](LocalDataManager.realm.objects(Coin.self)
                                        .sorted(byKeyPath: "market_cap", ascending: false))
                .filter({ searchString == nil || $0.name.lowercased().contains(searchString?.lowercased() ?? "") })
            
            let favoriteCoins = LocalDataManager.favorites.favoriteCoins
            self.favorites = self.marketData.filter({ favoriteCoins.contains($0.id) })
        
            
            self.tableView.reloadData()
        }
    }
}

extension MarketTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        var searchText: String? = nil
        if let textInSearcBar = searchController.searchBar.text, textInSearcBar.isEmpty == false {
            searchText = textInSearcBar
        }
        currentSearchString = searchText
        self.loadData(searchString: self.currentSearchString)
    }
}
