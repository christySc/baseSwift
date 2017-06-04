//
//  FWBottomDialogueProtocal.swift
//  FreeWeddingApp
//
//  Created by 盛超 on 2017/6/4.
//  Copyright © 2017年 sc. All rights reserved.
//

import Foundation
import UIKit

@objc protocol FWBottomDialogueProtocal {
    var bkgView : UIView{get}
    func hiddenView()
    func showView(frame : CGRect)
    @objc optional func leftBtAction()
    @objc optional func rightBtAction()
}

protocol FWBottomDialogueDelegate {
    func gainPicker(string : String)
}
