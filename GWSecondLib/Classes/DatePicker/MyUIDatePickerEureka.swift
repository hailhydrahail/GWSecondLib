//
//  MyUIDatePicker.swift
//  RHeart
//
//  Created by 李鑫 on 2018/5/31.
//  Copyright © 2018年 李鑫. All rights reserved.
//

import UIKit
/**
 * 获取日期回调
 */


typealias PickerGetDateActionEureka = (_ date:Date?) -> ()

/**
 * pickerDate 弹出
 */
class MyUIDatePickerEureka: BaseAlertView {
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var pickerDate: UIDatePicker!
    var pickerGetDateAction:PickerGetDateActionEureka!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.y = Height
    }
    
    init() {
        super.init( frame:  CGRect(x: 0, y: Height, width: Width, height: 197))
    }
    
    @IBAction func cancel(_ sender: UIButton) {
 
        if self.pickerGetDateAction != nil {
            self.pickerGetDateAction(nil)
        }
  
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if self.pickerGetDateAction != nil {
            self.pickerGetDateAction(pickerDate.date)
        }
//        cancel(sender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
