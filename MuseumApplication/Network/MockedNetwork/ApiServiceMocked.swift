//
//  ApiServiceMocked.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 02/07/2022.
//

import Foundation

final class ApiServiceMocked: MuseumService {
    var isFailure: Bool = false
    func searchMuseums(query: String, completion: @escaping (Result<SearchMuseumResponse, AppError>) -> Void) {
        
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "SearchApiResponseMocked", ofType: "json") else {
            fatalError("File not found")
        }
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert to json")
        }
        
        let jsonData = json.data(using: .utf8)!
        let decodedResult = (try? JSONDecoder().decode(SearchMuseumResponse.self, from: jsonData))!
        isFailure ? completion(.failure(AppError(error: "Error Occured"))) : completion(.success(decodedResult))
    }
    
    func fetchMeuseumDetails(query: String, completion: @escaping (Result<MuseumDetailsModel, AppError>) -> Void) {
        
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "MuseumDetailsResponseMocked", ofType: "json") else {
            fatalError("File not found")
        }
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert to json")
        }
        
        let jsonData = json.data(using: .utf8)!
        let decodedResult = (try? JSONDecoder().decode(MuseumDetailsModel.self, from: jsonData))!
        isFailure ? completion(.failure(AppError(error: "Error Occured"))) : completion(.success(decodedResult))
        
    }
}
