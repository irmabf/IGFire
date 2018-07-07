//
//  CustomImageView.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 05/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

//Dictionary with a String as the key
var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
  
  var lastURLUsedToLoadImage: String?
  
  func loadImage(urlString: String){
    
    lastURLUsedToLoadImage = urlString
    
    //    If there is a cache for the image with the key of urlString use it and avoid the URLsESSION
    if let cachedImage = imageCache[urlString] {
      self.image = cachedImage
      return
    }
    
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      if let err = err {
        print("Failed to fetch post image:", err)
        return
      }
      
      if url.absoluteString != self.lastURLUsedToLoadImage {
        return
      }
      guard let imageData = data else { return }
      
      let photoImage = UIImage(data: imageData)
      
      imageCache[url.absoluteString] = photoImage
      
      DispatchQueue.main.async {
        self.image = photoImage
      }
      }.resume()
  }
}
