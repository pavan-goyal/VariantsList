//
//  ExcludedItem.swift
//  Swiggy-Assignment
//
//  Created by Pavan Goyal on 19/07/17.
//  Copyright © 2017 Pavan Goyal. All rights reserved.
//

import ObjectMapper

class ExcludedItem : Mappable {
    var variationId: String?
    var groupId:     String?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        variationId     <- map["variation_id"]
        groupId         <- map["group_id"]
    }
}
