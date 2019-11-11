//
//  ApiClient.swift
//  Dott-test
//
//  Created by Damir Ramic on 08/11/2019.
//  Copyright © 2019 Damir Ramich. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import CoreLocation



protocol ApiClientProtocol {
    func getVenues(location:CLLocation,timeStamp:String) -> Observable<Response>
}

class ApiClient : ApiClientProtocol {

    // MARK: - GetVenues
    enum GetVenuesFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
  //  typealias GetVenuesResult = Result<Response , GetVenuesFailureReason>
   // typealias GetVenuseCompletion = (_ result:GetVenuesResult)-> Observable<Void>
   
    let url = Environments.VenuesUrl + "&categoryId=4d4b7105d754a06374d81259"
    
    func getVenues(location:CLLocation,timeStamp:String) -> Observable<Response> {
        return Observable.create{ observer in
            let long = location.coordinate.longitude.description
            let lat = location.coordinate.latitude.description
            AF.request(self.url + "&ll=\(lat),\(long)" + "&v=\(timeStamp)"+"&radius=5000")
               .validate()
                  .responseJSON { response in
                      switch response.result {
                      case .success:
                          do {
                              guard let data = response.data else {
                                observer.onError(GetVenuesFailureReason.notFound)
                                  return
                              }

                            let venues = try JSONDecoder().decode(Response.self, from: data)
                            observer.onNext(venues)
                            observer.onCompleted()
                          } catch {
                            observer.onError(GetVenuesFailureReason.notFound)
                          }
                      case .failure(_):
                          if let statusCode = response.response?.statusCode,
                              let reason = GetVenuesFailureReason(rawValue: statusCode) {
                              observer.onError(GetVenuesFailureReason.notFound)
                          }
                          observer.onError(GetVenuesFailureReason.notFound)
                      }
                }
            
            return Disposables.create()
        }
    }
}
