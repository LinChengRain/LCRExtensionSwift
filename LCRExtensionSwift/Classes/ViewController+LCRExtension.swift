//
//  ViewController+LCRExtension.swift
//  LCRCategoryKit
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//

import UIKit
import WebKit
extension UIViewController {
    
    
    /// 拨打电话
    ///
    /// - Parameter tel: 电话号码
    public func lcr_callToTel(_ tel:String) {
        // phoneStr:  电话号码
        let phone = "telprompt://" + tel
        if UIApplication.shared.canOpenURL(URL(string: phone)!) {
            UIApplication.shared.openURL(URL(string: phone)!)
        }
    }
    
    public func lcr_showAlter(_ title:String?,message:String?) {
        
        let alter = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "知道了", style: .cancel) { (action) in
        }
        
        alter.addAction(cancelAction)
        present(alter, animated: true, completion: nil)
    }
    /// 一个可操作按钮
    public func lcr_showAlterOneItem(_ title:String?,message:String?,sure:@escaping (()->Void)) {
        
        let alter = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let sureAction = UIAlertAction(title: "知道了", style: .default) { (action) in
            sure()
        }
        alter.addAction(sureAction)
        present(alter, animated: true, completion: nil)
    }
    
    /// 系统提示弹窗
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 信息
    ///   - sure: 确定回调
    public func lcr_showAlter(_ title:String?,message:String?,sure:@escaping (()->Void)) {
        
        lcr_showAlter(title, message: message, sureColor: nil, sure: sure)
    }
    
    /// 系统提示弹窗
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 信息
    ///   - sureColor: 确认按钮颜色
    ///   - sure: 确定回调
    public func lcr_showAlter(_ title:String?,message:String?,sureColor:UIColor?,sure:@escaping (()->Void)) {
        
        let alter = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
        }
        
        let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in
            sure()
        }
        
        if sureColor != nil {
            sureAction.setValue(sureColor, forKey: "titleTextColor")
            cancelAction.setValue(UIColor(lcr_hexString: "0x999999"), forKey: "titleTextColor")
        }
        
        alter.addAction(cancelAction)
        alter.addAction(sureAction)
        
        present(alter, animated: true, completion: nil)
    }
    
    /// 系统提示弹窗（无取消按钮）
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 信息
    ///   - sureColor: 确认按钮颜色
    ///   - sure: 确定回调
    public func lcr_showAlterNoCancel(_ title:String?,message:String?,_ sureColor:UIColor?,sure:@escaping (()->Void)) {
        
        let alter = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in
            sure()
        }
        
        if sureColor != nil {
            sureAction.setValue(sureColor, forKey: "titleTextColor")
        }
        
        alter.addAction(sureAction)
        
        present(alter, animated: true, completion: nil)
    }
    
    /// 系统提示弹窗
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 信息
    ///   - sure: 确定回调
    public func lcr_showAlterForPicture(response:@escaping ((Int)->Void)) {
        
        let alter = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
        }
        
        let ablumAction = UIAlertAction(title: "相册", style: .default) { (action) in
            response(0)
            
        }
        let cameraAction = UIAlertAction(title: "拍照", style: .default) { (action) in
            response(1)
        }
        
        alter.addAction(cancelAction)
        alter.addAction(ablumAction)
        alter.addAction(cameraAction)
        
        present(alter, animated: true, completion: nil)
    }
}


extension UIViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate, PropertyStoring {
    
