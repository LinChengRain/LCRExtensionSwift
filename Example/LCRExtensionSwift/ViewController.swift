//
//  ViewController.swift
//  LCRExtensionSwift
//
//  Created by LinChengRain on 11/10/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//

import UIKit
import LCRExtensionSwift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //格式化
        let format = String.lcr_countNumChangeformat(str: "13456661312312")
         
        //打印结果
        print("格式化结果 = \(format)")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

