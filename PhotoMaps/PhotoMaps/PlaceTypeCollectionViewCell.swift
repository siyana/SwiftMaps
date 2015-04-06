//
//  PlaceTypeCollectionViewCell.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 4/6/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import UIKit

class PlaceTypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var placeInfoImage: UIImageView! {
        didSet {
            self.backgroundColor = randomColor
            self.layer.borderColor = randomColor.CGColor
            self.layer.borderWidth = 2.0
        }
    }
    @IBOutlet weak var placeInfoLabel: UILabel!
    
    private var randomColor: UIColor {
        get {
            let randomRed = CGFloat(drand48())
            let randomGreen = CGFloat(drand48())
            let randomBlue = CGFloat(drand48())
            return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.2)
        }
    }

}
