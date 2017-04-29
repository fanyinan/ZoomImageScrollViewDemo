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
    
    view.backgroundColor = UIColor.groupTableViewBackground
    
    let layout = UICollectionViewFlowLayout()
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.black
    collectionView.register(UINib(nibName: identifierCell, bundle: nil), forCellWithReuseIdentifier: identifierCell)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    view.addSubview(collectionView)
    
  }
  
}



extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageCount
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath) as! VisitedMeCollectionViewCell
    
    cell.avatarImageView.image = UIImage(named: "image\(indexPath.row)")
    
    return cell
  }
  
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    var width: CGFloat = 0
    width = (view.frame.width - CGFloat(numOfCol - 1) * hSpace) / CGFloat(numOfCol)
    
    imageWidth = width
    let size = CGSize(width: width, height: width)
    
    return size
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return vSpace
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
}

extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard let image = UIImage(named:"image\(indexPath.row)") else { return }
    
    let vc = ImageDisplayViewController(image: image)
    present(vc, animated: false, completion: nil)
  }
  
}
