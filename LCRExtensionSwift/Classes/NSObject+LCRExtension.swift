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
    static func lcr_sizeWithText(_ text:String, height:CGFloat,font:UIFont) -> CGFloat{
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
    static func lcr_sizeHeightText(_ text:String, width:CGFloat,font:UIFont) -> CGFloat{
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
    static func lcr_sizeHeightText(_ text:String, width:CGFloat,font:UIFont,lineSpacing:CGFloat) -> CGFloat{
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
    
    static func lcr_changeStrColor(_ string: String?, targetStr: String?, color: UIColor?) -> NSMutableAttributedString? {
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
    
    static func lcr_changeStrColor(_ string: String?, targetStrs: [String?], color: UIColor?) -> NSMutableAttributedString? {
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
    
    
    static func lcr_changeStrColor(_ string: String?, targetStr: String?, color: UIColor?,font:UIFont?) -> NSMutableAttributedString? {
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
    static func lcr_changeLineSpace(_ string:String,font:UIFont? = UIFont.systemFont(ofSize: 15),lineSpacing:CGFloat,alignment:NSTextAlignment? = .natural) -> NSAttributedString? {
        
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
    
    static func changeStrColor(_ string: String?, range: NSRange, color: UIColor?) -> NSMutableAttributedString? {
        let attrString = NSMutableAttributedString(string: string ?? "")
     
        //NSMakeRange(0, 3)从0开始的3个字符
        if let color = color {
            attrString.addAttributes([
                NSAttributedString.Key.foregroundColor: color
            ], range: range)
        }
        return attrString
    }
    
    static func lcr_changeStrStyle(_ string: String?, targetStr: String?, color: UIColor?,font:UIFont? = UIFont.systemFont(ofSize: 15),lineSpacing:CGFloat,alignment:NSTextAlignment? = .natural) -> NSMutableAttributedString? {
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

extension NSObject {
    
    /// 制定圆角
    /// - Parameter bounds: 控件bounds
    /// - Parameter corners: 原始位置
    /// - Parameter radiu: 圆角大小
    static func lcr_widgeMaskLayer(_ bounds:CGRect,corners:UIRectCorner,radiu:CGFloat) -> CAShapeLayer {
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radiu, height: radiu))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        return maskLayer
    }
    
}


extension String
{
    /// 将中文字符串转换为拼音
    ///
    /// - Parameter hasBlank: 是否带空格（默认不带空格）
    func lcr_transformToPinyin( hasBlank: Bool = false) -> String {
        
        let stringRef = NSMutableString(string: self) as CFMutableString
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false) // 转换为带音标的拼音
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false) // 去掉音标
        let pinyin = stringRef as String
        return hasBlank ? pinyin : pinyin.replacingOccurrences(of: " ", with: "")
    }
    
    /// 获取中文首字母
    ///
    /// - Parameter lowercased: 是否小写（默认大写）
    func lcr_transformToPinyinHead(str:String, lowercased: Bool = false) -> String {
        let strPinYin = str.lcr_transformToPinyin(hasBlank: true).capitalized // 字符串转换为首字母大写
        // 截取大写首字母
        let firstString = strPinYin.substring(to: strPinYin.index(strPinYin.startIndex, offsetBy:1))
        // 判断姓名首位是否为大写字母
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "#"
    }
}
