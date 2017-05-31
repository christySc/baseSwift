//
//  FWCycleItemView.swift
//  FreeWeddingApp
//
//  Created by 盛超 on 2017/5/31.
//  Copyright © 2017年 sc. All rights reserved.
//

import UIKit
import SnapKit

class FWCycleItemView: UIView {
    
    var imgView :UIImageView = UIImageView()
    public override init(frame: CGRect) {
       super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initUI() {
        self.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
