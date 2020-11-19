//
//  GWTipBackView.swift
//  GWSecondLib_Example
//
//  Created by iOS on 2020/11/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class GWTipBackView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var tipView: UIView!

    @IBOutlet weak var tipTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupContentView()
    }
    
    func setupContentView() {
        
    }
}
