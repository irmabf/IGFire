//
//  Post.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 05/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import Foundation

struct Post {
  let imageUrl: String
  
  init(dictionary: [String: Any]) {
    self.imageUrl = dictionary["imageUrl"] as? String ?? ""
  }
}
