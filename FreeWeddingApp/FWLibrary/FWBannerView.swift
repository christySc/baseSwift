//
//  FWBannerView.swift
//  FreeWeddingApp
//
//  Created by 盛超 on 2017/5/31.
//  Copyright © 2017年 sc. All rights reserved.
//

import UIKit

class FWBannerView: UIView,UIScrollViewDelegate {
    enum FWCycleItemPageLocation {
        case left
        case center
        case right
    }
    var showPageControl = true
    var isAuto = true
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
