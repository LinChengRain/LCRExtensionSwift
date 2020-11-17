//
//  UIImage+LCRExtension.swift
//  LCRCategoryKit
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//

import UIKit

extension UIImage {
    
    public class func lcr_imageWithColor(color: UIColor, size: CGSize) -> UIImage? {
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContext(size)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    ///   将某个view 转换成图像
    public class func lcr_getImageFromView(view:UIView) ->UIImage{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
//MARK: - 图片合成
extension UIImage {
    
    /// 分享图片处理
    /// 多张图片合成成一张图片
    /// - Parameters:
    ///   - images: 资源链接集合
    ///   - completion: 处理结果回调
    public static func lcr_picturesToComposites(_ images:[String],completion:((UIImage?)->())?) {
        /// 数组数量为0时，直接返回
        if images.count == 0 {
            return (completion?(nil))!
        }
        
        let queue = DispatchQueue.global()
        let group = DispatchGroup()
        
        var imageArray:[UIImage] = []
        queue.async(group: group) {
            for url in images {
                /// 图片容器数据大于9时，跳出循环
                if imageArray.count >= 9 {
                    break
                }
                group.enter()
                if url.count > 0 {
                    let data = try! Data(contentsOf: URL(string: url)!)
                    let originImage = UIImage(data: data)
                    imageArray.append(originImage!)
                }
                group.leave()
            }
        }
        
        group.notify(queue: queue) {
            print("All task has finished")
            
            let contextWidth = UIScreen.main.bounds.width * 2
            let contextHeight = UIScreen.main.bounds.width * 2
            
            /// 开启上下文
            UIGraphicsBeginImageContext(CGSize(width: contextWidth, height: contextHeight))
            
            for i in 0..<imageArray.count {
                
                let image = imageArray[i]
                var rect:CGRect = CGRect.zero
                switch imageArray.count {
                    case 1:
                        rect = CGRect(x: 0, y: 0, width:  contextWidth, height:  contextHeight )
                        break
                    case 2:
                        if i == 0 {
                            rect = CGRect(x: 0, y: 0, width:  contextWidth / 2, height:  contextHeight )
                        } else {
                            rect = CGRect(x: contextWidth / 2, y: 0, width:  contextWidth, height:  contextHeight )
                        }
                        break
                    case 3,4:
                        let width = contextWidth / 2
                        let height = contextHeight / 2
                        if i < 2 {
                            rect = CGRect(x: width * CGFloat(i), y: 0, width:  width, height: height )
                        } else {
                            rect = CGRect(x: width * CGFloat(i - 2), y: height, width:  width, height:  height )
                        }
                        break
                    case 5,6:
                        let width = contextWidth / 3
                        let height = contextHeight / 2
                        if i < 3 {
                            rect = CGRect(x: width * CGFloat(i), y: 0, width:  width, height:  height )
                        } else {
                            rect = CGRect(x: width * CGFloat( i - 3), y: height  , width:  width, height:  height )
                        }
                        break
                    case 7,8,9:
                        let width = contextWidth / 3
                        let height = contextHeight / 3
                        if i < 3 {
                            rect = CGRect(x: width * CGFloat(i), y: 0, width:  width, height:  height )
                        } else if i >= 3 && i < 6 {
                            rect = CGRect(x: width * CGFloat(i - 3), y: height, width:  width, height:  height )
                        } else if i >= 6 && i < 9 {
                            rect = CGRect(x: width * CGFloat(i - 6), y: height  * 2, width:  width, height:  height )
                        }
                        break
                    default:
                        break
                }
                image.draw(in: rect)
            }
            
            /// 根据图形上下文拿到图片
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            /// 关闭上下文
            UIGraphicsEndImageContext()
            
            
            //先判断当前质量是否满足要求，不满足再进行压缩
            var imageData = newImage?.jpegData(compressionQuality: 1.0) //首次进行压缩
            var image: UIImage? = nil
            if let imageData = imageData {
                image = UIImage(data: imageData)
            }
            //图片限制大小不超过 9M     CGFloat  kb =   data.lenth / 1000;  计算kb方法 os 按照千进制计算
            while (imageData?.count ?? 0) / 1000 > 1024 * 9 {
                print("图片超过10 压缩")
                imageData = image?.jpegData(compressionQuality: 0.5)
                if let imageData = imageData {
                    image = UIImage(data: imageData)
                }
            }
            
            DispatchQueue.main.async {
                completion?(image)
            }
        }
    }
}
//MARK: - 二维码
extension UIImage {
    
