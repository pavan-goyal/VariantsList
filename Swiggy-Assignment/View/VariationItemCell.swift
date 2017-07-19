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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func updateVariationItemCell(with variation: Variation) {
        self.variationItemName.text = variation.name ?? ""
    }

    static func height() -> CGFloat {
        return CGFloat(44)
    }
    
}
