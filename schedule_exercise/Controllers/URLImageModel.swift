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
        self.urlString = "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_\(triCode)_light.png"
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
            let url = URL(string: urlString)!
            let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
            task.resume()
        }
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            guard let data = data else {
                print("No data found")
                return
            }
            
            DispatchQueue.main.async {
                guard let loadedImage = UIImage(data: data) else {
                    return
                }
                
//                self.imageCache.set(forKey: self.urlString!, image: loadedImage)
                self.image = loadedImage
            }
        }
}
