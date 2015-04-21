//
//  FivePxDataProvider.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 4/9/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import Foundation

class FivePxDataProvider: NSObject {
    
    var photoTask = NSURLSessionDataTask()
    var session: NSURLSession {
        return NSURLSession.sharedSession()
    }
    
    func fetchPhotos(photoTag: String, completion: (([String])? -> Void)) -> ()  {
        let urlString = "https://api.500px.com/v1/photos/search?feature=fresh_today&image_size=600&sort=created_at&include_states=voted&only=Nature&exclude=Nude&tag="+photoTag+"&consumer_key=" + GlobalConstants.fivePxApiKey
        
        if photoTask.taskIdentifier > 0 && photoTask.state == .Running {
            photoTask.cancel()
        }
        
        if let url = NSURL(string: urlString){
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            photoTask = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if data != nil && response != nil {
                    completion(self.parseResponseData(data))
                } else {
                    completion(nil)
                }
                
            })
            
            photoTask.resume()
        }
    }
    
    private func parseResponseData(data: NSData) -> ([String]){
        var imagesUrlArray = [String]()
        
        if let json = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:nil) as? NSDictionary {
            if let photoArray = json["photos"] as? NSMutableArray {
                for photo:AnyObject in photoArray {
                    if let photoDict = photo as? NSDictionary {
                        if let photoUrl = photoDict["image_url"] as? String {
                            if !photoUrl.isEmpty {
                                imagesUrlArray.append(photoUrl)
                            }
                        }
                    }
                }
            }
        }
        return imagesUrlArray
    }
}
