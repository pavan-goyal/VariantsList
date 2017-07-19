//
//  Variants.swift
//  Swiggy-Assignment
//
//  Created by Pavan Goyal on 19/07/17.
//  Copyright © 2017 Pavan Goyal. All rights reserved.
//

import ObjectMapper

class Variants : Mappable {
    var variantGroups: [VariantGroup]?
    var excludeList:   [[ExcludedItem]]?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        variantGroups     <- map["variant_groups"]
        excludeList       <- map["exclude_list"]
    }
}
