//
//  Constants.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 4/3/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import Foundation

struct GlobalConstants {
    static let googleApiKey = "AIzaSyCc2Q0KJTkrlGyy1VngwrAv2p5A4dDzaEM"
    static let fivePxApiKey = "gcPbfcflqrmAtJn5qdw55u2Eyf0elU4SICm7SfWM" //500px API key
    
    //MARK - Data
    
    static let DefaulPlacesTypes = [PlacesSection(name: "food",items: ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]),
        PlacesSection(name: "entertaiment", items: ["amusement_park", "art_gallery", "bowling_alley", "book_store"]),
        PlacesSection(name: "health", items: ["dentist", "doctor", "spa"]),
        PlacesSection(name: "travel", items: ["airport", "bus_station", "train_station", "taxi_stand", "travel_agency"])]
    
    static let SamplePlacesPhotos = ["Varna", "Sofia", "London","Paris", "NewYork"]
}

//MARK - Storyboard IDs

struct StoryboardIDs {
    static let PlacesViewStoryboardID = "PlacesViewStoryboardID"
}

struct CellIdentifiers {
    static let placeTypeCell = "PlaceTypeCell"
    static let placeViewCell = "PlaceViewCell"
}

