//
//  GooglePlace.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 4/3/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import UIKit

class GooglePlace {
   
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    let placeType: String
    let photoReference: String?
    var photo: UIImage?
    
    struct PlacesDictionaryKeys {
        static let Name = "name"
        static let Address = "vicinity"
        static let LocationOne = "geometry"
        static let LocationTwo = "location"
        static let Latitude = "lat"
        static let Longitude = "lng"
        static let Photos = "photos"
        static let PhotoReference = "photo_reference"
        static let Types = "types"
    }
    
    init(dictionary:NSDictionary, acceptedTypes: [String]) {
        name = dictionary[PlacesDictionaryKeys.Name] as String
        address = dictionary[PlacesDictionaryKeys.Address] as String
        
        let location = dictionary[PlacesDictionaryKeys.LocationOne]?[PlacesDictionaryKeys.LocationTwo] as NSDictionary
        let lat = location[PlacesDictionaryKeys.Latitude] as CLLocationDegrees
        let lng = location[PlacesDictionaryKeys.Longitude] as CLLocationDegrees
        coordinate = CLLocationCoordinate2DMake(lat, lng)
        
        if let photos = dictionary[PlacesDictionaryKeys.Photos] as? NSArray {
            let photo = photos.firstObject as NSDictionary
            photoReference = photo[PlacesDictionaryKeys.PhotoReference] as? NSString
        }
        
        var foundType = ""
        let possibleTypes = acceptedTypes
        for type in dictionary[PlacesDictionaryKeys.Types] as [String] {
            if contains(possibleTypes, type) {
                foundType = type
                break
            }
        }
        placeType = foundType

    }
    
    
}
