//
//  MuseumDetailBuilder.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 03/07/2022.
//

import Foundation
import UIKit

protocol MuseumDetailModuleBuilding: AnyObject {
    func view(query: String) -> UIViewController
}

class MuseumDetailBuilder: MuseumDetailModuleBuilding {
    
    func view(query: String) -> UIViewController {
        let manager: MuseumDetailsInputs = MuseumDetailsManager(clickedItem: query , apiService: ApiService())
        let viewController = MuseumDetailsViewController(manager: manager)
        return viewController
    }
}
