//
//  UIViewController+Extension.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 01/07/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

extension UIViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    
    func showError(error: AppError, errorTitle: String="Error", cancelTitle: String="OK") {
        let controller = UIAlertController.init(title: errorTitle, message: error.error, preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction.init(title: cancelTitle, style: .cancel) {[weak self] (action) in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        controller.addAction(cancel)
        self.present(controller, animated: true, completion: nil)
    }
    
    
    func addAndShowActivity() {
        addActivityIndicatory()
        showActivityIndicatory()
    }
    func addActivityIndicatory() {
        DispatchQueue.main.async {
            let container: UIView = UIView()
            container.frame = self.view.frame
            container.center = CGPoint(x: self.view.center.x,y: self.view.center.y)
            container.tag = 999
            container.backgroundColor = UIColor.clear
            container.isHidden = true
            
            let loadingView: UIView = UIView()
            loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            loadingView.center = self.view.center
            loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            
            let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
            activityIndicator.style =
                UIActivityIndicatorView.Style.large
            activityIndicator.color = UIColor.greyLight
            activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,
                                               y: loadingView.frame.size.height / 2);
            loadingView.addSubview(activityIndicator)
            container.addSubview(loadingView)
            self.view.addSubview(container)
        
         activityIndicator.startAnimating()
        }
    }
    
    func showActivityIndicatory() {
        DispatchQueue.main.async {
            guard let activity = self.view.viewWithTag(999) else {
                return
            }
            activity.isHidden = false
        }
    }
    
    func removeActivity(){
        DispatchQueue.main.async {
            guard let activity = self.view.viewWithTag(999) else {
                return
            }
            activity.isHidden = true
        }
    }
}
