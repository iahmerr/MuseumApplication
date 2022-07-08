//
//  ApiService.swift
//  MuseumApplication
//
//  Created by Ahmer Hassan on 01/07/2022.
//

import Foundation

protocol MuseumService: AnyObject {
    func searchMuseums(query: String, completion: @escaping(Result<SearchMuseumResponse,AppError>) -> Void)
    func fetchMeuseumDetails(query: String, completion: @escaping(Result<MuseumDetailsModel,AppError>) -> Void)
}

final class ApiService: MuseumService {
    
    private let request: ApiRequest
    init(request: ApiRequest = APIClient()){
        self.request = request
    }
    
    func searchMuseums(query: String, completion: @escaping(Result<SearchMuseumResponse,AppError>) -> Void){
        let queryItems: [String : String] = ["q": query, "hasImages" : "true"]
        let router: URLRequestConvertible = Endpoint(route: .searchMuseum, method: .get, queryItems: queryItems)
        self.request.performRequest(router: router){ (result: Result<SearchMuseumResponse, AppError>) in
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
    
    func fetchMeuseumDetails(query: String, completion: @escaping (Result<MuseumDetailsModel, AppError>) -> Void) {
        let router: URLRequestConvertible = Endpoint(route: .getMeuseumDetails, method: .get, path: [query])
        
        self.request.performRequest(router: router) { (result: Result<MuseumDetailsModel, AppError>) in
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
}
