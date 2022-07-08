//
//  Color.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 30/06/2022.
//

import Foundation
import UIKit

public enum AppColorType {
    case grey
    case greyDark
    case greyLight
    case greyExtraLight
    case white
    case black
    case vintage
    case cellLight
    case appBackgroundColor
}

public extension UIColor {
    static func appColor(ofType colorType: AppColorType, forTheme theme: AppColorTheme = AppTheme.shared.colorTheme) -> UIColor {
        
        switch ( colorType) {
        case (.grey):                     return #colorLiteral(red: 0.7879999876, green: 0.7839999795, blue: 0.8470000029, alpha: 1)
        case (.greyLight):                return #colorLiteral(red: 0.8549019608, green: 0.878000021, blue: 0.9409999847, alpha: 1)
        case (.greyExtraLight):           return #colorLiteral(red: 0.9294117647, green: 0.9411764706, blue: 0.9725490196, alpha: 1)
        case (.greyDark):                 return #colorLiteral(red: 0.5764705882, green: 0.5690000057, blue: 0.6940000057, alpha: 1)
        case (.white):                    return .white
        case (.black):                    return .black
        case (.vintage):                  return #colorLiteral(red: 0.462745098, green: 0.3450980392, blue: 0.2352941176, alpha: 1)
        case (.cellLight):                return #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.9764705882, alpha: 1)
        case (.appBackgroundColor):       return #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        }
    }
    
    static var grey: UIColor {
        return appColor(ofType: .grey)
    }
    
    static var greyDark: UIColor {
        return appColor(ofType: .greyDark)
    }
    
    static var greyLight: UIColor {
        return appColor(ofType: .greyLight)
    }
    
    static var greyExtraLight: UIColor {
        return appColor(ofType: .greyExtraLight)
    }
    static var cellLight: UIColor {
        return appColor(ofType: .cellLight)
    }
    
    static var appBackgroundColor: UIColor {
        return appColor(ofType: .appBackgroundColor)
    }
}
