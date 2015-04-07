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
    @IBOutlet weak var addImageView: UIImageView!
    
    override func awakeFromNib() {
        self.addImageView.alpha = 0
    }
    
    override func prepareForReuse() {
        self.addImageView.alpha = 0
        self.layer.borderWidth = 2.0
        self.isSelected = false
    }
    
    var isSelected = false
    
    private var randomColor: UIColor {
        get {
            let randomRed = CGFloat(drand48())
            let randomGreen = CGFloat(drand48())
            let randomBlue = CGFloat(drand48())
            return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.2)
        }
    }
    
    func selectCell() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.layer.borderWidth = 4.0
            self.addImageView.alpha = 1
        })
        self.isSelected = true
    }
    
    func deselectCell(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.layer.borderWidth = 2.0
            self.addImageView.alpha = 0
        })
        self.isSelected = false
    }
}
