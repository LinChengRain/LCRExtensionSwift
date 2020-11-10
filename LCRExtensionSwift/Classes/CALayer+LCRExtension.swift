//
//  CALayer+LCRExtension.swift
//  LCRCategoryKit
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//

import UIKit

private let radarAnimation = "radarAnimation"

extension CALayer {
    /// 雷达动画
    static func lcr_makeRadarAnimation(showRect: CGRect, isRound: Bool) -> CALayer {
        // 1. 一个动态波
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = showRect
        // showRect 最大内切圆
        if isRound {
            shapeLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: showRect.width, height: showRect.height)).cgPath
        } else {
            // 矩形
            shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: showRect.width, height: showRect.height), cornerRadius: 10).cgPath
        }
        
        shapeLayer.fillColor = UIColor.white.cgColor
        // 默认初始颜色透明度
        shapeLayer.opacity = 0.0
                
        // 2. 需要重复的动态波，即创建副本
        let replicator = CAReplicatorLayer()
        replicator.frame = shapeLayer.bounds
        replicator.instanceCount = 4
        replicator.instanceDelay = 1.0
        replicator.addSublayer(shapeLayer)

        // 3. 创建动画组
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = NSNumber(floatLiteral: 1.0)  // 开始透明度
        opacityAnimation.toValue = NSNumber(floatLiteral: 0)      // 结束时透明底
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform")
        if isRound {
            scaleAnimation.fromValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0, 0, 0))      // 缩放起始大小
        } else {
            scaleAnimation.fromValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0))      // 缩放起始大小
        }
        scaleAnimation.toValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 2.0, 2.0, 0))      // 缩放结束大小
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [opacityAnimation, scaleAnimation]
        animationGroup.duration = 3.0       // 动画执行时间
        animationGroup.repeatCount = HUGE   // 最大重复
        animationGroup.autoreverses = false
                
        shapeLayer.add(animationGroup, forKey: radarAnimation)
        
        return replicator
    }
}
