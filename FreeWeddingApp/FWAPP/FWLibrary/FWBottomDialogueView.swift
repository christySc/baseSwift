//
//  FWBottomDialogueView.swift
//  FreeWeddingApp
//
//  Created by 盛超 on 2017/6/3.
//  Copyright © 2017年 sc. All rights reserved.
//

import UIKit

class FWBottomDialogueView: UIView ,FWBottomDialogueProtocal{

    var leftButton : UIButton?
    var rightButton : UIButton?
    var bkgView = UIView()
    var delegate : FWBottomDialogueDelegate?
    
    
    var leftBtColor : UIColor? {

        didSet {
            leftButton?.setTitleColor(leftBtColor, for: .normal)
        }
    }
    var rightBtColor : UIColor? {
        
        didSet {
            rightButton?.setTitleColor(rightBtColor, for: .normal)
        }
    }


    init(frame: CGRect, leftButtonTitle : String? = "取消", rightButtonTitle : String? = "确定") {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:0.7)
        self.showView(frame: frame)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hiddenView))
        self.addGestureRecognizer(tap)
        self.initUI(leftString: leftButtonTitle, rightString: rightButtonTitle)
    }

    //MARK: UI
    
    func initUI(leftString : String?, rightString : String?){
        

        
        if let leftString = leftString {
            leftButton = UIButton(frame: .zero)
            leftButton!.setTitle(leftString, for: .normal)
            leftButton!.setTitleColor(.black, for: .normal)
            bkgView.addSubview(leftButton!)
            leftButton!.addTarget(self, action: #selector(leftBtAction), for: .touchUpInside)
            leftButton!.snp.makeConstraints({ (make) in
                make.left.top.equalTo(bkgView)
                make.width.greaterThanOrEqualTo(80)
                make.height.greaterThanOrEqualTo(30)
            })
        }
        
        if let rightString = rightString {
            rightButton = UIButton(frame: .zero)
            rightButton!.setTitle(rightString, for: .normal)
            rightButton!.setTitleColor(.black, for: .normal)
            bkgView.addSubview(rightButton!)
            rightButton!.addTarget(self, action: #selector(rightBtAction), for: .touchUpInside)
            rightButton!.snp.makeConstraints({ (make) in
                make.right.top.equalTo(bkgView)
                make.width.greaterThanOrEqualTo(80)
                make.height.greaterThanOrEqualTo(30)
            })
        }
    }
    
    //MARK : 手势
    
    func hiddenView() {
        UIView.animate(withDuration: 0.3, animations: {
            var frame = self.bkgView.frame
            frame.origin.y = UIScreen.main.bounds.size.height
            self.bkgView.frame = frame
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    func showView(frame : CGRect) {

        bkgView.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: kScreenWidthSW, height: 0)
        bkgView.backgroundColor = .white
        self.addSubview(bkgView)
        UIView.animate(withDuration: 0.3) {
            self.bkgView.frame = frame
        }
    }
    
    func leftBtAction() {
        self.hiddenView()
    }
    
    func rightBtAction() {
        self.delegate?.gainPicker(string: "点过我了!")
        self.hiddenView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
