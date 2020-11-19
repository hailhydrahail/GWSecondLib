//
//  String+extension.swift
//  RHeart
//
//  Created by 李鑫 on 2018/5/25.
//  Copyright © 2018年 李鑫. All rights reserved.
//

import Foundation
import UIKit
/**
 * 扩展String
 */

extension Array{
    //数组转json
    func dataTypeTurnJson() -> String {
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        let str = String(data: jsonData, encoding: String.Encoding.utf8)!
        //路径
       // let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
       // let filePath = path.stringByAppendingString("/data666.json")
        //try! str.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        //print(filePath) //取件地址 点击桌面->前往->输入地址跳转取件
        return str
    }
}


extension String {
    //MARK: -去空格
    public func deleteSpaceAndNewLineCharacterSet() ->String {
        let whitespace = CharacterSet.whitespacesAndNewlines
        var temp = self.trimmingCharacters(in: whitespace)
        var tempArr = temp.components(separatedBy: whitespace)
        tempArr = tempArr.filter({ $0 != ""        })
        temp = tempArr.joined(separator: "")
        return temp
    }
    
    //计算文字所占大小
    func rectWithFontSize(_ fontSize:CGFloat, width:CGFloat) -> CGRect {
        let size = CGSize(width: width,height: CGFloat.greatestFiniteMagnitude)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping;
        let  attributes = [
            NSAttributedString.Key.paragraphStyle:paragraphStyle.copy()
                            ]
        
        let text = self as NSString
        let rect = text.boundingRect(
            with: size,
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context:nil)
        
        return rect
    }
    
    func textSizeWithFont(_ font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        var textSize:CGSize!
        if size.equalTo(CGSize.zero) {
            textSize = self.size(withAttributes: [NSAttributedString.Key.font:font] )
        } else {
            let arrtubute = [NSAttributedString.Key.font:font];
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let stringRect = self.boundingRect(with: size, options: option, attributes:arrtubute , context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
    
    //MARK: - 字符串转data
    func stringToByte()->Data? {
        
        let whitespace = CharacterSet.whitespacesAndNewlines
        var temp = self.trimmingCharacters(in: whitespace)
        var tempsArr = temp.components(separatedBy: whitespace)
        tempsArr = tempsArr.filter({ $0 != ""        })
        temp = tempsArr.joined(separator: "")
        
        if temp.count % 2 != 0 {
            return nil
        }
        //   var byte:UnsafePointer<u_char> = UnsafePointer.in
        var int_cha1:UInt8 = 0
        var int_char2:UInt8 = 0
        let data = NSMutableData()
        var c = 0
        _ = temp.utf8.map { (u8) -> UInt8 in
            c += 1
            if c % 2 != 0 {
                if u8 >= 48 && u8 <= 57 {
                    int_cha1 = (u8 - 48) * 16
                    return (u8 - 48) * 16
                }else if u8 >= 97 && u8 <= 102 {
                    int_cha1 = (u8 - 87) * 16
                    return (u8 - 87) * 16
                }else {
                    int_cha1 = 0
                    return 0
                }
            }else {
                if u8 >= 48 && u8 <= 57 {
                    int_char2 = (u8 - 48)
                    
                }else if u8 >= 97 && u8 <= 102 {
                    int_char2 = (u8 - 87)
                    
                }else {
                    int_char2 = 0
                    
                }
                var ch = int_cha1 + int_char2
                data.append(&ch, length: 1)
                return int_char2
            }
            
        }
        return data as Data
    }
    
    
    
    /// 汉字转拼音
    ///
    /// - Parameter isQuanpin: 是否全拼
    /// - Returns: 转换后 的拼音
     func transformToPingyin(isQuanpin:Bool) -> String {
        let muStr:NSMutableString = NSMutableString(string: self)
        
        CFStringTransform(muStr, nil, kCFStringTransformToLatin, false)
        CFStringTransform(muStr, nil, kCFStringTransformStripDiacritics, false)
        
        let pinyinArray = muStr.components(separatedBy: " ")
        
        var allString = ""
        
        if isQuanpin {
            var count = 0
            for _ in 0..<pinyinArray.count {
                for j in 0..<pinyinArray.count {
                    if j == count {
                        allString.append(contentsOf: "#")
                    }
                    allString.append(contentsOf: pinyinArray[j])
                }
                allString.append(contentsOf: ",")
                count += 1
            }
        }
        
        var initialStr = ""
        for str in pinyinArray {
            if str.count > 0 {
                initialStr.append(contentsOf: "\(str.first!)")
            }
        }
        allString = allString + "#\(initialStr)"
        allString = allString + "#\(self)"
        
        return allString
    }

}

extension String{
    
    func contain(subStr: String) -> Bool {return (self as NSString).range(of: subStr).length > 0}
    
    func explode (_ separator: Character) -> [String] {
        return self.split(whereSeparator: { (element: Character) -> Bool in
            return element == separator
        }).map { String($0) }
    }
    
    func replacingOccurrencesOfString(_ target: String, withString: String) -> String{
        return (self as NSString).replacingOccurrences(of: target, with: withString)
    }
    
    func deleteSpecialStr()->String{
    
        return self.replacingOccurrencesOfString("Optional<", withString: "").replacingOccurrencesOfString(">", withString: "")
    }
    
    var floatValue: Float? {return NumberFormatter().number(from: self)?.floatValue}
    var doubleValue: Double? {return NumberFormatter().number(from: self)?.doubleValue}
    
    func repeatTimes(_ times: Int) -> String{
        
        var strM = ""
        
        for _ in 0..<times {
            strM += self
        }
        
        return strM
    }
}

///字符串截取
extension String {
    /// 截取到任意位置
    func subString(to: Int) -> String {
        let index: String.Index = self.index(startIndex, offsetBy: to)
        return String(self[..<index])
    }
    /// 从任意位置开始截取
    func subString(from: Int) -> String {
        let index: String.Index = self.index(startIndex, offsetBy: from)
        return String(self[index ..< endIndex])
    }
    /// 从任意位置开始截取到任意位置
    func subString(from: Int, to: Int) -> String {
        let beginIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[beginIndex...endIndex])
    }
    //使用下标截取到任意位置
    subscript(to: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: to)
        return String(self[..<index])
    }
    //使用下标从任意位置开始截取到任意位置
    subscript(from: Int, to: Int) -> String {
        let beginIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[beginIndex...endIndex])
    }
}
