//
//  Post.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 05/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import Foundation

struct Post {
  let user: User
  let imageUrl: String
  let caption: String
  
  init(user: User, dictionary: [String: Any]) {
    self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    self.user = user
    self.caption = dictionary["caption"] as? String ?? ""
  }
}
