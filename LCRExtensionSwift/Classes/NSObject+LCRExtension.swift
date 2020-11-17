//
//  NSObject+LCRExtension.swift
//  LCRCategoryKit
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//

import UIKit

extension NSObject {
    
    
    /// 获取字符串长度
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - height: 默认高度
    ///   - font: 字体大小
    /// - Returns: 文本宽度
    public static func lcr_sizeWithText(_ text:String, height:CGFloat,font:UIFont) -> CGFloat{
        let sting: NSString = text as NSString
        let attributes = [NSAttributedString.Key.font:font]
        
        let rect = sting.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
        return rect.size.width
    }
    
    /// 获取字符串高度
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - width: 默认宽度
    ///   - font: 字体大小
    /// - Returns: 文本高度
    public static func lcr_sizeHeightText(_ text:String, width:CGFloat,font:UIFont) -> CGFloat{
        let sting: NSString = text as NSString
        let attributes = [NSAttributedString.Key.font:font]
        
        let rect = sting.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
        return rect.size.height
    }
    
    
    /// 获取字符串高度
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - width: 默认宽度
    ///   - font: 字体大小
    ///   - lineSpacing: 行间距
    /// - Returns: 文本高度
    public static func lcr_sizeHeightText(_ text:String, width:CGFloat,font:UIFont,lineSpacing:CGFloat) -> CGFloat{
        let sting: NSString = text as NSString
        
        /// 通过富文本来设置行间距
        let paragraphStye = NSMutableParagraphStyle()
        /// 调整行间距
        paragraphStye.lineSpacing = lineSpacing
        paragraphStye.lineBreakMode = NSLineBreakMode.byWordWrapping
        //样式属性集合
        let attributes = [NSAttributedString.Key.font:font,
                          NSAttributedString.Key.paragraphStyle: paragraphStye]
                
        let rect = sting.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
        return rect.size.height
    }
    
    public static func lcr_changeStrColor(_ string: String?, targetStr: String?, color: UIColor?) -> NSMutableAttributedString? {
        let attrString = NSMutableAttributedString(string: string ?? "")
        
        //找出特定字符在整个字符串中的位置
        let range = NSRange(location: (attrString.string as NSString).range(of: targetStr ?? "").location, length: (attrString.string as NSString).range(of: targetStr ?? "").length)
        
        //NSMakeRange(0, 3)从0开始的3个字符
        if let color = color {
            attrString.addAttributes([
                NSAttributedString.Key.foregroundColor: color
            ], range: range)
        }
        return attrString
    }
    
    public static func lcr_changeStrColor(_ string: String?, targetStrs: [String?], color: UIColor?) -> NSMutableAttributedString? {
        let attrString = NSMutableAttributedString(string: string ?? "")
        
        for targetStr in targetStrs {
            //找出特定字符在整个字符串中的位置
            let range = NSRange(location: (attrString.string as NSString).range(of: targetStr ?? "").location, length: (attrString.string as NSString).range(of: targetStr ?? "").length)
            
            //NSMakeRange(0, 3)从0开始的3个字符
            if let color = color {
                attrString.addAttributes([
                    NSAttributedString.Key.foregroundColor: color
                ], range: range)
            }
        }
        return attrString
    }
    
    
    public static func lcr_changeStrColor(_ string: String?, targetStr: String?, color: UIColor?,font:UIFont?) -> NSMutableAttributedString? {
        let attrString = NSMutableAttributedString(string: string ?? "")
        
        //找出特定字符在整个字符串中的位置
        let range = NSRange(location: (attrString.string as NSString).range(of: targetStr ?? "").location, length: (attrString.string as NSString).range(of: targetStr ?? "").length)
        
        //NSMakeRange(0, 3)从0开始的3个字符
        if let color = color {
            attrString.addAttributes([
                NSAttributedString.Key.foregroundColor: color
            ], range: range)
        }
        
        if let font = font {
            attrString.addAttributes([
                NSAttributedString.Key.font: font
            ], range: range)
        }
        return attrString
    }
    
    
    /// 调整行间距
    /// - Parameters:
    ///   - string: 字符串
    ///   - font: 字体
    ///   - lineSpacing: 行间距
    ///   - alignment: 显示位置
    public static func lcr_changeLineSpace(_ string:String,font:UIFont? = UIFont.systemFont(ofSize: 15),lineSpacing:CGFloat,alignment:NSTextAlignment? = .natural) -> NSAttributedString? {
        
        /// 通过富文本来设置行间距
        let paragraphStye = NSMutableParagraphStyle()
        /// 调整行间距
        paragraphStye.lineSpacing = lineSpacing
        paragraphStye.lineBreakMode = NSLineBreakMode.byWordWrapping
        paragraphStye.alignment = alignment!
        //样式属性集合
        let attributes = [NSAttributedString.Key.font:font,
                          NSAttributedString.Key.paragraphStyle: paragraphStye]
        let attributedString =  NSAttributedString(string: string, attributes: attributes as [NSAttributedString.Key : Any])

        return attributedString
    }
    
    public static func changeStrColor(_ string: String?, range: NSRange, color: UIColor?) -> NSMutableAttributedString? {
        let attrString = NSMutableAttributedString(string: string ?? "")
     
        //NSMakeRange(0, 3)从0开始的3个字符
        if let color = color {
            attrString.addAttributes([
                NSAttributedString.Key.foregroundColor: color
            ], range: range)
        }
        return attrString
    }
    
    public static func lcr_changeStrStyle(_ string: String?, targetStr: String?, color: UIColor?,font:UIFont? = UIFont.systemFont(ofSize: 15),lineSpacing:CGFloat,alignment:NSTextAlignment? = .natural) -> NSMutableAttributedString? {
        let attrString = NSMutableAttributedString(string: string ?? "")
        
        //找出特定字符在整个字符串中的位置
        let range = NSRange(location: (attrString.string as NSString).range(of: targetStr ?? "").location, length: (attrString.string as NSString).range(of: targetStr ?? "").length)
        
        if let color = color {
            attrString.addAttributes([
                NSAttributedString.Key.foregroundColor: color
            ], range: range)
        }
        
        /// 通过富文本来设置行间距
        let paragraphStye = NSMutableParagraphStyle()
        /// 调整行间距
        paragraphStye.lineSpacing = lineSpacing
        paragraphStye.lineBreakMode = NSLineBreakMode.byWordWrapping
        paragraphStye.alignment = alignment!
        //样式属性集合
        let attributes = [NSAttributedString.Key.font:font,
                          NSAttributedString.Key.paragraphStyle: paragraphStye]
        attrString.addAttributes(attributes as [NSAttributedString.Key : Any], range: NSRange(location: 0, length: string?.length ?? 0))
//
        return attrString
    }
}
