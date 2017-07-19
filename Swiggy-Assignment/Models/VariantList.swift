//
//  File.swift
//  Swiggy-Assignment
//
//  Created by Pavan Goyal on 19/07/17.
//  Copyright © 2017 Pavan Goyal. All rights reserved.
//

import ObjectMapper

class VariantList : Mappable {
    var mainVariant: Variants?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        mainVariant     <- map["variants"]
    }
}
