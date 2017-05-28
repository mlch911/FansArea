//
//  Area.swift
//  FansArea
//
//  Created by 闵罗琛 on 2017/4/5.
//  Copyright © 2017年 闵罗琛. All rights reserved.
//

struct Area {
    var name : String
    var province : String
    var part : String
    var image : String
    var isvisited : Bool
    var rating = ""
    
    init(name: String, province: String, part: String, image: String, isvisited: Bool) {
        self.name = name
        self.image = image
        self.isvisited = isvisited
        self.province = province
        self.part = part
    }
    
}
