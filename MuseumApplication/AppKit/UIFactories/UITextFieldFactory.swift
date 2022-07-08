//
//  UITextFieldFactory.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 30/06/2022.
//

import Foundation
import UIKit

public final class UITextFieldFactory {
    
    public class func
    createTextField(placeHolderText: String,
                    textAlignment: NSTextAlignment = .center,
                    autoCapitalisationType: UITextAutocapitalizationType = .none,
                    returnKeyType: UIReturnKeyType = .done,
                    clearButtonMode: UITextField.ViewMode = .whileEditing,
                    backgroundColor: UIColor = .clear,
                    autoCorrectType: UITextAutocorrectionType = .no )-> UITextField {
        let textfield = UITextField()
        textfield.placeholder = placeHolderText
        textfield.autocapitalizationType  = autoCapitalisationType
        textfield.returnKeyType = returnKeyType
        textfield.clearButtonMode = clearButtonMode
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.autocorrectionType = autoCorrectType
        textfield.backgroundColor = backgroundColor
        textfield.textAlignment = textAlignment
        return textfield
    }
}
