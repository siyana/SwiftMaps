//
//  HomeScreenTableViewController.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 4/8/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import UIKit

struct CellHeigh {
    static let LandscapeCellHeigh:CGFloat = 105
    static let PortraitCellHeigh:CGFloat = 165
}

class HomeScreenTableViewController: UITableViewController {

    @IBOutlet weak var placesImagesCollectionView: UICollectionView!
    
    let collectionViewController = PlacesImagesCollectionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
        
        collectionViewController.presenter = self
        self.placesImagesCollectionView.delegate = collectionViewController
        self.placesImagesCollectionView.dataSource = collectionViewController
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    //MARK: Table View Delegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var result: CGFloat
        switch UIDevice.currentDevice().orientation{
        case .LandscapeLeft,
         .LandscapeRight:
            result = CellHeigh.LandscapeCellHeigh
        default:
            result = CellHeigh.PortraitCellHeigh
        }
        return result
    }

}
