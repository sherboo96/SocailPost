//
//  APIService.swift
//  RXSwitProject
//
//  Created by Mahmoud Sherbeny on 10/05/2021.
//

import Foundation
import Alamofire
import KRProgressHUD

class APIServices {
    private init() {}
    static let instance = APIServices()
    func getData<T: Decodable, E: Decodable>(url: String, method: HTTPMethod ,params: Parameters? = nil, headers: HTTPHeaders? = nil,completion: @escaping (T?, E?, Error?)->()) {
        
        var encoding: ParameterEncoding = URLEncoding.default
        switch method {
        case .get,.delete:
            encoding = URLEncoding.default
        case .post:
            encoding = JSONEncoding.prettyPrinted
        case .put, .patch:
            encoding = JSONEncoding.default
        default:
            break
        }
        
        AF.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                if APIServices.isConnectedToInternet() {
                    switch response.result {
                    case .success(_):
                        guard let data = response.data else { return }
                        do {
                            let jsonData = try JSONDecoder().decode(T.self, from: data)
                            completion(jsonData, nil, nil)
                        } catch let jsonError {
                            print(jsonError)
                        }
                        
                    case .failure(let error):
                        guard let data = response.data else {
                            completion(nil, nil, error)
                            return }
                        guard let statusCode = response.response?.statusCode else {
                            completion(nil, nil, error)
                            return }
                        switch statusCode {
                        case 400..<500:
                            do {
                                let jsonError = try JSONDecoder().decode(E.self, from: data)
                                completion(nil, jsonError, nil)
                            } catch let jsonError {
                                print(jsonError)
                            }
                        default:
                            completion(nil, nil, error)
                        }
                    }
                } else {
                    KRProgressHUD.showError(withMessage: "No Internet")
                    completion(nil, "error" as? E, nil)
                    DispatchQueue.main.asyncAfter(deadline: .now()+5) {
                       KRProgressHUD.dismiss()
                    }
                }
            }
    }
    
    //MARK: - Reachability
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
