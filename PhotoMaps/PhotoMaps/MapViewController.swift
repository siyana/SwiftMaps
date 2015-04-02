//
//  MapViewController.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 3/24/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import UIKit

class MapViewController : UIViewController , CLLocationManagerDelegate
{
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var centerPinImage: UIImageView!
    @IBOutlet weak var segmentControl: UISegmentedControl! {
        didSet {
            segmentControl.selectedSegmentIndex = MapType.MapTypeNormal
        }
    }
    
    private let locationManager = CLLocationManager()
    
    private struct MapType{
        static let MapTypeNormal = 0
        static let MapTypeSatellite = 1
        static let MapTypeHybrid = 2
    }
    
    // MARK: - ViewController Lyfe cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: Actions
    
    @IBAction func segmentControlValueChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case MapType.MapTypeNormal: mapView.mapType = kGMSTypeNormal
        case MapType.MapTypeSatellite: mapView.mapType = kGMSTypeSatellite
        case MapType.MapTypeHybrid: mapView.mapType = kGMSTypeHybrid
        default: println("Ooops, something wrong happens here.")
        }
    }

    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
            
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = locations.first as? CLLocation {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
        }
    }
    
}
