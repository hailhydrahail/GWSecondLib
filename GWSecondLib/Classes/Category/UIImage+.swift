//
//  UIImage+.swift
//  RHeart
//
//  Created by 李鑫 on 2018/5/28.
//  Copyright © 2018年 李鑫. All rights reserved.
//

import UIKit

extension UIImage {
    func zipImage(scaleSize:CGFloat,percent: CGFloat) -> Data{
        //压缩图片尺寸
        UIGraphicsBeginImageContext(CGSize(width: self.size.width*scaleSize, height: self.size.height*scaleSize))
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width*scaleSize, height:self.size.height*scaleSize))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //高保真压缩图片质量
        //UIImageJPEGRepresentation此方法可将图片压缩，但是图片质量基本不变，第二个参数即图片质量参数。
        
        let imageData: Data = newImage.jpegData(compressionQuality: percent)!
        return imageData
    }
    
    ///裁剪圆形图片
    func clipImage() -> UIImage {
        //1.开启图形上下文
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        //2.描述圆形裁剪区域
        let bezierPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        //3.设置裁剪区域
        bezierPath.addClip()
        //4.开始绘图
        self.draw(at: CGPoint.zero)
        //5.取出图片
        let clipImage = UIGraphicsGetImageFromCurrentImageContext()
        //6.关闭图形上下文
        UIGraphicsEndImageContext()
        
        return clipImage ?? UIImage()
    }
    
    func compressImageOnlength(maxLength: Int) -> Data? {
        let maxL = maxLength * 1024 * 1024
        var compress:CGFloat = 0.9
        let maxCompress:CGFloat = 0.1
        var imageData = self.jpegData(compressionQuality: compress)
        while (imageData?.count)! > maxL && compress > maxCompress {
            compress -= 0.1
            imageData = self.jpegData(compressionQuality: compress)
        }
        return imageData
    }
}

