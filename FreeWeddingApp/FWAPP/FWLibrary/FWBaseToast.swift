//
//  FWBaseToast.swift
//  FreeWeddingApp
//
//  Created by 盛超 on 2017/6/4.
//  Copyright © 2017年 sc. All rights reserved.
//

import Foundation


import UIKit


let FWToastHorizontalMargin: CGFloat = 12
let FWToastVerticalMargin: CGFloat = 20
let FWToastHorizontalMaxPer: CGFloat = 0.4  // 40% parent view width
let FWToastVerticalMaxPer: CGFloat = 0.5    // 50% parent view height
let FWToastImageWidth: CGFloat = 30
let FWToastImageHeight: CGFloat = 30
let FWToastSpaceBetweenTextAndImage: CGFloat = 14
let FWToastErrorHeight: CGFloat = 25
let FWToastErrorHorizontalMargin: CGFloat = 10
let FWToastErrorVerticalMagin: CGFloat = 5

let FWToastLayerCornerRadius: CGFloat = 12
let FWToastLayerColor: UIColor = .black
let FWToastLayerUseShadow: Bool = true
let FWToastLayerShadowOpacity: CGFloat = 0.8
let FWToastLayerShadowRadius: CGFloat = 5.0
let FWToastLayerShadowOffset: CGSize = CGSize(width :3.0,height: 3.0)
let FWToastErrorLayerColor: UIColor = UIColor(red: 244/255, green: 81/255, blue: 78/255, alpha: 1)

let FWToastTextColor: UIColor = .white
let FWToastErrorTextColor: UIColor = .white

let FWToastFadeInTime: Double = 0.3
let FWToastFadeOutTime: Double = 0.3
let FWToastDefaultTime: Double = 2
let FWToastErrorMoveInTime: Double = 0.3
let FWToastErrorMoveOutTime: Double = 0.2

var FWTimer: UnsafePointer<Timer>? = nil
var FWToastView: UnsafePointer<UIView>? = nil

var FWErrorTimer: UnsafePointer<Timer>? = nil
var FWErrorToastView: UnsafePointer<UIView>? = nil
var FWErrorViewOriginBottomY: UnsafePointer<CGFloat>? = nil

extension UIView {
    
    /**
     make a toast (only text)
     - parameter message:  message text
     - parameter duration: toast showing time(default is 3 seconds)
     */
    func FW_makeToast(message: String, duration: Double = FWToastDefaultTime) {
        FW_toMakeToast(message: message, duration: duration, image: nil)
    }
    
    /**
     make a toast (image with text)
     - parameter message:  message text
     - parameter image: image
     - parameter duration: toast showing time(default is 3 seconds)
     */
    func FW_makeToast(message: String, image: UIImage, duration: Double = FWToastDefaultTime) {
        FW_toMakeToast(message: message, duration: duration, image: image)
    }
    
    /**
     make a toast (only image)
     - parameter image: image
     - parameter duration: toast showing time(default is 3 seconds)
     */
    func FW_makeToastImage(image: UIImage, duration: Double = FWToastDefaultTime) {
        FW_toMakeToast(message: nil, duration: duration, image: image)
    }
    
