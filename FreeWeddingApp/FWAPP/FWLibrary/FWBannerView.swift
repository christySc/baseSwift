//
//  FWBannerView.swift
//  FreeWeddingApp
//
//  Created by 盛超 on 2017/5/31.
//  Copyright © 2017年 sc. All rights reserved.
//

import UIKit

class FWBannerView: UIView,UIScrollViewDelegate {
    
    let pageControl : UIPageControl = UIPageControl()
    let scrollView : UIScrollView = UIScrollView()
    
    var beforeItem, currentItem, afterItem : FWCycleItemView?
    
    enum FWCycleItemPageLocation {
        case left
        case center
        case right
    }
    var showPageControl = true {
        didSet {
            pageControl.isHidden = true
            
        }
    }
    //mark:时间 设为0则关闭自动轮播
    var automaticSlidingInterval: CGFloat = 0.0
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        
    }
    
}
