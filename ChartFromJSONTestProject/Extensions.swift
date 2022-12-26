//
//  Extensions.swift
//  ChartFromJSONTestProject
//
//  Created by Andrei Nechitailo on 21.12.2022.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(rgbString: String) {
        var rgbStr = rgbString
        if (rgbStr.hasPrefix("#")) {
            rgbStr.remove(at: rgbStr.startIndex)
        }
        
        var rgbInt: UInt64 = 0
        Scanner(string: rgbStr).scanHexInt64(&rgbInt)
        
        self.init(rgb: Int(rgbInt))
    }
}

extension UIView {
    convenience init(color: UIColor) {
        self.init()
        self.backgroundColor = color
    }
}

extension UILabel {
    convenience init(text: String, color: UIColor) {
        self.init()
        self.text = text
        self.textColor = color
    }
}

extension String {
    init(float: CGFloat) {
        self.init()
        self = String(format: "%.2f", float)
    }
}