    public typealias T = String
    public typealias AlbumT = Int
    private struct CustomProperties {
        static var imgType = UIImagePickerController.InfoKey.originalImage
        static var isAlbum = UIImagePickerController.SourceType.photoLibrary
    }
    var imgType: String {
        get {
            return getAssociatedObject(&CustomProperties.imgType, defaultValue: CustomProperties.imgType.rawValue)
        }
        set {
            return objc_setAssociatedObject(self, &CustomProperties.imgType, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var albumType: Int {
        get {
            return getAssociatedObject(&CustomProperties.isAlbum, defaultValue: CustomProperties.isAlbum.rawValue)
        }
        set {
            return objc_setAssociatedObject(self, &CustomProperties.isAlbum, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func invokingSystemAlbumOrCamera(type: String, albumT: Int) -> Void {
        
        self.imgType = type
        self.albumType = albumT
        if albumT == UIImagePickerController.SourceType.photoLibrary.rawValue {
            self.invokeSystemPhoto()
        }else {
            self.invokeSystemCamera()
        }
    }
    
    func invokeSystemPhoto() -> Void {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = false
            imagePickerController.modalPresentationStyle = .fullScreen
            if self.imgType == UIImagePickerController.InfoKey.editedImage.rawValue {
                imagePickerController.allowsEditing = true
            }else {
                imagePickerController.allowsEditing = false
            }
            //            if #available(iOS 11.0, *) {
            //                UIScrollView.appearance().contentInsetAdjustmentBehavior = .automatic
            //            }
            self.present(imagePickerController, animated: true, completion: nil)
        }else {
            print("请打开允许访问相册权限")
        }
    }
    
    func invokeSystemCamera() -> Void {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .camera
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = false
            imagePickerController.cameraCaptureMode = .photo
            imagePickerController.modalPresentationStyle = .fullScreen
            imagePickerController.mediaTypes = ["public.image"]
            self.imgType = UIImagePickerController.InfoKey.originalImage.rawValue
            //            if #available(iOS 11.0, *) {
            //                UIScrollView.appearance().contentInsetAdjustmentBehavior = .automatic
            //            }
            self.present(imagePickerController, animated: true, completion: nil)
        }else {
            print("请打开允许访问相机权限")
        }
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //        if #available(iOS 11.0, *) {
        //            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        //        }
        picker.dismiss(animated: true, completion: {
            
            let img: Any = info[self.imgType] as Any
            if (img is UIImage) {
                if self.albumType == UIImagePickerController.SourceType.photoLibrary.rawValue {
                    self.reloadViewWithImg(img: img as! UIImage)
                }else {
                    self.reloadViewWithCameraImg(img: img as! UIImage)
                }
            }else {
                
            }
        })
    }
    
    @objc func reloadViewWithImg(img: UIImage) -> Void {
        
    }
    
    @objc func reloadViewWithCameraImg(img: UIImage) -> Void {
        
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        //        if #available(iOS 11.0, *) {
        //            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        //        }
        self.dismiss(animated: true, completion: nil)
    }
}


public protocol PropertyStoring {
    
    associatedtype T
    associatedtype AlbumT
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: T) -> T
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: AlbumT) -> AlbumT
}

public extension PropertyStoring {
    
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: T) -> T {
        guard let value = objc_getAssociatedObject(self, key) as? T else {
            return defaultValue
        }
        return value
    }
    
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: AlbumT) -> AlbumT {
        guard let value = objc_getAssociatedObject(self, key) as? AlbumT else {
            return defaultValue
        }
        return value
    }
}


extension UIViewController {
    
    static func topViewController(_ viewController: UIViewController? = nil) -> UIViewController? {
        let viewController = viewController ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = viewController as? UINavigationController,
            !navigationController.viewControllers.isEmpty
        {
            return self.topViewController(navigationController.viewControllers.last)
            
        } else if let tabBarController = viewController as? UITabBarController,
            let selectedController = tabBarController.selectedViewController
        {
            return self.topViewController(selectedController)
            
        } else if let presentedController = viewController?.presentedViewController {
            return self.topViewController(presentedController)
        }
        return viewController
    }
    // MARK: - 查找顶层控制器、
    // 获取顶层控制器 根据window
    func getTopVC() -> (UIViewController?) {
        var window = UIApplication.shared.keyWindow
        //是否为当前显示的window
        if window?.windowLevel != UIWindow.Level.normal{
            let windows = UIApplication.shared.windows
            for  windowTemp in windows{
                if windowTemp.windowLevel == UIWindow.Level.normal{
                    window = windowTemp
                    break
                }
            }
        }
        let vc = window?.rootViewController
        return UIViewController.topViewController(vc)
    }
}
