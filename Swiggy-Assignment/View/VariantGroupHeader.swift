//
//  VariantGroupHeader.swift
//  Swiggy-Assignment
//
//  Created by Pavan Goyal on 19/07/17.
//  Copyright © 2017 Pavan Goyal. All rights reserved.
//

import UIKit

class VariantGroupHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var headerTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateHeaderView(with variantGroup: VariantGroup) {
        self.headerTitle.text = variantGroup.name ?? ""
    }
    
    static func height() -> CGFloat {
        return CGFloat(50)
    }
    
}
