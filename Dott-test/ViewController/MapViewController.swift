    //
    //  MapViewController.swift
    //  Dott-test
    //
    //  Created by Damir Ramic on 09/11/2019.
    //  Copyright © 2019 Damir Ramich. All rights reserved.
    //
    
    import UIKit
    import RxSwift
    import RxCocoa
    import RxCoreLocation
    import GoogleMaps
    
    class MapViewController: UIViewController,GMSMapViewDelegate {
        
        var mapView: MapView!
        var viewModel : VenueViewModel!
        let disposeBag = DisposeBag()
        var timeStamp : String!
        
        var currentZoomLevel : Float = Float()
        
        var tappedMarker : GMSMarker?
        var customInfoWindow : CustomInfoWindow = CustomInfoWindow()
        var venuesList : BehaviorRelay<Response?> = BehaviorRelay(value: nil)
        
        override func viewDidLoad() {
            super.viewDidLoad()
            viewModel = VenueViewModel()
            mapView = MapView()
            mapView.frame = UIScreen.main.bounds
            view.addSubview(mapView)
            setupRx()
            self.tappedMarker = GMSMarker()
            customInfoWindow = customInfoWindow.loadView()
            
            mapView.delegate = self
            self.view = mapView
            mapView.setMinZoom(9, maxZoom: mapView.maxZoom)
            currentZoomLevel  = 12
        }
        
        
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            return false
        }
        
        func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
            customInfoWindow.titleRestaurant.text = marker.title
            customInfoWindow.moreInfo.text = marker.snippet
            return self.customInfoWindow
        }
        
        func setupRx() {
            
            viewModel.venuesList.subscribe(onNext:{
                if (($0?.response.venues.count) != nil) {
                    self.viewModel.drawMarkes(mapView: self.mapView)
                }
            }).disposed(by:disposeBag)
        }
        
        func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
            
        }
        
        func centerMe(location:CLLocation) {
            mapView.camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 9)
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to find user's location: \(error.localizedDescription)")
        }
    }
