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
import RxGoogleMaps
class VenueViewModel   {
    
    let apiClient : ApiClient = ApiClient()
    let disposeBag = DisposeBag()
    let locationManager : CLLocationManager = CLLocationManager()
     public let venuesList : BehaviorRelay<Response?> = BehaviorRelay(value: nil)
    var radius : String = "5000"
    var currentZoom : Float = Float()
    init(apiClient: ApiClient = ApiClient()) {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingHeading()
        locationManager.rx
        .location
        .filter{ $0 != nil }
        .flatMap { location -> Observable<Response> in
            return apiClient.getVenues(location: location!, timeStamp: Date().toDate(withFormat: "yyyyMMdd"), radius: self.radius)
        }.subscribe(onNext: {[weak self] response in
            self?.venuesList.accept(response)
            //self!.locationManager.stopUpdatingLocation()
        }).disposed(by: disposeBag)
        
        currentZoom = 9
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
            
        
            mapView.rx.didChange.asDriver()
                .drive(onNext: {
                    if ($0.zoom < 11 && self.radius != "20000"){
                        self.radius = "20000"
                        self.apiClient.getVenues(location: self.locationManager.location!, timeStamp: Date().toDate(withFormat: "yyyyMMdd"),radius: self.radius).subscribe(onNext:{[weak self] response in
                            self?.venuesList.accept(response)
                        }).disposed(by: self.disposeBag)
                    }
                print("Did change position: \($0)") })
            .disposed(by: disposeBag)
    
        }
    }
}

