//
//  UIView+Extension.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 03/07/2022.
//

import Foundation
import UIKit

extension UIView {
    
  func pinToSuperView() {
    guard let superview = superview else {
      return
    }
    translatesAutoresizingMaskIntoConstraints = false
    superview.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    superview.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    superview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    superview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }

  func pin(
    to view: UIView,
    padding: (leading: CGFloat, trailing: CGFloat, top: CGFloat, bottom: CGFloat) = (0, 0, 0, 0)
  ) {
    translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.leading),
      trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding.trailing),
      topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top),
      bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: padding.bottom)
    ])
  }

  func centerInSuperView() {
    guard let superview = superview else {
      fatalError("View has no superview")
    }
    translatesAutoresizingMaskIntoConstraints = false
    superview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    superview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }
}
