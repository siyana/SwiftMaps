//
//  ChoosePlacesCollectionViewController.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 4/6/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import UIKit

let reuseIdentifier = "PlaceTypeCell"

protocol ChoosePlacesCollectionViewControllerDelegate {
    func choosenPlaces(places: Array<String>, sender: AnyObject) -> Void
}

class ChoosePlacesCollectionViewController: UICollectionViewController {
    
    var delegate: ChoosePlacesCollectionViewControllerDelegate?
    var choosenPlaces: [String: Bool] = Dictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewDidDisappear(animated: Bool) {
        var placesArray:Array<String> = []
        if choosenPlaces.isEmpty {
            placesArray = []
        } else {
            for (key,value) in choosenPlaces {
                if value == true {
                    placesArray.append(key)
                }
            }
        }
        
        delegate?.choosenPlaces(placesArray, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return GlobalConstants.DefaulPlacesTypes.count
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var sectionitems = GlobalConstants.DefaulPlacesTypes[section] as PlacesSection
        return sectionitems.sectionItems.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as PlaceTypeCollectionViewCell
        
        var placesDict = GlobalConstants.DefaulPlacesTypes[indexPath.section] as PlacesSection
        var placeType =  placesDict.sectionItems[indexPath.row] as String
        
        cell.placeInfoImage.image =  UIImage(named: placeType + "_pin")
        cell.placeInfoLabel.text = placeType.capitalizedString
        
        if choosenPlaces[placeType.lowercaseString] == true {
            cell.selectCell()
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var headerView: PlacesCollectionHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "PlacesHeaderView", forIndexPath: indexPath) as PlacesCollectionHeaderView
        
        headerView.titlelabel.text = GlobalConstants.DefaulPlacesTypes[indexPath.section].sectionTitle.uppercaseString
        
        
        return headerView
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as PlaceTypeCollectionViewCell
        if cell.isSelected {
            cell.deselectCell()
            
            choosenPlaces[cell.placeInfoLabel.text!.lowercaseString] = false
        } else {
            cell.selectCell()
            choosenPlaces[cell.placeInfoLabel.text!.lowercaseString] = true
        }
        
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
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
