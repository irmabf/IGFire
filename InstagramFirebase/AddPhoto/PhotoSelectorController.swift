//
//  PhotoSelectorController.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 03/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import Photos
/*
 *Steps to create a Custom Cell in a CollectionView
 *1. Conform to UICollectionViewController and Register the Cell in viewDidLoad
 ex: collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
 *2. Implement the numberOfItemsInSection method returning the number of cells
 *3. Implement the cellForItemAtIndexPath method returning the kind of cell we want
      In this method we need to dequeue the cell with collectionView.dequeueReusableCell
 *4.Conform to UICollectionViewDelegateFlowLayout and add the sizeForItemAt indexpath method
 *5. Now we need the methods to reduce the spacing in the cells, wich are:
    5. a) minimumLineSpacingForSectionAt
    5. b) minimumInteritemSpacingForSectionAt
 **/

/**
 *For Add a customHeader to the collectionView:
 *1. Register the header in viewDidLoad collectionView?.register(UICollectionViewCell.self,
      forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,withReuseIdentifier: headerId)
 *2. Implement method viewForSupplementaryElementOfKind:
      override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
      at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        return header
        }
 *3. Give a referenceSize to the header by adding the method referenceSizeForHeaderInSection
 */

/**
 *Finally, in this case we are given a padding below the header with the method: insetForSectionAt
 
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int)  -> UIEdgeInsets {
      return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
 */
class PhotoSelectorController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let cellId = "cellId"
  let headerId = "headerId"
  let creationDate = "creationDate"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView?.backgroundColor = .white
    
    setupNavigationButtons()
    
//    register the cell for the collection view
    collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
    collectionView?.register(PhotoSelectorHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                             withReuseIdentifier: headerId)
    
    fetchPhotos()
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.selectedImage = images[indexPath.item]
//    I need to reload data in the collection view to rerender the header
    self.collectionView?.reloadData()
  }
  
  
  var selectedImage: UIImage?
  var images = [UIImage]()
  var assets = [PHAsset]()
  
  fileprivate func assetsFetchOptions() -> PHFetchOptions {
    let fetchOptions = PHFetchOptions()
    fetchOptions.fetchLimit = 15
    let sortDescriptor = NSSortDescriptor(key: creationDate, ascending: false)
    fetchOptions.sortDescriptors = [sortDescriptor]
    return fetchOptions
  }
  
  fileprivate func fetchPhotos() {
    
    let allPhotos = PHAsset.fetchAssets(with: .image, options: assetsFetchOptions())
    
    DispatchQueue.global(qos: .background).async {
      allPhotos.enumerateObjects( { (asset, count, stop) in

        let imageManager = PHImageManager.default()
        let targetSize = CGSize(width: 200, height: 200)
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        
        imageManager.requestImage(for: asset, targetSize: targetSize,
                                  contentMode: .aspectFit, options: options,resultHandler:
          { (image, info) in
            if let image = image {
              self.images.append(image)
              self.assets.append(asset)
              
              if self.selectedImage == nil {
                self.selectedImage = image
              }
            }
            if count == allPhotos.count - 1 {
//              go back on the main thread
              DispatchQueue.main.async {
                 self.collectionView?.reloadData()
              }
            }
        
        })
      })
    }
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PhotoSelectorHeader
    
    header.photoImageView.image = selectedImage
    
    if let selectedImage = selectedImage {
      if let index = self.images.index(of: selectedImage) {
        let selectedAsset = self.assets[index]
        let imageManager = PHImageManager.default()
        let targetSize = CGSize(width: 600, height: 600)
        imageManager.requestImage(for: selectedAsset, targetSize: targetSize, contentMode: .default, options: nil) {
          (image, info) in
          
            header.photoImageView.image = image
        }
      }
    }
    
    return header
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let width = view.frame.width
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
    cell.photoImageView.image = images[indexPath.item]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    Each of the cells in width will be the entire width of the row divided by for because I want 4 cells in each row
    let width = (view.frame.width  - 3) / 4
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
//  hide status bar
  override var prefersStatusBarHidden: Bool {
    return true
  }
  fileprivate func setupNavigationButtons() {
    navigationController?.navigationBar.tintColor = .black
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
  }
  
  @objc func handleNext() {
    print("handle next")
  }
  
  @objc func handleCancel() {
    dismiss(animated: true, completion: nil)
  }
}
