//
//  URLImageModel.swift
//  schedule_exercise
//
//  Created by Asliddin Asliev on 11/17/20.
//
import SwiftUI

class URLImageModel: ObservableObject {
    @Published var image : UIImage?
    let triCode : String
    let urlString : String
    
    init(triCode : String) {
        self.triCode = triCode
        self.urlString = "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_\(triCode.lowercased())_light.png"
        print("init for \(triCode)")
        loadImage()
    }
    
    func loadImage() {
//           if loadImageFromCache() {
//               print("Cache hit")
//               return
//           }
           
           //print("Cache miss, loading from url")
           loadImageFromUrl()
       }
    
    func loadImageFromUrl() {
        //let urlString = "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_\(triCode.lowercased())_light.png"
        guard let url = URL(string: urlString) else {return}
           DispatchQueue.global().async { [weak self] in
               if let imageData = try? Data(contentsOf: url) {
                   if let image = UIImage(data: imageData) {
                       DispatchQueue.main.async {
                        print("success: image is set")
                           self?.image = image
                       }
                   }
               }
           }
       }
    
//    func loadImageFromUrl() {
//            let url = URL(string: urlString)!
//            let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
//            task.resume()
//        }
//
//    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
//            guard error == nil else {
//                print("Error: \(error!)")
//                return
//            }
//            guard let data = data else {
//                print("No data found")
//                return
//            }
//
//            DispatchQueue.main.async {
//                print("check")
//                guard let loadedImage = UIImage(data: data) else {
//                    return
//                }
//
////                self.imageCache.set(forKey: self.urlString!, image: loadedImage)
//                self.image = loadedImage
//            }
//        }
}
