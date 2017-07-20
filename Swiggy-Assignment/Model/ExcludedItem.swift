//
//  ExcludedItem.swift
//  Swiggy-Assignment
//
//  Created by Pavan Goyal on 19/07/17.
//  Copyright © 2017 Pavan Goyal. All rights reserved.
//

import ObjectMapper

class ExcludedItem : Mappable, Equatable {
    var variationId: String?
    var groupId:     String?

    init(groupId: String?, variationId: String?) {
        self.variationId = variationId
        self.groupId = groupId
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        variationId     <- map["variation_id"]
        groupId         <- map["group_id"]
    }
    
    public static func ==(lhs: ExcludedItem, rhs: ExcludedItem) -> Bool {
        return (lhs.groupId == rhs.groupId) && (lhs.variationId == rhs.variationId)
    }
    
    public static func !=(lhs: ExcludedItem, rhs: ExcludedItem) -> Bool {
        return !(lhs == rhs)
    }
}
