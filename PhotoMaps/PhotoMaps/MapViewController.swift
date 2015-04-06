//
//  MapViewController.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 3/24/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import UIKit

private struct MapType{
    static let MapTypeNormal = 0
    static let MapTypeSatellite = 1
    static let MapTypeHybrid = 2
}

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
    private let dataProvider = GoogleDataProvider()
    
    private var mapRadius: Double {
        get {
            let region = mapView.projection.visibleRegion()
            let verticalDistance = GMSGeometryDistance(region.farLeft, region.nearLeft)
            let horizontalDistance = GMSGeometryDistance(region.farLeft, region.farRight)
            return max(horizontalDistance, verticalDistance)*0.5
        }
    }
    
    private var randomLineColor: UIColor {
        get {
            let randomRed = CGFloat(drand48())
            let randomGreen = CGFloat(drand48())
            let randomBlue = CGFloat(drand48())
            return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        }
    }
    
    private var searchTypes: [String]?
    // MARK: - ViewController Lyfe cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        
        searchTypes = GlobalConstants.DefaulPlacesTypes
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
            
            fetchNearbyPlaces(location.coordinate)
        }
    }
    
    
    // MARK: - Geocoding
    
    func reverseGeocodeCoordinate(#coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
       
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                let lines = address.lines as [String]
                self.addressLabel.text = join(", ", lines)
                self.updateAdressLabel()
            }
        }
    }
    
    // MARK: - GMSMapViewDelegate
    
    func mapView(mapView: GMSMapView!, idleAtCameraPosition position: GMSCameraPosition!) {
        reverseGeocodeCoordinate(coordinate: position.target)
    }
    
    // MARK: - Rotation
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        self.updateAdressLabel()
    }
    
    // MARK: Help methods
    
    func updateAdressLabel() {
        let labelHeight = self.addressLabel.intrinsicContentSize().height
        
        UIView.animateWithDuration(0.25) {
            self.mapView.padding = UIEdgeInsets(top: self.topLayoutGuide.length, left: 0, bottom: labelHeight, right: 0)
            self.centerPinImageVerticalContraint.constant = ((labelHeight - self.topLayoutGuide.length) * 0.5)
            self.view.layoutIfNeeded()
        }

    }
    
    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        // 1
        mapView.clear()
        // 2
        dataProvider.fetchPlacesNearCoordinate(coordinate: coordinate, radius: mapRadius, types: searchTypes ?? GlobalConstants.DefaulPlacesTypes) { places in
            for place: GooglePlace in places {
                // 3
                let marker = PlaceMarker(place: place)
                // 4
                marker.map = self.mapView
            }
        }
    }
    
    func mapView(mapView: GMSMapView!, markerInfoContents marker: GMSMarker!) -> UIView! {
        // 1
        let placeMarker = marker as PlaceMarker
        
        // 2
        
        if let infoView = NSBundle.mainBundle().loadNibNamed("MarkerInfoView", owner: self, options: nil)[0] as? MarkerInfoView{
            // 3
            infoView.placeLabel.text = placeMarker.place.name
            
            // 4
            if let photo = placeMarker.place.photo {
                infoView.image = photo
            } else {
                infoView.image = UIImage(named: "generic")
            }
//            let containerView = UIView(frame: CGRect(x: 0,y: 0,width: 160,height: 150))
//            containerView.addSubview(infoView)
            
            return infoView
        } else {
            return nil
        }
    }
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
        let googleMarker = mapView.selectedMarker as PlaceMarker
        
        dataProvider.fetchDirectionsFrom(mapView.myLocation.coordinate, to: googleMarker.place.coordinate) {optionalRoute in
            if let encodedRoute = optionalRoute {
                // 3
                let path = GMSPath(fromEncodedPath: encodedRoute)
                let line = GMSPolyline(path: path)
                
                // 4
                line.strokeWidth = 4.0
                line.tappable = true
                line.map = self.mapView
                line.strokeColor = self.randomLineColor
                
                // 5
                mapView.selectedMarker = nil
            }
        }
    }
}
