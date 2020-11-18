//
//  ImageCache.swift
//  schedule_exercise
//
//  Created by Asliddin Asliev on 11/16/20.
//

import Foundation
import UIKit

protocol ImageCacheType: class {
    // get image for url
    func image(for url: String) -> UIImage?
    
    //insert image for url
    func insert(_ image: UIImage?, for url : String)
    
    //delete image for url
    func removeImage(for url: String)
    
    // subscript
    subscript(_ url : NSString) -> UIImage?{get set}
    
}

class ImageCache : ImageCacheType {
   
    //create cache that will hold images
    private lazy var imageCache : NSCache<NSString, UIImage > = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = cacheCountLimit
        return cache
    }()
    
    private let cacheCountLimit: Int
    
    init(countLimit: Int = 20) {
        self.cacheCountLimit = countLimit
    }
    
    func image(for url: String) -> UIImage? {
        //
        if let image = imageCache.object(forKey: url as NSString) {
            return image
        }
        return nil
    }
    
    func insert(_ image: UIImage?, for url: String) {
        //
        guard let image = image else {
            return removeImage(for: url)
        }
        
        imageCache.setObject(image, forKey: url as NSString)
    }
    
    func removeImage(for url: String) {
        //
        imageCache.removeObject(forKey: url as NSString)
    }
    
    // subscript
    subscript(url: NSString) -> UIImage? {
        get{
            return image(for: url as String)
        } set {
            return insert(newValue, for: url as String)
        }
    }
    
    
}
