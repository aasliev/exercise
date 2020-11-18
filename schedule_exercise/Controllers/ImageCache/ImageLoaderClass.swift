//
//  ImageLoaderClass.swift
//  schedule_exercise
//
//  Created by Asliddin Asliev on 11/18/20.
//

import SwiftUI

class ImageLoaderClass: UIImageView{
    
    private let cache = ImageCache()
    var imageUrlString : String?

    func loadImage(fromUrl urlString : String){
        imageUrlString = urlString
        if let cacheImage = cache[urlString as NSString] {
            self.image = cacheImage
            return
        }
        self.loadImageFromURL(fromUrl: urlString)

    }
    
    func loadImageFromURL(fromUrl urlString:String){
        guard let url = URL(string: urlString) else {return}
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        if(self?.imageUrlString! == urlString){
                            self?.image = loadedImage
                        }
                        self?.cache.insert(loadedImage, for: urlString)
                    }
                }
            }
        }
    }
}
