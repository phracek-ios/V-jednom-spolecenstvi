//
//  SvatiColors.swift
//  Svati
//
//  Created by Petr Hracek on 17.07.2023.
//

import Foundation
import DynamicColor
import UIKit

extension UIColor {
    struct SvatiColor {
        static func mainTextColor() -> UIColor {
            return UIColor(hexString: "#F8F8F8")
        }
        
        static func mainBackColor() -> UIColor {
            return UIColor(hexString: "#930A14")
        }
        static func darkGreenColor() -> UIColor {
            return UIColor(hexString: "246126")
        }
        static func lightGreenColor() -> UIColor {
            return UIColor(hexString: "2f7d32")
        }
        static func textLightColor() -> UIColor {
            return UIColor.black
        }
        
        static func textNightColor() -> UIColor {
            return UIColor.white
        }
        
        static func backLightColor() -> UIColor {
            return UIColor.white
        }
        
        static func backNightColor() -> UIColor {
            return UIColor.black
        }
        
        static func yellowColor() -> UIColor {
            return UIColor.yellow
        }
        
        static func inActiveColor() -> UIColor {
            return UIColor.white.withAlphaComponent(0.7)
        }
        
    }
}
