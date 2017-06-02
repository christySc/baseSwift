//
//  FWBaseModel.swift
//  FreeWeddingApp
//
//  Created by 盛超 on 2017/6/1.
//  Copyright © 2017年 sc. All rights reserved.
//

import Foundation
import HandyJSON


struct FWRequestBaseModel : HandyJSON{
    var code : Int?
    var msg : Any?
    var data : Any?
    var total : Any?
}

