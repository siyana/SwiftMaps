//
//  MapViewController.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 3/24/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import UIKit

class MapViewController : UIViewController , CLLocationManagerDelegate, GMSMapViewDelegate
{
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var centerPinImage: UIImageView!
    @IBOutlet weak var centerPinImageVerticalContraint: NSLayoutConstraint!
    
    @IBOutlet weak var segmentControl: UISegmentedControl! {
        didSet {
            segmentControl.selectedSegmentIndex = MapType.MapTypeNormal
        }
    }
    
    @IBOutlet weak var addressLabel: UILabel!
    
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
        
        mapView.delegate = self
    }
    
    // MARK: Actions
    
    @IBAction func segmentControlValueChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
            case MapType.MapTypeNormal: mapView.mapType = kGMSTypeNormal
            case MapType.MapTypeSatellite: mapView.mapType = kGMSTypeSatellite
            case MapType.MapTypeHybrid: mapView.mapType = kGMSTypeHybrid
            default: println("Ooops, something wrong happened here.")
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
    
    
    // MARK: - Geocoding
    
    func reverseGeocodeCoordinate(#coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
       
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                let lines = address.lines as [String]
                self.addressLabel.text = join("\n", lines)
                
                let labelHeight = self.addressLabel.intrinsicContentSize().height
                self.mapView.padding = UIEdgeInsets(top: self.topLayoutGuide.length, left: 0, bottom: labelHeight, right: 0)
                
                UIView.animateWithDuration(0.25) {
                    self.centerPinImageVerticalContraint.constant = ((labelHeight - self.topLayoutGuide.length) * 0.5)
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    // MARK: - GMSMapViewDelegate
    
    func mapView(mapView: GMSMapView!, idleAtCameraPosition position: GMSCameraPosition!) {
        reverseGeocodeCoordinate(coordinate: position.target)
    }
}
