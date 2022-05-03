//
//  DisplayTableViewCell.swift
//  WebsockedDemo
//
//  Created by 翁燮羽 on 2022/5/3.
//

import UIKit

class DisplayTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func myConvertCell(time: String, price: String, quantity: String) {
        timeLabel.text = time
        priceLabel.text = price
        quantityLabel.text = quantity
    }
    
}
