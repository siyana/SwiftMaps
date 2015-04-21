//
//  SearchPlaceViewController.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 4/21/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import UIKit

class SearchPlaceViewController: UIViewController, UISearchBarDelegate, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchedText = searchBar.text {
            GoogleDataProvider().fetchPlaceFromText(searchedText) { (googlePlaces) -> Void in
                if googlePlaces.count > 0 {
                    for place: GooglePlace in googlePlaces {
                        // 3
                        let marker = PlaceMarker(place: place)
                        // 4
                        marker.map = self.mapView
                    }
                    let mainPlace = googlePlaces.first!
                    self.mapView.camera = GMSCameraPosition(target: mainPlace.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
                    
                }
            }
        }
    }
    
    
    
}
