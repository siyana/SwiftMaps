//
//  PlaceMarker.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 4/3/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import UIKit

class PlaceMarker: GMSMarker {
    let place: GooglePlace
    
    init(place: GooglePlace) {
        self.place = place
        super.init()
        
        position = place.coordinate
        if let placeType = place.placeType {
            icon = UIImage(named: place.placeType!+"_pin")
        } else {
            icon = UIImage(named: "icon_me")
        }
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = kGMSMarkerAnimationPop
    }
}
