//
//  VenueViewModel.swift
//  Dott-test
//
//  Created by Damir Ramic on 08/11/2019.
//  Copyright © 2019 Damir Ramich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation
import GoogleMaps

class VenueViewModel   {
    

   // public let venuesList : BehaviorRelay<Response>
    //public var location : Observable<CLLocation>
    let apiClient : ApiClient = ApiClient()
    let disposeBag = DisposeBag()
 
    let timeStamp : String = "20191110"
    
    // input
   // public let fetchVenues = PublishRelay<Void>()
   
    //public let timeStamp = PublishSubject<String>()
    
    let locationManager : CLLocationManager = CLLocationManager()
    
     public let venuesList : BehaviorRelay<Response?> = BehaviorRelay(value: nil)
    // Output
    
  //  public let timeStampCalculated : Observable<Bool>
   // public let venuesReady : Observable<Bool>
    
    init(apiClient: ApiClient = ApiClient()) {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        locationManager.rx
        .location
        .filter{ $0 != nil }
        .flatMap { location -> Observable<Response> in
            return apiClient.getVenues(location: location!, timeStamp: Date().toDate(withFormat: "yyyyMMdd"))
        }.subscribe(onNext: {[weak self] response in
            self?.venuesList.accept(response)
        }).disposed(by: disposeBag)
    }
    
    
    func drawMarkes(mapView:GMSMapView) {
        venuesList.value?.response.venues.forEach {restaurant in
        
            //
            mapView.camera = GMSCameraPosition.camera(withLatitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom: 12)
            
            let lat = restaurant.location?.lat as! CLLocationDegrees
            let long = restaurant.location?.lng as! CLLocationDegrees
            let position = CLLocationCoordinate2D(latitude:lat,longitude: long)
                let marker = GMSMarker(position: position)
                marker.title = restaurant.name
            marker.snippet = restaurant.location?.formattedAddress?.joined(separator: "-")
                marker.map = mapView
        }
    }
}

