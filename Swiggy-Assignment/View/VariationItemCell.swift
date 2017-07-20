//
//  VariationItemCell.swift
//  Swiggy-Assignment
//
//  Created by Pavan Goyal on 19/07/17.
//  Copyright © 2017 Pavan Goyal. All rights reserved.
//

import UIKit

class VariationItemCell: UITableViewCell {

    @IBOutlet weak var variationItemName: UILabel!
    @IBOutlet weak var radioButtonImageView: UIImageView!
    
    let radioNotSelected = "radio_not_selected"
    let radioSelected = "radio_selected"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func updateVariationItemCell(with variation: Variation, isSelected: Bool) {
        self.variationItemName.text = variation.name ?? ""
        isSelected ? (self.radioButtonImageView.image = UIImage(named: radioSelected)) : (self.radioButtonImageView.image = UIImage(named: radioNotSelected))
    }

    static func height() -> CGFloat {
        return CGFloat(44)
    }
    
    func disableCell() {
        self.isUserInteractionEnabled = false
        self.contentView.isUserInteractionEnabled = false
        self.alpha = 0.9
        self.contentView.alpha = 0.9
    }
    
    func enableCell() {
        self.isUserInteractionEnabled = true
        self.isUserInteractionEnabled = true
        self.alpha = 1.0
        self.contentView.alpha = 1.0
    }
    
}
