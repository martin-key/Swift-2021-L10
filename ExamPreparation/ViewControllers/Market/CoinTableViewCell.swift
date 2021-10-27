//
//  CoinTableViewCell.swift
//  ExamPreparation
//
//  Created by Martin Kuvandzhiev on 27.10.21.
//

import UIKit
import SDWebImage

class CoinTableViewCell: UITableViewCell {
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var percentChangeLabel: UILabel!
    
    var coin: Coin? {
        didSet {
            guard let coin = coin else {
                return
            }
            self.setupWith(coin: coin)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupWith(coin: Coin) {
        self.coinImageView.sd_setImage(with: URL(string: coin.image), completed: nil)
        self.nameLabel.text = coin.name
        self.marketCapLabel.text = coin.market_cap.formattedAsCurrency
        self.priceLabel.text = String(format: "$%0.2f", coin.current_price)
        self.percentChangeLabel.text = String(format: "%0.2f%%", coin.price_change_percentage_24h)
        self.percentChangeLabel.textColor = coin.price_change_24h > 0 ? .systemGreen : .systemRed
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
