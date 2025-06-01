//
//  PreferenceTableViewCell.swift
//  
//
//  Created by Faraz Rasheed on 11/10/2020.
//

import UIKit

class SpotifyTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var dateLabel:UILabel!
    
    @IBOutlet var investLabel:UILabel!
    @IBOutlet var priceLabel:UILabel!
    @IBOutlet var currentLabel:UILabel!
    @IBOutlet var plLabel:UILabel!
    
    @IBOutlet var selectedButton:UIButton!
    @IBOutlet var stockImageView:UIImageView!
    @IBOutlet var stockSeenImageView:UIImageView!

    
    var detailSuccessCallBack:((_ index: IndexPath)->Void)?
    var detailSelectCallBack:((_ index: IndexPath)->Void)?

    var index: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectButtonTapped(_ sender: Any) {
        if let callBack = self.detailSelectCallBack {
            callBack(index)
        }
    }
    
    @IBAction func detailButtonTapped(_ sender: Any) {
        if let callBack = self.detailSuccessCallBack {
            callBack(index)
        }
    }
}
