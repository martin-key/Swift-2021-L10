//
//  CoinDetailsTableViewController.swift
//  ExamPreparation
//
//  Created by Martin Kuvandzhiev on 27.10.21.
//

import UIKit

class CoinDetailsTableViewController: UITableViewController {

    @IBOutlet weak var nameDataLabel: UILabel!
    @IBOutlet weak var priceDataLabel: UILabel!
    @IBOutlet weak var marketCapDataLabel: UILabel!
    @IBOutlet weak var marketCapRankDataLabel: UILabel!
    @IBOutlet weak var symbolDataLabel: UILabel!
    @IBOutlet weak var totalVolumeDataLabel: UILabel!
    @IBOutlet weak var H24DataLabel: UILabel!
    @IBOutlet weak var L24DataLabel: UILabel!
    @IBOutlet weak var priceChangeDataLabel: UILabel!
    @IBOutlet weak var priceChangePercentageDataLabel: UILabel!
    @IBOutlet weak var circulatingSupplyDataLabel: UILabel!
    @IBOutlet weak var totalSupplyDataLabel: UILabel!
    
    var coin: Coin? {
        didSet {
            self.setupViewControllerData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setupViewControllerData() {
        guard let coin = self.coin else {
            return
        }
        
        self.loadViewIfNeeded()
        
        self.nameDataLabel.text = coin.name
        self.priceDataLabel.text = String(format: "$%0.2f", coin.current_price)
        self.marketCapDataLabel.text = coin.market_cap.formattedAsCurrency
        self.marketCapRankDataLabel.text = coin.market_cap_rank.description
        self.symbolDataLabel.text = coin.symbol
        self.totalVolumeDataLabel.text = coin.total_volume.formattedAsCurrency
        self.H24DataLabel.text = String(format: "$%0.2f",coin.high_24h)
        self.L24DataLabel.text = String(format: "$%0.2f",coin.low_24h)
        self.priceChangeDataLabel.text = String(format: "$%0.2f",coin.price_change_24h)
        self.priceChangePercentageDataLabel.text = String(format: "%0.2f",coin.price_change_percentage_24h)
        self.circulatingSupplyDataLabel.text = coin.circulating_supply.description
        self.totalSupplyDataLabel.text = coin.total_supply?.description ?? "-"
    }
}
