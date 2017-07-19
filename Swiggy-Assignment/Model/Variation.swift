//
//  Variation.swift
//  Swiggy-Assignment
//
//  Created by Pavan Goyal on 19/07/17.
//  Copyright © 2017 Pavan Goyal. All rights reserved.
//

import ObjectMapper

class Variation : Mappable {
    var variationId: String?
    var name:        String?
    var price:       Int?
    var isDefault:   Int?
    var inStock:     Int?
    var isVeg:       Int?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        variationId     <- map["id"]
        name            <- map["name"]
        price           <- map["price"]
        isDefault       <- map["default"]
        inStock         <- map["inStock"]
        isVeg           <- map["isVeg"]
    }
}
