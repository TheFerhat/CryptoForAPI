//
//  CryptoTableViewCell.swift
//  CryptoApp
//
//  Created by Ferhat Ayar on 15.03.2024.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    @IBOutlet weak var cryptoImageView: UIImageView!
    @IBOutlet weak var cryptoSymbol: UILabel!
    @IBOutlet weak var cryptoPrice: UILabel!
    @IBOutlet weak var cryptoPriceChance: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
