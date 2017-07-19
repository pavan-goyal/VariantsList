//
//  VariantGroup.swift
//  Swiggy-Assignment
//
//  Created by Pavan Goyal on 19/07/17.
//  Copyright © 2017 Pavan Goyal. All rights reserved.
//

import ObjectMapper

class VariantGroup : Mappable {
    var groupId:    String?
    var name:       String?
    var variations: [Variation]?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        groupId     <- map["group_id"]
        name        <- map["name"]
        variations  <- map["variations"]
    }
}
