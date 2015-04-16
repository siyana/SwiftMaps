//
//  PlacesImagesCollectionViewController.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 4/8/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import UIKit

let cellIdentifier = "PlacesImagesCell"

class PlacesImagesCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: UICollectionViewDataSource
    
    var presenter: UIViewController = UIViewController()
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return GlobalConstants.SamplePlacesPhotos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as PlaceImageCollectionViewCell
        
        cell.imageView.image = UIImage(named: GlobalConstants.SamplePlacesPhotos[indexPath.row])
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var size:CGSize = CGSizeZero
        if let image = UIImage(named: GlobalConstants.SamplePlacesPhotos[indexPath.row]) {
            size = CGSizeMake(image.size.width, collectionView.frame.size.height)
        }
        
        return size
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("tap")
        let searchedTag = GlobalConstants.SamplePlacesPhotos[indexPath.row] as String
        if !searchedTag.isEmpty {
            FivePxDataProvider().fetchPhotos(searchedTag, completion: { photos in
                if photos != nil {
                   self.presentViewsViewController(photos!, tag: searchedTag)
                }
            })
        }
        
    }
    
    func presentViewsViewController(photoUrls: [String], tag: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let placesViewVC = storyboard.instantiateViewControllerWithIdentifier(StoryboardIDs.PlacesViewStoryboardID) as? PlacesViewCollectionViewController {
            placesViewVC.photosUrls = photoUrls
            placesViewVC.photosTag = tag
            let navigationController = UINavigationController(rootViewController: placesViewVC)
            presenter.presentViewController(navigationController, animated: true, completion: nil)
        }
        

    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
}
