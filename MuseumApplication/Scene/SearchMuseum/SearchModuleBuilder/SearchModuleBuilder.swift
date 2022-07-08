//
//  SearchModuleBuilder.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 03/07/2022.
//

import Foundation
import UIKit

protocol SearchModuleBuilding: AnyObject {
    func view() -> UIViewController
}

final class SearchModuleBuilder: SearchModuleBuilding {
    
    func view() -> UIViewController {
        let manager: SearchMuseumInputs = SearchMuseumManager(service: ApiService())
        let viewController = SearchMuseumViewController(manager: manager, router: SearchModuleFlowControl())
        let navController: UIViewController = UINavigationControllerFactory.createTransparentNavigationController(rootViewController: viewController)
        return navController
    }
}
