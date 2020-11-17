//
//  UIView+LCRExtension.swift
//  LCRCategoryKit
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//

import UIKit

extension UIView {
    
    //获取视图的X坐标
    public var lcr_x:CGFloat{
        get{
            return self.frame.origin.x;
        }
        
        set{
            var frames = self.frame;
            frames.origin.x = CGFloat(newValue);
            self.frame = frames;
        }
    }
    
    //获取视图的Y坐标
    public var lcr_y:CGFloat{
        get{
            return self.frame.origin.y;
        }
        
        set{
            var frames = self.frame;
            frames.origin.y = CGFloat(newValue);
            self.frame = frames;
        }
    }
    
    //获取视图的宽
    public var lcr_width:CGFloat{
        get{
            return self.frame.size.width;
        }
        
        set{
            var frames = self.frame;
            frames.size.width = CGFloat(newValue);
            self.frame = frames;
        }
    }
    
    //获取视图的高
    public var lcr_height:CGFloat{
        get{
            return self.frame.size.height;
        }
        
        set{
            var frames = self.frame;
            frames.size.height = CGFloat(newValue);
            self.frame = frames;
        }
    }
    
    //获取最大的X坐标
    public var lcr_maxX:CGFloat{
        get{
            return self.lcr_x + self.lcr_width;
        }
        
        set{
            var frames = self.frame;
            frames.origin.x = CGFloat(newValue - self.lcr_width);
            self.frame = frames;
        }
    }
    
    //获取最大的Y坐标
    public var lcr_maxY:CGFloat{
        get{
            return self.lcr_y + self.lcr_height;
        }
        
        set{
            var frames = self.frame;
            frames.origin.y = CGFloat(newValue - self.lcr_height);
            self.frame = frames;
        }
    }
    
    //中心点X坐标
    public var lcr_centerX:CGFloat{
        get{
            return self.center.x;
        }
        set{
            self.center = CGPoint(x:CGFloat(newValue),y:self.center.y);
        }
    }
    
    //中心点Y坐标
    public var lcr_centerY:CGFloat{
        get{
            return self.center.y;
        }
        set{
            self.center = CGPoint(x:self.center.x,y:CGFloat(newValue));
        }
    }
    
    public var lcr_size:CGSize{
        get{
            return self.frame.size;
        }
        set{
            var frame: CGRect = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    /// 删除所有的子视图
    public func lcr_removeAllSubView() -> Void {
        for view : UIView in self.subviews{
            view.removeFromSuperview();
        }
    }
    
    ///加载XIB文件
    public class func initWithXibName(xib:String) -> Any? {
        guard let nibs:Array = Bundle.main.loadNibNamed(xib, owner: nil, options: nil)else{
            return nil;
        }
        return nibs[0] ;
    }
    
    //设置边框
    public func lcr_setBoardWithColor(color:UIColor,top:Bool,right:Bool,bottom:Bool,left:Bool,width:CGFloat) -> Void {
        if top == true {
            let layer:CALayer = CALayer();
            layer.frame = CGRect(x: 0, y: 0, width: self.lcr_width, height: width);
            layer.backgroundColor = color.cgColor;
            self.layer.addSublayer(layer);
        }
        if right == true {
            let layer:CALayer = CALayer();
            layer.frame = CGRect(x: self.lcr_width - width, y: 0, width: width, height: self.lcr_height);
            layer.backgroundColor = color.cgColor;
            self.layer.addSublayer(layer);
        }
        if bottom == true {
            let layer:CALayer = CALayer();
            layer.frame = CGRect(x: 0, y: self.lcr_height - width, width: self.lcr_width, height: width);
            layer.backgroundColor = color.cgColor;
            self.layer.addSublayer(layer);
        }
        if left == true {
            let layer:CALayer = CALayer();
            layer.frame = CGRect(x: 0, y: 0, width: width, height: self.lcr_height);
            layer.backgroundColor = color.cgColor;
            self.layer.addSublayer(layer);
        }
    }
    
    /// 制定圆角
    /// - Parameter bounds: 控件bounds
    /// - Parameter corners: 原始位置
    /// - Parameter radiu: 圆角大小
    public func lcr_radiusWithRadius(_ radius:CGFloat,corners:UIRectCorner) -> Void {
        
        if #available(iOS 11.0, *) { // ios11 以上偏移
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
            layer.masksToBounds = true
        } else {
            let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = maskPath.cgPath
            layer.mask = maskLayer;
        }
    }
    
    public func lcr_addShadowLayer(_ color:UIColor,
                        offset:CGSize,
                        radius:CGFloat,
                        opacity:CGFloat) {
        self.layer.shadowColor = color.cgColor;
        self.layer.shadowOffset = offset;
        self.layer.shadowRadius = radius;
        self.layer.shadowOpacity = Float(opacity);
    }
}