    public static func lcr_logolOrQRImage(_ QRTargetString:String,image:UIImage?) -> UIImage {
        
        //创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        //将url加入二维码
        filter?.setValue(QRTargetString.data(using: String.Encoding.utf8), forKey: "inputMessage")
        
        //取出生成的二维码（不清晰）
        if let outputImage = filter?.outputImage {
            //生成清晰度更好的二维码
            let qrCodeImage = UIImage.lcr_setupHighDefinitionUIImage(outputImage, size: 300)
            //如果有一个头像的话，将头像加入二维码中心
            if var image = image {
                //给头像加一个白色圆边（如果没有这个需求直接忽略）
                image = UIImage.lcr_circleImageWithImage(image, borderWidth: 50, borderColor: UIColor.white)
                //合成图片
                let newImage = UIImage.lcr_syntheticImage(qrCodeImage, iconImage: image, width: 100, height: 100)
                
                return newImage
            }
            
            return qrCodeImage
        }
        
        return UIImage()
    }
    
    //MARK: - 生成高清的UIImage
    public static func lcr_setupHighDefinitionUIImage(_ image: CIImage, size: CGFloat) -> UIImage {
        let integral: CGRect = image.extent.integral
        let proportion: CGFloat = min(size/integral.width, size/integral.height)
        
        let width = integral.width * proportion
        let height = integral.height * proportion
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: integral)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: proportion, y: proportion);
        bitmapRef.draw(bitmapImage, in: integral);
        let image: CGImage = bitmapRef.makeImage()!
        return UIImage(cgImage: image)
    }
    
    //image: 二维码 iconImage:头像图片 width: 头像的宽 height: 头像的宽
    public static func lcr_syntheticImage(_ image: UIImage, iconImage:UIImage, width: CGFloat, height: CGFloat) -> UIImage{
        //开启图片上下文
        UIGraphicsBeginImageContext(image.size)
        //绘制背景图片
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let x = (image.size.width - width) * 0.5
        let y = (image.size.height - height) * 0.5
        iconImage.draw(in: CGRect(x: x, y: y, width: width, height: height))
        //取出绘制好的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        //返回合成好的图片
        if let newImage = newImage {
            return newImage
        }
        return UIImage()
    }
    
    //生成边框
    public static func lcr_circleImageWithImage(_ sourceImage: UIImage, borderWidth: CGFloat, borderColor: UIColor) -> UIImage {
        let imageWidth = sourceImage.size.width + 2 * borderWidth
        let imageHeight = sourceImage.size.height + 2 * borderWidth
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth, height: imageHeight), false, 0.0)
        UIGraphicsGetCurrentContext()
        
        let radius = (sourceImage.size.width < sourceImage.size.height ? sourceImage.size.width:sourceImage.size.height) * 0.5
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: imageWidth * 0.5, y: imageHeight * 0.5), radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        bezierPath.lineWidth = borderWidth
        borderColor.setStroke()
        bezierPath.stroke()
        bezierPath.addClip()
        sourceImage.draw(in: CGRect(x: borderWidth, y: borderWidth, width: sourceImage.size.width, height: sourceImage.size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}

extension UIImage{
    
    /// 获取
    ///
    /// - Parameter view: 展示的view
    /// - Returns: 图片大小
    public func lcr_getImageSize(view:UIView) -> CGSize {
        var size = CGSize.zero
        
        let sw = view.bounds.size.width
        let sh = view.bounds.size.height
        
        
        if self.size.width <= sw && self.size.height <= sh{
            return self.size
        }else if self.size.width > sw{
            size.width = sw
            size.height = (self.size.height/self.size.width) * sw
        }else if self.size.height > sh{
            size.height = sh
            size.width = (self.size.width/self.size.height) * sh
        }
        return size
    }
}
