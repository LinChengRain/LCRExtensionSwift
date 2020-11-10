//
//  CAGradientLayer+LCRExtension.swift
//  LCRCategoryKit
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    //获取渐变层
    func lcr_rainbowLayer(_ colors:[CGColor],_ startPoint:CGPoint ,_ endPoint:CGPoint) -> CAGradientLayer {
        //定义渐变的颜色（7种彩虹色）
        let gradientColors = colors
        
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.0,1.0]
        
        //创建CAGradientLayer对象并设置参数
        self.colors = gradientColors
        self.locations = gradientLocations
        
        //设置渲染的起始结束位置（横向渐变）
        self.startPoint = startPoint
        self.endPoint = endPoint
        
        return self
    }
}
