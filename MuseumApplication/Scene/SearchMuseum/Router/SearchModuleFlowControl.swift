//
//  SearchModuleFlowControl.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 04/07/2022.
//

import Foundation
import UIKit

protocol SearchModuleRouteable: AnyObject {
    func navigateToDetails(with query: String, nav: UINavigationController)
}

final class SearchModuleFlowControl: SearchModuleRouteable {
    
    func navigateToDetails(with query: String, nav: UINavigationController) {
        guard let objId = Int(query) else { return }
        let viewController = MuseumDetailBuilder().view(query: "\(objId)")
        nav.pushViewController(viewController, animated: true)
    }
}
