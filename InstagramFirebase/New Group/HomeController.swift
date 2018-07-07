//
//  HomeController.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 07/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let cellId = "cellId"
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView?.backgroundColor = .white
    
//1.    Register ne cell for collection view
    collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
    
    setupNavigationItems()
    
    fetchPosts()
  }
//2.  Override numberOfItemsInSection to return the number of cells
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }
//3  Override cellForItemAt to return a dequereusable cell
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
    cell.post = posts[indexPath.item]
    return cell
  }
//  4. Conform to protocol UICollectionViewDelegateViewFlowLayout and implement sizeForItemAt
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var height: CGFloat = 40 + 8 + 8
    height += view.frame.width
    height += 50
    height += 120
    return CGSize(width: view.frame.width, height: height)
  }
  
  fileprivate func setupNavigationItems() {
    navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2") )
  }
  
  var posts = [Post]()
  
  fileprivate func fetchPosts() {
    guard let uid =  Auth.auth().currentUser?.uid  else { return }
    
    let ref = Database.database().reference().child("posts").child(uid)
    
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      //      print(snapshot.value)
      //      Firebase gives as a dictiomnary, snapshot
      //      We bind this snapshot.value into a dictionaries
      guard let dictionaries = snapshot.value as? [String: Any] else { return }
      //      Now we can access dictionaries key values with a foreach
      //      Foreach iterates to each dictionary and its key and gives as the key and the value
      dictionaries.forEach({ (key, value) in
        //        print("Key \(key), Value: \(value)")
        /*
         **
         *Now that we have keys and values at our disposal, we can use value to get
         the imageUrl out.
         */
        
        guard let dictionary = value as? [String: Any] else { return }
        
        //        let imageUrl =  dictionary["imageUrl"] as? String
        
        //        print("ImageUrl: \(imageUrl)")
        
        let post = Post(dictionary: dictionary)
        
        //        print(post.imageUrl)
        
        self.posts.append(post)
        
      })
      
      self.collectionView?.reloadData()
      
    }) { (err) in
      print("Failed to fetch posts:", err)
    }
    
  }

  }
