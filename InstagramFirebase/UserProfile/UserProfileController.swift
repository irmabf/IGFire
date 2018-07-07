//
//  UserProfileController.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 01/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let headerId = "headerId"
  let cellId = "cellId"
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.backgroundColor = .white
    
    navigationItem.title = Auth.auth().currentUser?.uid
    
    fetchUser()
    //append .self to UICollectionViewCell gives us the class
    collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    
    collectionView?.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: cellId)
    
    setupLogOutButton()
    
//    fetchPosts()
    
    fetchOrderedPosts()
  }
  
  /***************************************************************************************************
   *Custom Functions
   ****************************************************************************************************/
  
  var posts = [Post]()
  
  fileprivate func fetchOrderedPosts() {
//    observe the child added
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let ref = Database.database().reference().child("posts").child(uid)
    ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
//        print(snapshot.key, snapshot.value)
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
      guard let user = self.user  else  { return }
     
      let post = Post(user: user, dictionary: dictionary)
      self.posts.insert(post, at: 0)
//      self.posts.append(post)
      
      self.collectionView?.reloadData()
      
    }) { (err) in
      print("Failed to fetch ordered posts:", err)
    }
  }
  
  
  fileprivate func setupLogOutButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear") .withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
  }
  
  @objc func handleLogOut() {
    let alertController = UIAlertController(title: nil, message:nil, preferredStyle: .actionSheet)
    
    alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
      
      do {
        try Auth.auth().signOut()
        //We need to present some kind of login controller
        let loginController = LoginController()
        let navController = UINavigationController(rootViewController: loginController)
        self.present(navController, animated: true, completion: nil)
        
      }catch let signOutErr {
        print("Failed to sign out:", signOutErr)
      }
      
    }))
    
    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    /*alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
      print("Cancel")
    }))*/
    present(alertController, animated: true, completion: nil)
  }
  /***************************************************************************************************
   *CollectionView cells
   ****************************************************************************************************/
  
  //numbersOfItemsInSection sets the number of items to return in the CollectionView
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }
  
  //cellForItemAt defines the cell
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath ) as! UserProfilePhotoCell
    cell.post = posts[indexPath.item]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width - 2) / 3
    return CGSize(width: width, height: width)
    
  }
  

  /*************************************************************
   *CollectionView Header
   *************************************************************
    **/
  //referenceSizeForHeaderInSection gives the size to the header in the collection view
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! UserProfileHeader
    
    header.user = self.user
    
    return header
  }

  
  var user: User?
  
  fileprivate func fetchUser() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      print(snapshot.value ?? "")
      
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
      self.user = User(dictionary: dictionary)
      
      self.navigationItem.title = self.user?.username
      
      self.collectionView?.reloadData()
      
    }) { (err) in
      print("Failed to fetch user:", err)
    }
  }
}




















