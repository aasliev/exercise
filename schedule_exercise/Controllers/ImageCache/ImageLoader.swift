////
////  ImageLoader.swift
////  schedule_exercise
////
////  Created by Asliddin Asliev on 11/16/20.
////
//
//import Foundation
//import UIKit
//import Combine
//
//public final class ImageLoader {
//    public static let shared = ImageLoader()
//
//    var image : UIImage?
//    private let cache = ImageCache()
//    
//    func loadImage(withTriCode triCode: String) -> UIImage? {
//        // check if we have the image in cache
//        let urlString = "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_\(triCode.lowercased())_light.png"
//        if let image = cache[urlString as NSString] {
//            print("cache hit ---> \(triCode)  ")
//            return image
//        }
//        print("cache miss. loading image from url -----> \(triCode)")
//        return self.loadImge(withTriCode: triCode)
//
//    }
////    func loadImageFromCache(for url: String)->Bool{
////        guard  let cacheImage = cache.image(for: url) else {
////            return false
////        }
////        return true
////    }
//    
//    
//    func loadImge(withTriCode triCode: String) -> UIImage? {
//        let urlString = "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_\(triCode.lowercased())_light.png"
//        guard let url = URL(string: urlString) else {return nil}
//        DispatchQueue.global().async { [weak self] in
//        //DispatchQueue.main.async {
//               if let imageData = try? Data(contentsOf: url) {
//                   if let image = UIImage(data: imageData) {
//                       //DispatchQueue.main.async {
//                           self?.image = image
//                    self?.cache.insert(image, for: urlString)
////                        return image
//                       }
//                   }
//        }
//        if let img = image{
//            return img
//        }
//        return nil
//       }
//}
//
