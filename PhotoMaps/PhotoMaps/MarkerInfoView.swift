//
//  MarkerInfoView.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 4/3/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import Foundation

class MarkerInfoView: UIView {
    @IBOutlet weak var placePhoto: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var photoTopConstraint: NSLayoutConstraint!
    
    var image : UIImage? {
        get {
            return placePhoto.image
        }
        
        set {
            placePhoto.image = newValue
            if let constrainedView = placePhoto {
                if let newImage = newValue {
                    self.frame.size.width = newImage.size.width
                    
                    aspectRationConstained = NSLayoutConstraint(item: constrainedView,
                        attribute: .Height,
                        relatedBy: .Equal,
                        toItem: constrainedView,
                        attribute: .Width,
                        multiplier: newImage.aspectRatio,
                        constant: 0)
                    
                    self.frame.size.height = newImage.aspectRatio * constrainedView.frame.size.width + photoTopConstraint.constant
                    
                    layoutIfNeeded()
                } else {
                    aspectRationConstained = nil
                }
            }
        }
    }
    
    var aspectRationConstained: NSLayoutConstraint? {
        willSet {
            if let existingConstraint = aspectRationConstained {
                self.removeConstraint(existingConstraint)
            }
        }
        didSet {
            if let newConstraint = aspectRationConstained {
                self.addConstraint(newConstraint)
            }
        }
    }
}


extension UIImage {
    var aspectRatio : CGFloat {
        return size.height != 0 ? size.height / size.width : 0
    }
}