    /**
     make a error toast view
     - parameter message:  error information
     - parameter duration: showing time(default is 3 seconds)
     */
    func FW_makeErrorToast(message: String, originBottomPosY posY: CGFloat = 0, duration: Double = FWToastDefaultTime) {
        
        objc_setAssociatedObject(self, &FWErrorViewOriginBottomY, posY, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        if let errorView = objc_getAssociatedObject(self, &FWErrorToastView) {
            if let timer = objc_getAssociatedObject(errorView, &FWErrorTimer) {
                (timer as AnyObject).invalidate()
            }
            FW_hideErrorView(view: errorView as! UIView, force: true)
        }
        
        let toast = FW_errorView(message: message)
        self.addSubview(toast)
        objc_setAssociatedObject(self, &FWErrorToastView, toast, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        FW_showErrorView(view: toast, duration: duration)
    }
    
    private func FW_toMakeToast(message: String?, duration: Double, image: UIImage?) {
        
        if let toastView = objc_getAssociatedObject(self, &FWToastView) {
            if let timer = objc_getAssociatedObject(toastView, &FWTimer) {
                (timer as AnyObject).invalidate()
            }
            FW_hideWrapperView(view: toastView as! UIView, force: true)
        }
        
        let toast = FW_wrapperView(msg: message, image: image)
        self.addSubview(toast)
        objc_setAssociatedObject(self, &FWToastView, toast, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        FW_showWrapperView(view: toast, duration: duration)
    }
    
    private func FW_wrapperView(msg: String?, image: UIImage?) -> UIView {
        
        let wrapperView = UIView()
        wrapperView.layer.cornerRadius = FWToastLayerCornerRadius
        wrapperView.backgroundColor = FWToastLayerColor.withAlphaComponent(0.7)
        wrapperView.alpha = 0.0
        if FWToastLayerUseShadow {
            wrapperView.layer.shadowColor = FWToastLayerColor.cgColor
            wrapperView.layer.shadowOpacity = Float(FWToastLayerShadowOpacity)
            wrapperView.layer.shadowRadius = FWToastLayerShadowRadius
            wrapperView.layer.shadowOffset = FWToastLayerShadowOffset
        }
        
        var imageView: UIImageView!
        var msgLabel: UILabel!
        let parentSize = self.bounds.size
        
        if image != nil {
            imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.frame.size = CGSize(width :FWToastImageWidth, height: FWToastImageHeight)
            wrapperView.addSubview(imageView)
        }
        
        if msg != nil {
            msgLabel = UILabel()
            msgLabel.text = msg
            msgLabel.textColor = FWToastTextColor
            msgLabel.font = UIFont.systemFont(ofSize: 14)
            msgLabel.lineBreakMode = .byWordWrapping
            msgLabel.numberOfLines = 0
            msgLabel.textAlignment = .center
            wrapperView.addSubview(msgLabel)
            
            let maxMsgWidth = parentSize.width * FWToastHorizontalMaxPer - FWToastHorizontalMargin * 2
            let maxMsgHeight = FW_heightForLabel(textLabel: msgLabel, width: maxMsgWidth)
            msgLabel.frame.size = CGSize(width :maxMsgWidth,height : maxMsgHeight)
        }
        
        let imageHeight = (imageView != nil) ? imageView.frame.size.height + ((msgLabel != nil) ? FWToastSpaceBetweenTextAndImage : 0) : 0
        let textHeight = (msgLabel != nil) ? msgLabel.frame.size.height : 0
        let wrapperWidth = parentSize.width * FWToastHorizontalMaxPer
        let wrapperHeight = min(imageHeight + textHeight + FWToastVerticalMargin * 2, parentSize.height * FWToastVerticalMaxPer)
        wrapperView.frame.size = CGSize(width: wrapperWidth, height: wrapperHeight)
        wrapperView.center = CGPoint(x: parentSize.width * 0.5, y: parentSize.height * 0.5)
        
        if imageView != nil {
            imageView!.center = CGPoint(x: wrapperWidth * 0.5, y: FWToastVerticalMargin + imageView!.frame.size.height * 0.5)
        }
        
        if msgLabel != nil {
            msgLabel!.center = CGPoint(x: wrapperWidth * 0.5, y: wrapperHeight - msgLabel!.frame.size.height * 0.5 - FWToastVerticalMargin)
        }
        
        return wrapperView
    }
    
    private func FW_errorView(message: String) -> UIView {
        
        let errorView = UIView()
        errorView.backgroundColor = FWToastErrorLayerColor
        
        let textLabel = UILabel()
        textLabel.text = message
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.textColor = FWToastErrorTextColor
        errorView.addSubview(textLabel)
        
        let parentSize = self.bounds.size
        let maxTextWidth = parentSize.width - FWToastErrorHorizontalMargin * 2
        let maxTextHeight = FW_heightForLabel(textLabel: textLabel, width: maxTextWidth)
        textLabel.frame.size = CGSize(width: maxTextWidth,height : maxTextHeight)
        errorView.frame.size = CGSize(width : parentSize.width, height: maxTextHeight+FWToastErrorVerticalMagin*2)
        textLabel.center = CGPoint(x:errorView.frame.size.width * 0.5, y: errorView.frame.size.height * 0.5)
        
        let posY = objc_getAssociatedObject(self, &FWErrorViewOriginBottomY) as! CGFloat
        errorView.center = CGPoint(x: parentSize.width * 0.5,y : posY - errorView.frame.size.height * 0.5)
        
        return errorView
    }
    
    private func FW_hideWrapperView(view: UIView, force: Bool) {
        func clearProperty() {
            view.removeFromSuperview()
            objc_setAssociatedObject(self, &FWToastView, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            objc_setAssociatedObject(self, &FWTimer, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        if force {
            clearProperty()
        } else {
            UIView.animate(withDuration: FWToastFadeOutTime, delay: 0.0, options: [.curveEaseIn], animations: { view.alpha = 0.0 }) { (over: Bool) in
                clearProperty()
            }
        }
    }
    
    private func FW_showWrapperView(view: UIView, duration: Double) {
        UIView.animate(withDuration: FWToastFadeInTime, delay: 0, options: [.curveEaseOut], animations: { view.alpha = 1.0 }) { (over: Bool) in
            let timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(self.FW_onToHideToastView), userInfo: view, repeats: false)
            objc_setAssociatedObject(view, &FWTimer, timer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private func FW_hideErrorView(view: UIView, force: Bool) {
        func clearProperty() {
            view.removeFromSuperview()
            objc_setAssociatedObject(self, &FWErrorToastView, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            objc_setAssociatedObject(self, &FWErrorTimer, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        if force {
            clearProperty()
        } else {
            UIView.animate(withDuration: FWToastErrorMoveOutTime, delay: 0.0, options: [.curveEaseIn], animations: {
                let posY = objc_getAssociatedObject(self, &FWErrorViewOriginBottomY) as! CGFloat
                view.frame.origin.y = posY - view.frame.size.height
            }) { (over: Bool) in
                clearProperty()
            }
        }
    }
    
    private func FW_showErrorView(view: UIView, duration: Double) {
        UIView.animate(withDuration: FWToastErrorMoveInTime, delay: 0, options: [.curveEaseOut], animations: {
            view.frame.origin.y += view.frame.size.height
        }) { (over: Bool) in
            let timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(self.FW_onToHideErrorToastView), userInfo: view, repeats: false)
            objc_setAssociatedObject(view, &FWErrorTimer, timer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func FW_onToHideToastView(timer: Timer) {
        self.FW_hideWrapperView(view: timer.userInfo as! UIView, force: false)
    }
    
    func FW_onToHideErrorToastView(timer: Timer) {
        self.FW_hideErrorView(view: timer.userInfo as! UIView, force: false)
    }
    
    /**
     get a UILabel's max height, with UILabel's width
     - parameter textLabel: the text label
     - parameter width:     the text label's width
     - returns: get the label max height
     */
    func FW_heightForLabel(textLabel: UILabel, width: CGFloat) -> CGFloat {
        let attributes = [NSFontAttributeName: textLabel.font!]
        let rect = (textLabel.text! as NSString).boundingRect(with: CGSize(width : width, height : 0), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect.height
    }
}
