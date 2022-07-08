//
//  AppError.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 01/07/2022.
//

import Foundation

public struct AppError: Codable,Error, Equatable {
    let error : String
    
    static func generalError() -> AppError{
        return AppError(error: "some thing went wrong")
    }
}
