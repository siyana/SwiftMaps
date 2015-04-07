//
//  PlacesSection.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 4/7/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import UIKit

class PlacesSection: NSObject {
    var sectionTitle: String
    var sectionItems: Array<String>
    
    init(name: String, items: Array<String>) {
        sectionTitle = name
        sectionItems = items
    }
}
