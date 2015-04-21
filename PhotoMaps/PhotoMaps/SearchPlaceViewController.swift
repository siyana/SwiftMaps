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
    
    @IBOutlet weak var searchBarBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        registerForKeyboardNotifications()
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
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notif: NSNotification) {
        if let userInfo = notif.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.searchBarBottomConstraint.constant = keyboardSize.height
                })
            }
        }
    }
    
    func keyboardWillHide(notif: NSNotification) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.searchBarBottomConstraint.constant = 0
        })
    }
    
    
}
