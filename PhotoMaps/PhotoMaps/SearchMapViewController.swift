//
//  SearchMapViewController.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 4/8/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import UIKit

class SearchMapViewController: MapViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelBarButtonItemTapped:")
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    func cancelBarButtonItemTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
