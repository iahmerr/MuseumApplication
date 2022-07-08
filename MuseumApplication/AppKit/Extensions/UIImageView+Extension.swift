//
//  UIImageView+Extension.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 03/07/2022.
//

import Foundation
import UIKit
import SDWebImage

// MARK: Image loading using SDWebImage

extension UIImageView {
  func loadImage(with url: URL?, placeholder: UIImage? = nil, showsIndicator: Bool = false) {
    sd_imageIndicator = showsIndicator ? SDWebImageActivityIndicator.gray : nil
    sd_setImage(with: url, placeholderImage: placeholder)
  }
}
