//
//  ViewController.swift
//  ZoomImageScrollViewDemo
//
//  Created by 范祎楠 on 16/8/5.
//  Copyright © 2016年 范祎楠. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var imageWidth: CGFloat!

  var collectionView: UICollectionView!
  var identifierCell = "VisitedMeCollectionViewCell"
  let vSpace: CGFloat = 10
  let hSpace: CGFloat = 10
  let numOfCol = 4
  let imageCount = 3
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initView()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func initView(){
    
    title = "PhotoBrowser"
    
    view.backgroundColor = UIColor.groupTableViewBackgroundColor()
    
    let layout = UICollectionViewFlowLayout()
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.blackColor()
    collectionView.registerNib(UINib(nibName: identifierCell, bundle: nil), forCellWithReuseIdentifier: identifierCell)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    
    view.addSubview(collectionView)
    
  }
  
}



extension ViewController: UICollectionViewDataSource {
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageCount
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifierCell, forIndexPath: indexPath) as! VisitedMeCollectionViewCell
    
    cell.avatarImageView.image = UIImage(named: "image\(indexPath.row)")
    
    return cell
  }
  
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    var width: CGFloat = 0
    width = (view.frame.width - CGFloat(numOfCol - 1) * hSpace) / CGFloat(numOfCol)
    
    imageWidth = width
    let size = CGSize(width: width, height: width)
    
    return size
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return vSpace
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 0
  }
  
}

extension ViewController: UICollectionViewDelegate {
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    guard let image = UIImage(named:"image\(indexPath.row)") else { return }
    
    let vc = ImageDisplayViewController(image: image)
    presentViewController(vc, animated: false, completion: nil)
  }
  
}
