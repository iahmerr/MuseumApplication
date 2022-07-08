//
//  UIImageViewFactory.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 30/06/2022.
//

import Foundation
import UIKit

public final class UIImageViewFactory {
    
    public class func createImageView(mode: UIImageView.ContentMode = .scaleAspectFill, image: UIImage? = nil, tintColor: UIColor = .clear) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = mode
        imageView.tintColor = tintColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.clipsToBounds = true
        return imageView
    }
}
