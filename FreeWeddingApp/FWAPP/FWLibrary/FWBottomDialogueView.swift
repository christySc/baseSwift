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
    var bottomView = BottomPickerView()
    
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
        
        guard leftString != nil && rightString != nil else {
            FWPrint("不可以同时没有取消确定按钮!")
            return
        }
        
   
        
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
        
        self.bkgView.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(bkgView)
            make.height.equalTo(self.bkgView.bounds.size.height-30)
        }
        bottomView.dataSource = ["其他","婚纱","礼服","旅拍","婚宴"]
        
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
        self.delegate?.gainPicker(string: bottomView.resultString)
        self.hiddenView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}




class BottomPickerView: UIView , UIPickerViewDelegate ,UIPickerViewDataSource {
    

    
    var pickerView = UIPickerView()
    var dataSource : Array<String>! = [] {
        didSet {
            self.pickerView .reloadAllComponents()
            resultString = dataSource.count > 0 ? dataSource[0] : ""
        }
    }
    var resultString = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(pickerView)
        pickerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: delegate and dataSource
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        resultString = dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 55.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        for  singleLine : UIView in pickerView.subviews {
            if singleLine.frame.size.height < 1 {
                singleLine.backgroundColor = .Gray_3
            }
        }
        let tmpLabel = UILabel()
        tmpLabel.text = dataSource[row]
        tmpLabel.textAlignment = .center
        return tmpLabel
    }
    
}


